
import Charts
import SwiftUI

struct ProductPerStatus: View {
    
    @State private var statusData: [StatusData] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Chart {
                    ForEach(statusData) { data in
                        SectorMark(
                            angle: .value(
                                "Status",
                                Double(data.count)
                            ),
                            innerRadius: .ratio(0.6),
                            angularInset: 10
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(
                            by: .value(
                                "Status",
                                data.status
                            )
                        )
                        .annotation(position: .overlay) {
                            Text("\(data.count)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(width: 400, height: 450)
                .padding(.top, 20)
                .onAppear {
                    loadData()
                }
                .navigationTitle("Product Count Per Status")
            }
        }
        
    }
    private func loadData() {
        let statusFetchedData = DatabaseManager().fetchItemsPerStatus()
        statusData = statusFetchedData.map { StatusData(status: $0.key, count: $0.value) }
    }
}

#Preview {
    ProductPerStatus()
}
