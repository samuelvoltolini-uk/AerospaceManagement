

import SwiftUI

struct DeleteSKU: View {
    @State private var items: [ItemFetchForSKU] = []
    @State private var searchText = ""
    @State private var isSheetPresented = false
    @State private var selectedItem: ItemFetchForSKU?

    let databaseManager = DatabaseManager()

    var body: some View {
        VStack {
            if items.isEmpty {
                emptyView()
            } else {
                List(filteredItems, id: \.id) { item in
                    Button(action: {
                        selectedItem = nil
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            selectedItem = item
                        }
                    }) {
                        itemDisplayView(item)
                    }
                }
                .searchable(text: $searchText)
                .navigationBarTitle("Delete SKU", displayMode: .inline)
            }
        }
        .onChange(of: selectedItem) { _, _ in
            isSheetPresented = selectedItem != nil
        }
        .sheet(isPresented: $isSheetPresented, onDismiss: fetchItemsForSKU) {
            if let selectedItem = selectedItem {
                DeleteSKUSheet(item: selectedItem, databaseManager: databaseManager)
            }
        }
        .onAppear(perform: fetchItemsForSKU)
    }

    private func fetchItemsForSKU() {
        items = databaseManager.fetchItemsForSKU()
    }

    private var filteredItems: [ItemFetchForSKU] {
        searchText.isEmpty ? items : items.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.barcode.contains(searchText) }
    }

    private func emptyView() -> some View {
        VStack {
            Image("NothingHere2") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text("Nothing to see here!")
                .font(.headline)
        }
    }

    private func itemDisplayView(_ item: ItemFetchForSKU) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "info.square.fill") // Icon for item name
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                Text(item.name)
                    .font(.footnote)
                    .foregroundStyle(Color.accentColor)
            }
            .padding(.top, 5)
            HStack {
                Image(systemName: "barcode.viewfinder") // Icon for barcode
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                Text(item.barcode)
                    .font(.footnote)
                    .foregroundStyle(Color.accentColor)
            }
            .padding(.top, 5)
        }
    }
}

struct DeleteSKUSheet: View {
    @Environment(\.presentationMode) var presentationMode
    var item: ItemFetchForSKU
    var databaseManager: DatabaseManager
    @State private var SKUs: [String] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: labelWithIcon("Slide to delete", image: "minus.square.fill")) {
                    List {
                        ForEach(SKUs, id: \.self) { sku in
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "barcode.viewfinder")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.accentColor)
                                    Text(sku)
                                        .font(.subheadline)
                                }
                                .padding(.top, 5)
                            }
                        }
                        .onDelete(perform: deleteSKU)
                    }
                }
            }
            .navigationBarTitle("Delete SKU for \(item.barcode)", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear {
            loadSKUs()
        }
    }

    private func loadSKUs() {
        if let updatedItem = databaseManager.fetchItemByIDForDelete(item.id) {
            SKUs = updatedItem.SKU
        }
    }
    
    private func deleteSKU(at offsets: IndexSet) {
        guard let index = offsets.first else { return }

        let skuToDelete = SKUs[index]
        databaseManager.deleteSKU(for: item.id, skuToDelete: skuToDelete)

        // Remove the SKU from the local array
        SKUs.remove(at: index)

        // Optionally, update the item's quantity as well, if necessary
        // (This part of the logic depends on your specific requirements)
    }

    private func labelWithIcon(_ text: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            
            Text(text)
        }
    }
}


#Preview {
    DeleteSKU()
}
