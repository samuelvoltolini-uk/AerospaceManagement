import SwiftUI

struct ViewByManufacturer: View {
    
    @State private var allItems: [ItemByManufacturer] = [] // All items fetched from the database
    @State private var filteredItems: [ItemByManufacturer] = [] // Items filtered by the selected tag
    @State private var searchText = ""
    
    @State private var selectedManufacturer: String?

    @State private var manufacturers: [ManufacturerPicker] = []

    let databaseManager = DatabaseManager() // Your database manager instance

    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "lightswitch.on.square.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.indigo)
                    
                    Text("Select Manufacturer")
                    
                    Spacer()
                    
                    Picker("Select Manufacturer", selection: $selectedManufacturer) {
                        Text("All").tag(String?.none)
                        ForEach(manufacturers, id: \.id) { tag in
                            Text(tag.name).tag(tag.name as String?)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedManufacturer) { oldValue, newValue in
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
            .navigationBarTitle("Items by Manufacturer", displayMode: .inline)
            .onAppear {
                fetchAllItems()
                loadPickerData()
            }
    }

    private func fetchAllItems() {
        allItems = databaseManager.fetchItemsByManufacturer()
        filteredItems = allItems
    }

    private func loadPickerData() {
        manufacturers = databaseManager.fetchManufacturersPicker()
    }

    private func filterItemsBySelectedManufacturer() {
        if let selectedTag = selectedManufacturer, !selectedTag.isEmpty, selectedTag != "All" {
            filteredItems = allItems.filter { $0.manufacturer.contains(selectedTag) }
        } else {
            filteredItems = allItems
        }
    }

    private var displayItems: [ItemByManufacturer] {
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
    ViewByManufacturer()
}
