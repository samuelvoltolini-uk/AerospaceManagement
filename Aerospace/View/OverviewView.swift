import SwiftUI
import Charts

struct OverviewView: View {
    
    @State private var userCreationData: [Order] = []

    var body: some View {
        ScrollView {
            if userCreationData.isEmpty {
                emptyStateView
            } else {
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
                .frame(width: 1000, height: 1000)
                .padding(.top, 20)
            }
        }
        .onAppear {
            loadData()
        }
        .navigationTitle("Item Per Staff")
        .scrollIndicators(.hidden)
    }

    private var emptyStateView: some View {
        VStack {
            Image("NothingHere5")
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)
            Text("Nothing to see here!")
                .font(.headline)
        }
        .padding(.top, 200)
    }
    
    private func loadData() {
        userCreationData = DatabaseManager().fetchProductCreationByUserForLast30Days()
    }
}



#Preview {
    OverviewView()
}


