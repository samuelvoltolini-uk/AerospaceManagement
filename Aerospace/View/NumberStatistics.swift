
import SwiftUI


struct NumberStatistics: View {
    @State private var itemCount: Int = 0
    @State private var userCount: Int = 0
    @State private var statusCount: Int = 0
    @State private var tagCount: Int = 0
    @State private var manufacturerCount: Int = 0
    @State private var countryCount: Int = 0
    @State private var clientCount: Int = 0
    @State private var totalQuantity: Double = 0.0

    var body: some View {
        List {
            statisticsRow(title: "Total Items Count", value: String(itemCount), iconName: "number.square.fill")
            statisticsRow(title: "Total Users Count", value: String(userCount), iconName: "person.crop.square.fill")
            statisticsRow(title: "Total Status Count", value: String(statusCount), iconName: "flag.square.fill")
            statisticsRow(title: "Total Tags Count", value: String(tagCount), iconName: "tag.square.fill")
            statisticsRow(title: "Total Manufacturers Count", value: String(manufacturerCount), iconName: "square.grid.2x2.fill")
            statisticsRow(title: "Total Countries Count", value: String(countryCount), iconName: "mappin.square.fill")
            statisticsRow(title: "Total Clients Count", value: String(clientCount), iconName: "lightswitch.on.square.fill")
            statisticsRow(title: "Total Quantity of Items", value: String(Int(totalQuantity)), iconName: "number.square.fill")
        }
        .scrollDisabled(true)

        
        
        .onAppear {
            loadData()
        }
        .navigationTitle("Express Data")
    }

    private func loadData() {
        let dbManager = DatabaseManager()
        itemCount = dbManager.fetchTotalItemCount()
        userCount = dbManager.fetchTotalUserCount()
        statusCount = dbManager.fetchTotalCount(tableName: "Status")
        tagCount = dbManager.fetchTotalCount(tableName: "Tags")
        manufacturerCount = dbManager.fetchTotalCount(tableName: "Manufacturer")
        countryCount = dbManager.fetchTotalCount(tableName: "Countries")
        clientCount = dbManager.fetchTotalCount(tableName: "Clients")
        totalQuantity = dbManager.fetchTotalItemQuantity()
    }

    private func statisticsRow(title: String, value: String, iconName: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(.footnote)
                .foregroundStyle(Color.gray)
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
        
    }
}


#Preview {
    NumberStatistics()
}
