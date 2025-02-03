//
//  Comment.swift
//  Preface
//
//  Created by Scotty Schwartz-Owen on 10/25/24.
//

import Foundation

struct Comment: Identifiable, Equatable, Codable {
	var content: String
	var author: User
	var timestamp = Date()
	var id = UUID()
}

extension Comment {
	static let testComment = Comment(content: "Test comment", author: User.testUser)
}
