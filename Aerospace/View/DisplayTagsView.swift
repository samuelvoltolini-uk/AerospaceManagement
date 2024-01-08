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
                        .frame(width: 600, height: 600)
                    Text("Nothing to see here!")
                        .font(.headline)
                }
                
            } else {
                // List view when there are tags
                List(fulltags, id: \.id) { tag in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "tag.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(colorFromString(tag.imageName))

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
                        HStack {
                            Image(systemName:  "person.text.rectangle.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            Text("Created by: \(tag.creatorName)")
                                .font(.subheadline)
                        }
                        .foregroundStyle(Color.gray)
                        .padding(.top, 5)
                        HStack {
                            Image(systemName:  "clock.arrow.2.circlepath")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
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
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationTitle("Tags Overview")
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
