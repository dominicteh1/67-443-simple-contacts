//
//  SimpleContactsApp.swift
//  SimpleContacts
//
//  Created by Dominic Teh on 6/10/24.
//

import SwiftUI
import SwiftData

@main
struct SimpleContactsApp: App {
  var body: some Scene {
    WindowGroup {
      AppView()
    }
    .modelContainer(for: Person.self)
  }
}
