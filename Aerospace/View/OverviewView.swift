import SwiftUI
import Charts

struct OverviewView: View {
    
    @State private var userCreationData: [Order] = []
    
    var body: some View {
        ScrollView {
            Chart {
                ForEach(userCreationData, id: \.id) { order in
                    LineMark(
                        x: .value("Day", order.day),
                        y: .value("Count", order.amount),
                        series: .value("User", order.user)
                    )
                    .foregroundStyle(by: .value("User", order.user))
                }
            }
            .frame(width: 400, height: 450)
            .padding(.top, 20)
            .onAppear {
                loadData()
            }
            .navigationTitle("Item Per Staff")
        }
        .scrollIndicators(.hidden)
    }
    
    private func loadData() {
        
        userCreationData = DatabaseManager().fetchProductCreationByUserForLast30Days()
        
    }
}


#Preview {
    OverviewView()
}


