import SwiftUI

struct ViewItemView: View {
    
    @State private var items: [ItemFetch] = []
    @State private var searchText = ""

    let databaseManager = DatabaseManager()
    
    var body: some View {
        // Check if the items array is empty
        if items.isEmpty {
            // Display an image and text when there are no items
            VStack {
                Image("NothingHere") // Replace with your 'Nothing to see here' image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("Nothing to see here!")
                    .font(.headline)
            }

            .onAppear {
                loadItems()
            }
        } else {
            // Existing list view implementation
            List(filteredItems, id: \.id) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "info.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.accentColor)
                                Text(item.name)
                                    .font(.subheadline)
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "barcode")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.accentColor)
                                Text(item.barcode)
                                    .font(.subheadline)
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "\(min(max(item.quantity, 1), 10)).square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(colorForQuantity(item.quantity))
                                Text("Quantity")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            .padding(.top, 5)
                        }
                    }
                }
            }
            .onAppear {
                loadItems()
            }
            .navigationBarTitle("Items")
            .searchable(text: $searchText, prompt: "Search by Name or Barcode")
        }
    }

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

    private func loadItems() {
        items = databaseManager.fetchAllItems()
    }

    private func colorForQuantity(_ quantity: Int) -> Color {
        switch quantity {
        case 1...2:
            return .red
        case 3...4:
            return .orange
        case 5...6:
            return .yellow
        case 7...8:
            return .green
        case 9...10:
            return .blue
        default:
            return .gray
        }
    }
}


#Preview {
    ViewItemView()
}
