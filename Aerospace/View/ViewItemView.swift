import SwiftUI

struct ViewItemView: View {
    
    @State private var items: [ItemFetch] = []
    
    let databaseManager = DatabaseManager()
    
    var body: some View {
        NavigationView {
            List(items) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "info.square.fill") // Icon for barcode
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Name: \(item.name)")
                                    .font(.subheadline)
                                
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "barcode") // Icon for barcode
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Barcode: \(item.barcode)")
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
        }
        .navigationBarTitle("Items", displayMode: .inline)
    }

    private func loadItems() {
        // You can provide mock data here for previews if needed
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
