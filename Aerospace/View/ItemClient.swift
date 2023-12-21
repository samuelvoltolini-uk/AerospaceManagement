import Charts
import SwiftUI

struct ItemClient: View {
        
    @State private var clientData: [String: Int] = [:]
    
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    var body: some View {
        VStack {
            if clientData.isEmpty {
                emptyStateView
            } else {
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
                }
                .chartYAxis(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            loadData()
        }
        .navigationTitle("Items Created Per Client")
        
        Spacer()
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
        .padding(.top, 200)
    }
    
    private func loadData() {
        clientData = DatabaseManager().fetchItemsCountByClient()
    }
}

#Preview {
    ItemClient()
}
