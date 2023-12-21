import Charts
import SwiftUI

struct ItemClient: View {
        
        @State private var clientData: [String: Int] = [:]
        
        private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
        
        var body: some View {
            ScrollView(.horizontal) {
                Chart {
                    ForEach(clientData.keys.sorted(), id: \.self) { client in
                        BarMark(
                            x: .value("Client", client),
                            y: .value("Count", clientData[client] ?? 0)
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(barColors.randomElement() ?? .black)
                        .annotation(position: .overlay) {
                            Text("\(clientData[client] ?? 0)")
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
                .navigationTitle("Items Created Per Client")
            }
            .chartYAxis(.hidden)
            .scrollIndicators(.hidden)
            
            Spacer()
        }
    
    
        private func loadData() {
            
            clientData = DatabaseManager().fetchItemsCountByClient()
            
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
    ItemClient()
}
