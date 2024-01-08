import SwiftUI

struct ViewByTags: View {
    @State private var allItems: [ItemByTags] = [] // All items fetched from the database
    @State private var filteredItems: [ItemByTags] = [] // Items filtered by the selected tag
    @State private var searchText = ""
    @State private var selectedTag: String?

    @State private var tags: [TagPicker] = [] // Array of TagPicker objects

    let databaseManager = DatabaseManager() // Your database manager instance

    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "tag.square.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.pink)
                    
                    Text("Select Tag")
                    
                    Spacer()
                    
                    Picker("Select Tag", selection: $selectedTag) {
                        Text("All").tag(String?.none)
                        ForEach(tags, id: \.id) { tag in
                            Text(tag.name).tag(tag.name as String?)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedTag) { oldValue, newValue in
                    filterItemsBySelectedTag()
                }

                Divider().padding(.horizontal, 20)
                
                Spacer()
                
                if displayItems.isEmpty {
                    emptyView
                    Spacer()
                } else {
                    List(displayItems, id: \.id) { item in
                        VStack(alignment: .leading) {
                            itemDisplayView(icon: "info.square.fill", text: item.name)
                            itemDisplayView(icon: "barcode.viewfinder", text: item.barcode)
                            itemDisplayView(icon: "number.square.fill", text: "\(Int(item.quantity))")
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Barcode or Item")
            .navigationBarTitle("Items by Tags", displayMode: .inline)
            .onAppear {
                fetchAllItems()
                loadPickerData()
            }
    }

    private func fetchAllItems() {
        allItems = databaseManager.fetchItemsByTags()
        filteredItems = allItems
    }

    private func loadPickerData() {
        tags = databaseManager.fetchTagPicker()
    }

    private func filterItemsBySelectedTag() {
        if let selectedTag = selectedTag, !selectedTag.isEmpty, selectedTag != "All" {
            filteredItems = allItems.filter { $0.tagName.contains(selectedTag) }
        } else {
            filteredItems = allItems
        }
    }

    private var displayItems: [ItemByTags] {
        if searchText.isEmpty {
            return filteredItems
        } else {
            return filteredItems.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.barcode.contains(searchText.uppercased()) }
        }
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere3") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)
            Text("Nothing to see here!")
                .font(.headline)
        }
    }

    private func itemDisplayView(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            Text(text)
                .font(.footnote)
        }
        .padding(.top, 5)
    }
}



#Preview {
    ViewByTags()
}
