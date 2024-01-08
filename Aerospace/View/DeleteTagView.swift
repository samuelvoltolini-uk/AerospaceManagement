import SwiftUI

struct DeleteTagView: View {
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
                        .frame(width: 600, height: 600)
                    Text("Nothing to see here!")
                        .font(.headline)
                }

            } else {
                // List view when there are tags
                List {
                    ForEach(fulltags, id: \.id) { tag in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "tag.square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(colorFromString(tag.imageName)) // Use a custom function to convert string to Color
                                
                                Text(tag.name)
                                    .font(.headline)
                            }
                            .padding(.top, 5)

                            HStack {
                                Image(systemName: "info.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text(tag.description)
                                    .font(.subheadline)
                            }
                            .padding(.top, 5)
                        }
                    }
                    .onDelete(perform: deleteTag)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationTitle("Delete Tags")
        .onAppear {
            fulltags = databaseManager.fetchAllTags()
        }
    }
    
    private func colorFromString(_ colorName: String) -> Color {
        switch colorName.lowercased() {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        // Add more cases as needed
        default: return .gray // Default color
        }
    }

    private func deleteTag(at offsets: IndexSet) {
        offsets.forEach { index in
            let tagId = fulltags[index].id
            databaseManager.deleteTag(withId: tagId)
        }
        fulltags.remove(atOffsets: offsets)
    }
}

#Preview {
    DeleteTagView()
}
