//
//  NewPostForm.swift
//  Preface
//
//  Created by Scotty Schwartz-Owen on 10/9/24.
//

import SwiftUI

// MARK: - NewPostForm

struct NewPostForm: View {
	@StateObject var viewModel: FormViewModel<Post>
	@Environment(\.dismiss) private var dismiss

	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Title", text: $viewModel.title)
				}
				ImageSection(imageURL: $viewModel.imageURL)
				Section("Content") {
					TextEditor(text: $viewModel.content)
						.multilineTextAlignment(.leading)
				}
				Button(action: viewModel.submit) {
					if viewModel.isWorking {
						ProgressView()
					} else {
						Text("Create Post")
					}
				}
				.font(.headline)
				.frame(maxWidth: .infinity)
				.foregroundColor(.white)
				.padding()
				.listRowBackground(Color.accentColor)
			}
			.onSubmit(viewModel.submit)
			.navigationTitle("New Post")
		}
		.alert("Cannot Create Post", error: $viewModel.error)
		.disabled(viewModel.isWorking)
		.task {
			await monitorIsWorking()
		}
	}

	private func monitorIsWorking() async {
		for await isWorking in viewModel.$isWorking.values {
			guard !isWorking else { continue }
			dismiss()
		}
	}
}

// MARK: - ImageSection

private extension NewPostForm {
	struct ImageSection: View {
		@Binding var imageURL: URL?

		var body: some View {
			Section("Image") {
				AsyncImage(url: imageURL) { image in
					image
						.resizable()
						.scaledToFit()
						.clipShape(RoundedRectangle(cornerRadius: 10))
				} placeholder: {
					EmptyView()
				}
				ImagePickerButton(imageURL: $imageURL) {
					Label("Choose Image", systemImage: "photo.fill")
				}
			}
		}
	}
}

// MARK: - Preview

struct NewPostForm_Previews: PreviewProvider {
	static var previews: some View {
		NewPostForm(viewModel: FormViewModel<Post>(initialValue: Post.testPost, action: { _ in }))
	}
}

