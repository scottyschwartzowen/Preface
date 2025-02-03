//
//  PrefaceApp.swift
//  Preface
//
//  Created by Scotty Schwartz-Owen on 10/8/24.
//

import SwiftUI
import Firebase

@main
struct PrefaceApp: App {
	init() {
		FirebaseApp.configure()
	}
    var body: some Scene {
        WindowGroup {
					AuthView()
        }
    }
}
