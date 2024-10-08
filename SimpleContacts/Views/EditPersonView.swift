//
//  EditPersonView.swift
//  SimpleContacts
//
//  Created by Dominic Teh on 6/10/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPersonView: View {
  @Environment(\.modelContext) var modelContext
  @Bindable var person: Person
  @State private var selectedItem: PhotosPickerItem?
  
  var body: some View {
    Form {
      Section("Photo") {
        if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .frame(height: 200) // Set the desired height
        }
        
        // Photo selection
        PhotosPicker(selection: $selectedItem, matching: .images) {
          Label("Select a photo", systemImage: "person")
        }
        .onChange(of: selectedItem) { newItem in
          // Retrieve selected asset
          Task {
            if let newItem = newItem {
              // Fetch the data from the selected item
              if let data = try? await newItem.loadTransferable(type: Data.self) {
                person.photo = data  // Set the photo data to the person
              }
            }
          }
        }
      }
      
      Section("Information") {
        TextField("Name", text: $person.name)
          .textContentType(.name)
        TextField("Email", text: $person.email)
          .textContentType(.emailAddress)
      }
      
      Section("Details") {
        TextField("Details", text: $person.details)
      }
    }
    .navigationTitle("Edit Person")
    .navigationBarTitleDisplayMode(.inline)
  }
}

//#Preview {
//    EditPersonView()
//}
