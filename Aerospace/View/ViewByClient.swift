import SwiftUI

struct ViewByClient: View {
    
    @State private var allItems: [ItemByClient] = [] // All items fetched from the database
    @State private var filteredItems: [ItemByClient] = [] // Items filtered by the selected tag
    @State private var searchText = ""
    
    @State private var selectedClient: String?

    @State private var clients: [ClientPicker] = []

    let databaseManager = DatabaseManager() // Your database manager instance

    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "square.grid.2x2.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.orange)
                    
                    Text("Select Client")
                    
                    Spacer()
                    
                    Picker("Select Client", selection: $selectedClient) {
                        Text("All").tag(String?.none)
                        ForEach(clients, id: \.id) { tag in
                            Text(tag.name).tag(tag.name as String?)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedClient) { oldValue, newValue in
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
                    .listStyle(PlainListStyle())
                }
            }
            .searchable(text: $searchText, prompt: "Search by Name or Barcode")
            .navigationBarTitle("Items by Tags", displayMode: .inline)
            .onAppear {
                fetchAllItems()
                loadPickerData()
            }
    }

    private func fetchAllItems() {
        allItems = databaseManager.fetchItemsByClient()
        filteredItems = allItems
    }

    private func loadPickerData() {
        clients = databaseManager.fetchClientsPicker()
    }

    private func filterItemsBySelectedManufacturer() {
        if let selectedTag = selectedClient, !selectedTag.isEmpty, selectedTag != "All" {
            filteredItems = allItems.filter { $0.client.contains(selectedTag) }
        } else {
            filteredItems = allItems
        }
    }

    private var displayItems: [ItemByClient] {
        if searchText.isEmpty {
            return filteredItems
        } else {
            return filteredItems.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.barcode.contains(searchText.uppercased()) }
        }
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere5") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
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
    ViewByClient()
}
