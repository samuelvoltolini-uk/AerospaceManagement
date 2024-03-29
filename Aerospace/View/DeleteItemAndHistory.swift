import SwiftUI


struct DeleteItemAndHistory: View {
    @State private var items: [ItemFetch] = []
    @State private var searchText = ""
    @State private var showConfirmationDialog = false
    @State private var itemToDelete: ItemFetch?

    let databaseManager = DatabaseManager()

    private var filteredItems: [ItemFetch] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                item.name.lowercased().contains(searchText.lowercased()) ||
                item.barcode.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        List {
            if filteredItems.isEmpty {
                emptyView
            } else {
                ForEach(filteredItems, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "info.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                Text(item.name)
                                    .font(.footnote)
                            }

                            HStack {
                                Image(systemName: "barcode.viewfinder")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                Text(item.barcode)
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            itemToDelete = item
                            showConfirmationDialog = true
                        } label: {
                            Label("Delete All", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Barcode or Item")
        .alert("Delete Item and History", isPresented: $showConfirmationDialog, presenting: itemToDelete) { item in
            Button("Delete", role: .destructive) {
                deleteItemAndHistory(item)
            }
            Button("Cancel", role: .cancel) {}
        } message: { item in
            Text("Are you sure you want to delete the item '\(item.name)' and all its history?")
        }
        .navigationBarTitle("Delete Items & History", displayMode: .inline)
        .onAppear(perform: fetchItems)
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)
            Text("Nothing to see here!")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func fetchItems() {
        items = databaseManager.fetchAllItems()
    }

    private func deleteItemAndHistory(_ item: ItemFetch) {
        databaseManager.deleteItem(item.id)
        databaseManager.deleteHistoryForBarcode(item.barcode)
        fetchItems() // Refresh the list after deletion
    }
}


#Preview {
    DeleteItemAndHistory()
}
