//
//  User.swift
//  Preface
//
//  Created by Scotty Schwartz-Owen on 10/22/24.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
	var id: String
	var name: String
	var imageURL: URL?
}

extension User {
	static let testUser = User(
		id: "",
		name: "Jonas Schwartz",
		imageURL: URL(string: "https://source.unsplash.com/lw9LrnpUmWw/480x480")
	)
}
