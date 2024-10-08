//
//  PeopleView.swift
//  SimpleContacts
//
//  Created by Dominic Teh on 6/10/24.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
  @Environment(\.modelContext) var modelContext
  @Query var people: [Person]
  
  var searchString: String
  var sortOrder: [SortDescriptor<Person>] = []
  
  var body: some View {
    List {
      ForEach(people) { person in
        NavigationLink(value: person) {
          Text(person.name)
        }
      }
      .onDelete(perform: deletePeople)  // Enable deletion
    }
  }
  
  init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
    self.searchString = searchString
    self.sortOrder = sortOrder
    
    _people = Query(filter: #Predicate { person in
      if searchString.isEmpty {
        return true
      } else {
        return person.name.localizedStandardContains(searchString)
      }
    }, sort: sortOrder)  // Apply sorting
  }
  
  // Function to delete people from the list
  func deletePeople(at offsets: IndexSet) {
    for offset in offsets {
      let person = people[offset]
      modelContext.delete(person)
    }
  }
}

//#Preview {
//    PeopleView()
//}
