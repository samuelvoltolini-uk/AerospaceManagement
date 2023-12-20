import SwiftUI

struct ViewByTags: View {
    
    @State private var allItems: [ItemByTags] = [] // All items fetched from the database
    @State private var filteredItems: [ItemByTags] = [] // Items filtered by the selected tag
    @State private var searchText = ""
    @State private var selectedTag: String = ""

    @State private var tags: [TagPicker] = [] // Array of TagPicker objects

    let databaseManager = DatabaseManager() // Your database manager instance

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Tag", selection: $selectedTag) {
                    ForEach(tags, id: \.id) { tag in
                        Text(tag.name).tag(tag.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedTag) { _ in
                    filterItemsBySelectedTag()
                }

                if displayItems.isEmpty {
                    emptyView
                } else {
                    List(displayItems, id: \.id) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("Barcode: \(item.barcode)")
                                .font(.subheadline)
                            Text("Quantity: \(item.quantity)")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search by Name or Barcode")
            .navigationBarTitle("Items by Tags", displayMode: .inline)
            .onAppear {
                fetchAllItems()
                loadPickerData()
            }
        }
    }

    private func fetchAllItems() {
        // Fetch all items from the database
        allItems = databaseManager.fetchItemsByTags()
        filteredItems = allItems
    }
    
    private func loadPickerData() {
        // Fetch tags from the database
        tags = databaseManager.fetchTagPicker()
        if let firstTag = tags.first {
            selectedTag = firstTag.name
            filterItemsBySelectedTag()
        }
    }

    private func filterItemsBySelectedTag() {
        // Filter items by the selected tag
        if selectedTag.isEmpty || selectedTag == "All" {
            filteredItems = allItems
        } else {
            filteredItems = allItems.filter { $0.tagName.contains(selectedTag) }
        }
    }

    private var displayItems: [ItemByTags] {
        if searchText.isEmpty {
            return filteredItems
        } else {
            return filteredItems.filter { $0.name.contains(searchText) || $0.barcode.contains(searchText) }
        }
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text("No items found")
                .font(.headline)
        }
    }
}

#Preview {
    ViewByTags()
}
