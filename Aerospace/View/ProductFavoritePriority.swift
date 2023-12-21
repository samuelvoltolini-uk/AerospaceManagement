import Charts
import SwiftUI

struct ProductFavoritePriority: View {
    
    @State private var categoryData: [CategoryData] = []
    
    var body: some View {
        ScrollView {
            if categoryData.isEmpty {
                emptyStateView
            } else {
                Chart {
                    ForEach(categoryData) { category in
                        SectorMark(
                            angle: .value(category.category, category.proportion)
                        )
                        .foregroundStyle(by: .value(category.category, category.category))
                    }
                }
                .frame(width: 400, height: 450)
                .padding(.top, 20)
            }
        }
        .onAppear {
            loadData()
        }
        .navigationTitle("Favorite & Priority")
    }

    private var emptyStateView: some View {
        VStack {
            Image("NothingHere5") // Make sure the image is available in your assets
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text("Nothing to see here!")
                .font(.headline)
        }
    }
    
    private func loadData() {
        let counts = DatabaseManager().fetchProductCategoriesCount()
        let total = Double(counts.values.reduce(0, +))
        categoryData = counts.map { CategoryData(category: $0.key, proportion: Double($0.value) / total) }
    }
}

#Preview {
    ProductFavoritePriority()
}
