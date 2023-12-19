import SwiftUI

struct DeleteItemView: View {
    @State private var items: [ItemFetch] = [] // Assuming ItemFetch is your item model
    @State private var searchText = ""
    
    let databaseManager = DatabaseManager()

    var filteredItems: [ItemFetch] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.barcode.contains(searchText) }
        }
    }

    var body: some View {
        VStack {
            if filteredItems.isEmpty {
                emptyView
            } else {
                List {
                    ForEach(filteredItems, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "info.square.fill") // Icon for item name
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.accentColor)
                                    Text(item.name)
                                        .font(.footnote)
                                }

                                HStack {
                                    Image(systemName: "barcode.viewfinder") // Icon for barcode
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.accentColor)
                                    Text(item.barcode)
                                        .font(.footnote)
                                }

                                // Add more details with icons as needed
                            }
                            Spacer()
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .searchable(text: $searchText, prompt: "Search by Name or Barcode")
            }
        }
        .navigationBarTitle("Delete Items", displayMode: .inline)
        .onAppear {
            fetchItems()
        }
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text("Nothing to see here!")
                .font(.headline)
        }
    }

    private func fetchItems() {
        items = databaseManager.fetchAllItems()
    }

    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = filteredItems[index]
            databaseManager.deleteItem(item.id)
        }
        fetchItems() // Refresh the list after deletion
    }
}

#Preview {
    DeleteItemView()
}
