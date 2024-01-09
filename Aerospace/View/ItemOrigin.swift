import Charts
import SwiftUI

struct ItemOrigin: View {
    
    @State private var originData: [String: Int] = [:]
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    var body: some View {
            ScrollView {
                Chart {
                    ForEach(originData.keys.sorted(), id: \.self) { origin in
                        BarMark(
                            x: .value("Origin", origin),
                            y: .value("Count", originData[origin] ?? 0)
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(barColors.randomElement() ?? .black)
                        .annotation(position: .overlay) {
                            Text("\(originData[origin] ?? 0)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                    }
                }
                .frame(width: 1000, height: 1200)
                .padding(.top, 20)
                .onAppear {
                    loadData()
                }
                .navigationTitle("Items Created Per Origin")
            }
            .chartYAxis(.hidden)
            .scrollIndicators(.hidden)
        Spacer()
    }
    private func loadData() {

        originData = DatabaseManager().fetchItemsCountByOrigin()
        
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
    ItemOrigin()
}
