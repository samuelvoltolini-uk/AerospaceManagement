import SwiftUI

struct ViewByStatus: View {
    
    @State private var allItems: [ItemByStatus] = [] // All items fetched from the database
    @State private var filteredItems: [ItemByStatus] = [] // Items filtered by the selected tag
    @State private var searchText = ""
    
    @State private var selectedStatus: String?

    @State private var statuses: [StatusPicker] = []

    let databaseManager = DatabaseManager() // Your database manager instance

    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "flag.square.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.orange)
                    
                    Text("Select Status")
                    
                    Spacer()
                    
                    Picker("Select Status", selection: $selectedStatus) {
                        Text("All").tag(String?.none)
                        ForEach(statuses, id: \.id) { tag in
                            Text(tag.name).tag(tag.name as String?)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedStatus) { oldValue, newValue in
                    filterItemsBySelectedManufacturer()
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
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Barcode or Item")
            .navigationBarTitle("Items by Status", displayMode: .inline)
            .onAppear {
                fetchAllItems()
                loadPickerData()
            }
    }

    private func fetchAllItems() {
        allItems = databaseManager.fetchItemsByStatus()
        filteredItems = allItems
    }

    private func loadPickerData() {
        statuses = databaseManager.fetchStatusesPicker()
    }

    private func filterItemsBySelectedManufacturer() {
        if let selectedTag = selectedStatus, !selectedTag.isEmpty, selectedTag != "All" {
            filteredItems = allItems.filter { $0.status.contains(selectedTag) }
        } else {
            filteredItems = allItems
        }
    }

    private var displayItems: [ItemByStatus] {
        if searchText.isEmpty {
            return filteredItems
        } else {
            return filteredItems.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.barcode.contains(searchText.uppercased()) }
        }
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere4") // Placeholder image for empty state
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
    ViewByStatus()
}
