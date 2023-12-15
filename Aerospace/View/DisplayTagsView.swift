import SwiftUI

struct DisplayTagsView: View {
    @State private var fulltags: [FullTag] = []
    let databaseManager = DatabaseManager()
    
    var body: some View {
        NavigationView {
            if fulltags.isEmpty {
                // Display when there are no tags
                VStack {
                    Image("NothingHere") // Replace with your 'Nothing to see here' image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Nothing to see here!")
                        .font(.headline)
                }
                
            } else {
                // List view when there are tags
                List(fulltags, id: \.id) { tag in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(tag.imageName)
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(tag.name)
                                .font(.headline)
                        }
                        .padding(.top, 5)
                        HStack {
                            Image("TagInformation")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(tag.description)
                                .font(.subheadline)
                        }
                        .padding(.top, 5)
                        HStack {
                            Image("UserInformation")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Created by: \(tag.creatorName)")
                                .font(.subheadline)
                        }
                        .foregroundStyle(Color.gray)
                        .padding(.top, 5)
                        HStack {
                            Image("TagCreated")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Created: \(tag.creationDateFormatted)")
                                .font(.subheadline)
                        }
                        .foregroundStyle(Color.gray)
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Tags Overview")
        .onAppear {
            fulltags = databaseManager.fetchAllTags()
        }
    }
}

extension FullTag {
    var creationDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: creationDate)
    }
}

#Preview {
    DisplayTagsView()
}
