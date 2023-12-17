import SwiftUI

struct StatusDeleteView: View {
    
    @State private var statuses: [Status] = []
    let databaseManager = DatabaseManager()
    
    @State private var fetchFailed: Bool = false

    var body: some View {
        if fetchFailed {
            VStack {
                Image("NothingHere") // Replace with your 'Nothing to see here' image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("Nothing to see here!")
                    .font(.headline)
            }
        } else {
            List {
                ForEach(statuses, id: \.id) { status in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "info.square.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(status.name).font(.headline)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "text.bubble.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(status.description)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "person.text.rectangle.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(status.user)
                                .foregroundStyle(Color.gray)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "clock.arrow.2.circlepath")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(formattedDate(from: status.date))
                                .foregroundStyle(Color.gray)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                    }
                }
                .onDelete(perform: deleteStatus)
            }
            .navigationTitle("Status")
            .onAppear {
                fetchStatusIfFail()
            }
        }
    }

    private func deleteStatus(at offsets: IndexSet) {
        offsets.forEach { index in
            let statusId = statuses[index].id
            if databaseManager.deleteStatus(withId: statusId) {
                statuses.remove(at: index)
            }
            fetchStatusIfFail()
        }
    }
    
    func fetchStatusIfFail() {
        let result = databaseManager.fetchStatuses()
        if result.isEmpty {
            fetchFailed = true
        } else {
            statuses = result
        }
    }

    private func formattedDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Adjust this format to your current format
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
            return outputFormatter.string(from: date)
        }
        return dateString // Return original string if conversion fails
    }
}

#Preview {
    StatusDeleteView()
}
