import SwiftUI

struct AddSKU: View {
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
                        selectedItem = item
                    }) {
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
                .searchable(text: $searchText)
                .navigationBarTitle("Add SKU", displayMode: .inline)
            }
        }
        .onChange(of: selectedItem) { _, _ in
            isSheetPresented = selectedItem != nil
        }
        .sheet(isPresented: $isSheetPresented, onDismiss: {
            selectedItem = nil
            fetchItemsForSKU()
        }) {
            if let selectedItem = selectedItem {
                AddSKUSheet(item: selectedItem, databaseManager: databaseManager)
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
}


struct AddSKUSheet: View {
    @Environment(\.presentationMode) var presentationMode
    var item: ItemFetchForSKU
    var databaseManager: DatabaseManager
    @State private var newSKU: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: labelWithIcon("New SKU", image: "barcode.viewfinder"),footer: Text("If you input a SKU that is already in use, it will not be saved automatically.")) {
                    TextField("", text: $newSKU)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: saveSKU) {
                        Text("Save")
                    }
                    .disabled(!isSKUValid)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
                }
            }
            .navigationBarTitle("Add SKU to \(item.barcode)", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private var isSKUValid: Bool {
        // Check if the SKU contains only numbers and is not already in the item's SKUs
        let skuCharacterSet = CharacterSet(charactersIn: newSKU)
        let isNumeric = CharacterSet.decimalDigits.isSuperset(of: skuCharacterSet)
        let isUnique = !item.SKU.contains(newSKU)
        return isNumeric && isUnique && !newSKU.isEmpty
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

    private func saveSKU() {
        if isSKUValid {
            let updatedSKUs = item.SKU + [newSKU]
            databaseManager.updateSKUs(for: item.id, newSKUs: updatedSKUs)
            presentationMode.wrappedValue.dismiss()
        }
     
    }
}


#Preview {
    AddSKU()
}
