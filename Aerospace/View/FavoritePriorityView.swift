import SwiftUI

struct FavoritePriorityView: View {
    let databaseManager = DatabaseManager()
    
    @State private var items: [ItemFetchFavoritePriority] = []
    @State private var searchText = ""
    
    @State private var showOnlyFavorites = false
    @State private var showOnlyPriority = false
    @State private var showNeither = false

    var filteredItems: [ItemFetchFavoritePriority] {
            var filtered = items

            if showOnlyFavorites {
                filtered = filtered.filter { $0.isFavorite }
            }

            if showOnlyPriority {
                filtered = filtered.filter { $0.isPriority }
            }

            if showNeither {
                filtered = filtered.filter { !$0.isFavorite && !$0.isPriority }
            }

            if !showOnlyFavorites && !showOnlyPriority && !showNeither {
                return []
            }

            if !searchText.isEmpty {
                filtered = filtered.filter { $0.barcode.contains(searchText) || $0.name.contains(searchText) }
            }

            return filtered
        }
    
    var body: some View {
            if items.isEmpty {
                // Display an image and text when the list is empty
                VStack {
                    Image("NothingHere") // Replace with your 'Nothing to see here' image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 600)
                    Text("Nothing to see here!")
                        .font(.headline)
                }
                .onAppear {
                    items = databaseManager.fetchItems()
                }
            } else {
                List {
                    Toggle(isOn: $showOnlyFavorites) {
                        HStack {
                            Image(systemName: "star.square.fill") // Icon for favorites
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.orange)
                            
                            Text("Show Favorite Items")
                                .font(.footnote)
                        }
                    }
                    .tint(.accentColor)
                    
                    Toggle(isOn: $showOnlyPriority) {
                        HStack {
                            Image(systemName: "exclamationmark.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)// Icon for priority
                            
                            Text("Show Priority Items")
                                .font(.footnote)
                        }
                    }
                    .tint(.accentColor)
                    
                    Toggle(isOn: $showNeither) {
                        HStack {
                            Image(systemName: "eye.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.purple)
                            
                            Text("Show Neither")
                                .font(.footnote)
                        }
                    }
                    .tint(.accentColor)
                    
                    ForEach(filteredItems, id: \.barcode) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                itemDetailView("info.square.fill", text: item.name)
                                itemDetailView("barcode.viewfinder", text: item.barcode)
                                quantityView(item.quantity)
                            }
                            
                            Spacer()
                            
                            HStack {
                                if item.isFavorite {
                                    Image(systemName: "star.square.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.orange)
                                }
                                if item.isPriority {
                                    Image(systemName: "exclamationmark.square.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.trailing, 10)
                            
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                toggleFavorite(for: item)
                            } label: {
                                Label(item.isFavorite ? "Remove Favorite" : "Favorite", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                togglePriority(for: item)
                            } label: {
                                Label(item.isPriority ? "Remove Priority" : "Priority", systemImage: "exclamationmark.triangle")
                            }
                            .tint(.green)
                        }
                    }
                    .navigationBarTitle("Priority & Favorite")
                }
                
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Barcode or Item")
                .onAppear {
                    items = databaseManager.fetchItems()
                }
            }
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

    private func itemDetailView(_ iconName: String, text: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.accentColor)
            Text(text)
                .font(.subheadline)
        }
        .padding(.top, 5)
    }

    private func quantityView(_ quantity: Double) -> some View {
        HStack {
            if quantity >= 1 && quantity <= 10 {
                Image(systemName: "\(Int(quantity)).square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(colorForQuantity(quantity))
                Text("Quantity")
                    .foregroundStyle(Color.gray)
            }
        }
        .padding(.top, 5)
    }

    private func toggleFavorite(for item: ItemFetchFavoritePriority) {
        databaseManager.toggleFavorite(for: item.barcode)
        if let index = items.firstIndex(where: { $0.barcode == item.barcode }) {
            items[index].isFavorite.toggle()
        }
    }

    private func togglePriority(for item: ItemFetchFavoritePriority) {
        databaseManager.togglePriority(for: item.barcode)
        if let index = items.firstIndex(where: { $0.barcode == item.barcode }) {
            items[index].isPriority.toggle()
        }
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
    FavoritePriorityView()
}
