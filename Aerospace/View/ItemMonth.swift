import Charts
import SwiftUI

struct ItemMonth: View {
    
    @State private var monthlyCreationData: [MonthlyCreationData] = []
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    var body: some View {
        VStack {
            if monthlyCreationData.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    Chart(monthlyCreationData) { data in
                        BarMark(
                            x: .value("Month", data.month),
                            y: .value("Count", data.count)
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(barColors.randomElement() ?? .black)
                        .annotation(position: .overlay) {
                            Text("\(data.count)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 1000, height: 1200)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            loadData()
        }
        .navigationTitle("Items Created Per Month")
        
        Spacer()
    }

    private var emptyStateView: some View {
        VStack {
            Image("NothingHere5") // Make sure the image is available in your assets
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)
            Text("Nothing to see here!")
                .font(.headline)
        }
        .padding(.top, 200)
    }
    
    private func loadData() {
        let monthlyFetchedData = DatabaseManager().fetchItemsCreatedPerMonth()
        monthlyCreationData = monthlyFetchedData.map { MonthlyCreationData(month: $0.key, count: $0.value) }
    }
}

#Preview {
    ItemMonth()
}
