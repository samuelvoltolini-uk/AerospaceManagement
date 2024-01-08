import SwiftUI

struct PriorityView: View {
    @State private var items: [ItemFetchPriorityView] = [] 
    // Assuming ItemFetchPriorityView has similar structure to ItemFetchFavoriteView
    @State private var searchText = ""
    
    let databaseManager = DatabaseManager()

    var filteredItems: [ItemFetchPriorityView] {
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
                List(filteredItems, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            itemDetailView("info.square.fill", text: item.name)
                            itemDetailView("barcode.viewfinder", text: item.barcode)
                            quantityView(item.quantity)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "exclamationmark.square.fill") // Icon for priority items
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.green)
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Barcode or Item")
            }
        }
        .navigationBarTitle("Priority Items")
        .onAppear {
            fetchPriorityItems()
        }
    }
    
    private var emptyView: some View {
        VStack {
            Image("NothingHere") // Replace with your 'Nothing to see here' image
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)
            Text("Nothing to see here!")
                .font(.headline)
        }
    }

    private func fetchPriorityItems() {
        items = databaseManager.fetchPriorityItems()
    }

    private func itemDetailView(_ iconName: String, text: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            Text(text)
                .font(.subheadline)
        }
        .padding(.top, 5)
    }

    private func quantityView(_ quantity: Double) -> some View {
        HStack {
            let quantityIconName = "\(Int(min(max(quantity, 1), 10))).square.fill"
            Image(systemName: quantityIconName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(colorForQuantity(quantity))
            
            Text("Quantity")
                .font(.footnote)
                .foregroundStyle(Color.gray)
        }
        .padding(.top, 5)
    }

    private func colorForQuantity(_ quantity: Double) -> Color {
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
    PriorityView()
}
