
import Charts
import SwiftUI

struct Item7Days: View {
    
    @State private var dailyCreationData: [DailyCreationData] = []
    
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    var body: some View {
        ScrollView(.horizontal) {
            Chart {
                ForEach(dailyCreationData.sorted(by: {
                    dateFormatter.date(from: $0.day) ?? Date.distantPast < dateFormatter.date(from: $1.day) ?? Date.distantPast
                }), id: \.id) { data in
                    BarMark(
                        x: .value("Day", data.day),
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
            }
            .frame(width: 1000, height: 700)
            .padding(.top, 20)
            .onAppear {
                loadData()
            }
            .navigationTitle("Items Created Per Day")
        }
        .chartYAxis(.hidden)
        .scrollIndicators(.hidden)
        
        Spacer()
    }
    private func loadData() {

        let dailyFetchedData = DatabaseManager().fetchItemsCreatedPerDay()
        dailyCreationData = dailyFetchedData.map { DailyCreationData(day: $0.key, count: $0.value) }
        
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "Favorite": return .yellow
        case "Priority": return .red
        case "Both": return .green
        default: return .gray
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}


#Preview {
    Item7Days()
}
