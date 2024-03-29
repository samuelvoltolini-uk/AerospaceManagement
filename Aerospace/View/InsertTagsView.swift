import SwiftUI

struct InsertTagsView: View {
    
    @State private var existingTags = [Tag]()
    
    @State private var tagName: String = ""
    @State private var tagDescription: String = ""
    @State private var selectedImageName: String = "Blue"
    
    @State private var isCreatingTag: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let allPossibleImages = ["Blue", "Yellow", "Green", "Pink", "Red"]
    var tagImages: [String] {
        allPossibleImages.filter { imageName in
            !existingTags.contains { $0.imageName == imageName }
        }
    }
    
    let databaseManager = DatabaseManager()
    let loggedInUser: User
    
    var body: some View {
        Form {
            Section(header: SectionHeaderView(text: "Tag Information", imageName: "tag.square.fill")) {
                TextField("Name", text: $tagName)
                    .textInputAutocapitalization(.words)
                
                TextField("Description", text: $tagDescription)
                    .textInputAutocapitalization(.sentences)
            }
            
            Section(header: SectionHeaderView(text: "Tag Image", imageName: "photo.fill")) {
                Picker("Tag Image", selection: $selectedImageName) {
                    ForEach(tagImages, id: \.self) { imageName in
                        Text(imageName)
                            .disabled(existingTags.contains { $0.imageName == imageName })
                    }
                }
                Image(selectedImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            }
            
            Section(header: SectionHeaderView(text: "User Information", imageName: "person.text.rectangle.fill")) {
                HStack {
                    Text("User")
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Text(loggedInUser.name)
                        .foregroundStyle(Color.gray)
                }
                .disabled(true)
                
                HStack {
                    Text("Creation Date")
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Text(currentDateString)
                        .foregroundStyle(Color.gray)
                }
                .disabled(true)
            }
            
            Section(header: SectionHeaderView(text: "Existing Tags", imageName: "number.square.fill")) {
                HStack {
                    Text("Total Tags: \(existingTags.count)")
                        .foregroundStyle(Color.gray)
                }
                .disabled(true)
            }
            
            Button(action: createTag) {
                if isCreatingTag {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.accentColor)
                } else {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.accentColor)
                        .fontWeight(.semibold)
                }
            }
        }
        .navigationTitle("Create Tag")
        .onAppear {
            databaseManager.createTagsTable()
            existingTags = databaseManager.fetchTagsInfo()
            if let firstAvailableImage = tagImages.first {
                selectedImageName = firstAvailableImage
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    private var currentDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    private func createTag() {
        guard !tagName.isEmpty, !tagDescription.isEmpty, existingTags.count < 5,
              !existingTags.contains(where: { $0.name == tagName }) else {
            alertMessage = tagName.isEmpty || tagDescription.isEmpty ?
            "Please fill in all fields." : "A tag with this name already exists."
            showAlert = true
            return
        }
        
        isCreatingTag = true
        
        let newTag = Tag(name: tagName, description: tagDescription, imageName: selectedImageName, creatorName: loggedInUser.name, creationDate: Date())
        
        databaseManager.addTag(tag: newTag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isCreatingTag = false
            tagName = ""
            tagDescription = ""
            selectedImageName = ""
            existingTags = databaseManager.fetchTagsInfo()
        }
    }
}

struct SectionHeaderView: View {
    var text: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            Text(text)
        }
    }
}

struct InsertTagsView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a mock user for preview purposes
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertTagsView(loggedInUser: mockUser)
    }
}
