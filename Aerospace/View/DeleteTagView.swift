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
                        .frame(width: 300, height: 300)
                    Text("Nothing to see here!")
                        .font(.headline)
                }

            } else {
                // List view when there are tags
                List {
                    ForEach(fulltags, id: \.id) { tag in
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
                        }
                    }
                    .onDelete(perform: deleteTag)
                }
            }
        }
        .navigationTitle("Delete Tags")
        .onAppear {
            fulltags = databaseManager.fetchAllTags()
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
