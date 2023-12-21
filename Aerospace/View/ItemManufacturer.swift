import Charts
import SwiftUI

struct ItemManufacturer: View {
    
    @State private var manufacturerData: [String: Int] = [:]
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    var body: some View {
        VStack {
            if manufacturerData.isEmpty {
                emptyStateView
            } else {
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
                }
                .chartYAxis(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            loadData()
        }
        .navigationTitle("Items Created Per Manufacturer")
        
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
        manufacturerData = DatabaseManager().fetchItemsCountByManufacturer()
    }
}


#Preview {
    ItemManufacturer()
}
