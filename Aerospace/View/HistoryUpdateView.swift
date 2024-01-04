
import SwiftUI

struct HistoryUpdateView: View {
    
    @State private var historyRecords: [HistoryRecord] = []
    @State private var searchText = ""
    @State private var selectedRecord: HistoryRecord?

    let databaseManager = DatabaseManager()

    var body: some View {

            VStack {
                if filteredRecords.isEmpty {
                    emptyView
                } else {
                    List(filteredRecords, id: \.id) { record in
                        Button(action: {
                            self.selectedRecord = record
                        }) {
                            VStack(alignment: .leading) {
                                itemDetailView("info.square.fill", text: firstItemName(from: record.name))
                                itemDetailView("qrcode.viewfinder", text: record.barcode)
                            }
                        }
                    }
                    .navigationBarTitle("History", displayMode: .inline)
                }
            }
            .searchable(text: $searchText, prompt: "Search by Barcode")
            .sheet(item: $selectedRecord) { record in
                HistoryDetailsViewDelete(record: record, onDeletionComplete: {
                    // Refresh the main view's data
                    historyRecords = databaseManager.fetchHistoryRecords().sorted(by: { $0.barcode < $1.barcode })
                })
            }
            .onAppear {
                historyRecords = databaseManager.fetchHistoryRecords().sorted(by: { $0.barcode < $1.barcode })
            }
    }

    private var filteredRecords: [HistoryRecord] {
        if searchText.isEmpty {
            return historyRecords
        } else {
            return historyRecords.filter { record in
                record.name.contains(searchText) || record.barcode.contains(searchText.uppercased())
            }
        }
    }

    private var emptyView: some View {
        VStack {
            Image("NothingHere2") // Placeholder image for empty state
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text("Nothing to see here!")
                .font(.headline)
        }
    }

    private func itemDetailView(_ iconName: String, text: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            Text(text)
                .font(.footnote)
                .foregroundStyle(Color.accentColor)
        }
    }

    private func firstItemName(from names: [String]) -> String {
        return names.first ?? "Unknown"
    }
}

struct HistoryDetailsViewDelete: View {
    
        @State var record: HistoryRecord // Make it a state variable
        let databaseManager = DatabaseManager()
        var onDeletionComplete: () -> Void

        var body: some View {
            NavigationView {
                List {
                    ForEach(0..<record.status.count, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                detailRow(icon: "flag.square.fill", title: "Status", value: record.status[index].trimmingCharacters(in: .whitespaces))
                                detailRow(icon: "square.text.square.fill", title: "Comments", value: record.comments[index].trimmingCharacters(in: .whitespaces))
                                detailRow(icon: "person.crop.square.fill", title: "User", value: record.users[index].trimmingCharacters(in: .whitespaces))
                                detailRow(icon: "calendar.badge.checkmark", title: "Date", value: record.dates[index].trimmingCharacters(in: .whitespaces))
                            }
                            Spacer()
                            Rectangle().fill(colorForIndex(index)).frame(width: 5).cornerRadius(100).padding(.vertical, 10)
                        }
                    }
                    .onDelete(perform: deleteHistoryAtIndex)
                }
                .navigationBarTitle("History Details", displayMode: .inline)
            }
        }

    private func colorForIndex(_ index: Int) -> Color {
        switch index {
        case 0:
            return Color.green
        case 1...5:
            return Color.orange
        case 6...10:
            return Color.purple
        case 11...20:
            return Color.red
        default:
            return Color.brown
        }
    }

    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.accentColor)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(value)
                    .font(.footnote)
            }
        }
        .padding(.top, 5)
    }

    private func deleteHistoryAtIndex(at offsets: IndexSet) {
            for offset in offsets {
                record.status.remove(at: offset)
                record.comments.remove(at: offset)
                record.users.remove(at: offset)
                record.dates.remove(at: offset)

                databaseManager.updateSpecificHistoryRecord(recordId: record.id, newRecordData: record)
            }
            
            // This will refresh the parent view
            onDeletionComplete()

            // Refresh the local state in the sheet
            record = databaseManager.fetchSpecificHistoryRecord(recordId: record.id)
        }
    }


#Preview {
    HistoryUpdateView()
}
