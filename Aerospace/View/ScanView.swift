import SwiftUI

struct ScanView: View {
    @State private var scannedBarcode: String?
    @State private var isScanning = false
    @State private var fetchedItem: ItemScan?
    @State private var errorMessage: String?

    let databaseManager = DatabaseManager() // Your database manager instance

    var body: some View {
        VStack {
            if let item = fetchedItem {
                ItemDetailsView(item: item)
            } else if let _ = errorMessage {
                // Display the placeholder image and text when an error occurs
                VStack {
                    Image("NothingHere5") // Placeholder image for empty state
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 600)
                    Text("Barcode not found!")
                        .font(.headline)
                }
            } else {
                Image("NothingHere6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    
                
                Button("Scan QR Code") {
                    isScanning = true
                }
                .frame(width: 200, height: 50) // Set the size of the button
                .background(Color.blue) // Choose your desired color
                .foregroundColor(.white)
                .cornerRadius(10) // Rounded corners
            }
        }
        .sheet(isPresented: $isScanning) {
            QRScannerView(scannedCode: $scannedBarcode, isScanning: $isScanning)
        }
        .onChange(of: scannedBarcode) { _, newValue in
            print("Scanned Barcode: \(String(describing: newValue))")
            if let barcode = newValue {
                fetchItemDetails(barcode)
            }
        }
    }

    private func fetchItemDetails(_ barcode: String) {
        print("Fetching details for barcode: \(barcode)")
        fetchedItem = databaseManager.fetchItemByBarcode(barcode: barcode)
        errorMessage = fetchedItem == nil ? "Item not found with this barcode" : nil
        print("Fetched item: \(String(describing: fetchedItem))")
    }
}

struct ItemDetailsView: View {
    var item: ItemScan

    var body: some View {
        List {
            Section(header: Text("Item Details")) {
                itemDetailRow(iconName: "info.square.fill", label: "Name", value: item.name)
                itemDetailRow(iconName: "qrcode.viewfinder", label: "Barcode", value: item.barcode)
                skusRow(skus: item.sku)
                itemDetailRow(iconName: "square.text.square.fill", label: "Description", value: item.description)
                itemDetailRow(iconName: "building.2.fill", label: "Manufacturer", value: item.manufacturer)
                itemDetailRow(iconName: "flag.square.fill", label: "Status", value: item.status)
                itemDetailRow(iconName: "mappin.square.fill", label: "Origin", value: item.origin)
                itemDetailRow(iconName: "person.crop.square.fill", label: "Client", value: item.client)
                itemDetailRow(iconName: "leaf.fill", label: "Material", value: item.material)
                itemDetailRow(iconName: "wrench.fill", label: "Repair Company One", value: item.repairCompanyOne)
                itemDetailRow(iconName: "wrench.and.screwdriver.fill", label: "Repair Company Two", value: item.repairCompanyTwo)
                itemDetailRow(iconName: "arrow.clockwise.square.fill", label: "History Number", value: String(item.historyNumber))
                itemDetailRow(iconName: "text.bubble.fill", label: "Comments", value: item.comments)
                itemDetailRow(iconName: "tag.square.fill", label: "Tag Name", value: item.tagName)
                itemDetailRow(iconName: "star.square.fill", label: "Is Favorite", value: item.isFavorite ? "Yes" : "No")
                itemDetailRow(iconName: "exclamationmark.square.fill", label: "Is Priority", value: item.isPriority ? "Yes" : "No")
                quantityRow(value: item.quantity)
                itemDetailRow(iconName: "person.text.rectangle.fill", label: "Created By", value: item.createdBy)
                itemDetailRow(iconName: "calendar.badge.plus", label: "Creation Date", value: item.creationDate)
            }
        }
        .navigationBarTitle("Scanned Item", displayMode: .inline)
    }

    private func itemDetailRow(iconName: String, label: String, value: String) -> some View {
           HStack {
               Image(systemName: iconName)
                   .renderingMode(.original)
                   .resizable()
                   .scaledToFit()
                   .frame(width: 30, height: 30)
                   .foregroundStyle(Color.accentColor)
                   
               VStack(alignment: .leading) {
                   Text(label)
                       .font(.subheadline)
                       .foregroundColor(.secondary)
                   Text(value)
                       .font(.body)
               }
           }
           .padding(.vertical, 2)
       }

       private func skusRow(skus: String) -> some View {
           VStack(alignment: .leading) {
               ForEach(Array(skus.split(separator: ",").enumerated()), id: \.offset) { index, sku in
                   HStack {
                       skuIcon(for: index + 1)
                       Text(String(sku))
                           .font(.body)
                   }
               }
           }
       }

       private func skuIcon(for number: Int) -> some View {
           let iconName: String
           if number >= 1 && number <= 50 {
               iconName = "\(number).circle.fill"
           } else {
               iconName = "circle.fill" // Fallback icon
           }
           return Image(systemName: iconName)
               .renderingMode(.original)
               .resizable()
               .scaledToFit()
               .frame(width: 30, height: 30)
               .foregroundStyle(Color.accentColor)
       }

       private func quantityRow(value: Double) -> some View {
           let iconName: String
           if value >= 1 && value <= 50 {
               iconName = "\(Int(value)).square.fill"
           } else {
               iconName = "number.square.fill" // Fallback icon
           }

           return itemDetailRow(iconName: iconName, label: "Quantity", value: String(value))
       }
   }


#Preview {
    ScanView()
}
