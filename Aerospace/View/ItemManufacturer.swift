import Charts
import SwiftUI

struct ItemManufacturer: View {
    
    @State private var manufacturerData: [String: Int] = [:]
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    var body: some View {
            ScrollView(.horizontal) {
                Chart {
                    ForEach(manufacturerData.keys.sorted(), id: \.self) { manufacturer in
                        BarMark(
                            x: .value("Manufacturer", manufacturer),
                            y: .value("Count", manufacturerData[manufacturer] ?? 0)
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(barColors.randomElement() ?? .black)
                        .annotation(position: .overlay) {
                            Text("\(manufacturerData[manufacturer] ?? 0)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                    }
                }
                .frame(width: 1000, height: 700)
                .padding(.top, 20)
                .onAppear {
                    loadData()
                }
                .navigationTitle("Items Created Per Manufacturer")
            }
            .chartYAxis(.hidden)
            .scrollIndicators(.hidden)
        Spacer()
    }
    private func loadData() {

        manufacturerData = DatabaseManager().fetchItemsCountByManufacturer()
        
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
    ItemManufacturer()
}
