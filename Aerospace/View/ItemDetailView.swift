import SwiftUI
import RealityKit
import ARKit


    struct ItemDetailView: View {
        
        var item: ItemFetch
        
        @State private var showingARView = false
        
        @State private var selectedRotationAxis: Axis = .y
        
        let databaseManager = DatabaseManager()
        
        var body: some View {
            List {
                Group {
                    detailRow(icon: "info.square.fill", title: "Item", value: item.name)
                    if let fileData = item.fileData {
                        HStack {
                            detailRow(icon: "rotate.3d.fill", title: "AR View", value: "Click to view in AR")
                                .foregroundStyle(Color.accentColor)
                            Button("") {
                                showingARView = true
                            }
                            Spacer()
                            Image(systemName: "view.3d")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.orange)
                        }
                                    .sheet(isPresented: $showingARView) {
                                        VStack {
                                            // Displaying the name of the product with an icon
                                            HStack {
                                                Image(systemName: "info.square.fill")
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundStyle(Color.accentColor)
                                                    .padding(.horizontal, 2)
                                                
                                                
                                                
                                                Text(item.name)
                                                    .font(.footnote)
                                                    .fontWeight(.bold)
                                            }
                                            }
                                        .padding(.top, 10)
                                        .padding(.bottom, 2)

                                            // ARViewContainer
                                            ARViewContainer(data: fileData, selectedRotationAxis: $selectedRotationAxis)
                                                .edgesIgnoringSafeArea(.all)

                                        HStack {
                                            Button(action: { selectedRotationAxis = .x }) {
                                                Image(systemName: "x.square.fill")
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 25, height: 25)
                                                    .foregroundStyle(Color.accentColor)
                                            }
                                            .padding(.trailing, 15)

                                            // Quantity Indicator
                                            Image(systemName: "\(min(max(item.quantity, 1), 10)).square.fill")
                                                .renderingMode(.original)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(colorForQuantity(item.quantity))

                                            Button(action: { selectedRotationAxis = .y }) {
                                                Image(systemName: "y.square.fill")
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 25, height: 25)
                                                    .foregroundStyle(Color.accentColor)
                                            }
                                            .padding(.leading, 15)
                                        }

                                        // Function to determine color based on quantity
                        

                                            .padding()
                                            
                                        }
                                }
                    detailRow(icon: "barcode", title: "Barcode", value: item.barcode)
                    ForEach(Array(item.SKU.enumerated()), id: \.element) { index, sku in
                        HStack {
                            detailRow(icon: "shippingbox.fill", title: "SKU", value: sku)
                            Spacer()
                            Image(systemName: "\(String(format: "%02d", index + 1)).circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.accentColor)
                        }
                    }
                    detailRow(icon: "square.text.square.fill", title: "Description", value: item.description)
                    detailRow(icon: "building.2.fill", title: "Manufacturer", value: item.manufacturer)
                    detailRow(icon: "flag.square.fill", title: "Status", value: item.status)
                    detailRow(icon: "globe", title: "Origin", value: item.origin)
                }
                .padding(3)
                Group {
                    detailRow(icon: "person.fill", title: "Client", value: item.client)
                    detailRow(icon: "hammer.fill", title: "Material", value: item.material)
                    detailRow(icon: "wrench.fill", title: "Repair Company I", value: item.repairCompanyOne)
                    detailRow(icon: "wrench.and.screwdriver.fill", title: "Repair Company II", value: item.repairCompanyTwo)
                    detailRow(icon: "clock.arrow.2.circlepath", title: "History Number", value: String(item.historyNumber))
                    detailRow(icon: "text.bubble.fill", title: "Comments", value: item.comments)
                    detailRow(icon: "tag.fill", title: "Tag Name", value: item.tagName)
                }
                .padding(3)
                
                Group {
                    detailRow(icon: "star.square.fill", title: "Is Favorite", value: item.isFavorite ? "Yes" : "No")
                    detailRow(icon: "number.square.fill", title: "Is Priority", value: item.isPriority ? "Yes" : "No")
                    detailRow(icon: "circle.hexagonpath.fill", title: "Quantity", value: String(item.quantity))
                    detailRow(icon: "calendar.badge.plus", title: "Receive Date", value: formatDate(item.receiveDate))
                    detailRow(icon: "calendar.badge.exclamationmark", title: "Expected Date", value: formatDate(item.expectedDate))
                    detailRow(icon: "person.text.rectangle.fill", title: "Created By", value: item.createdBy)
                    detailRow(icon: "calendar", title: "Creation Date", value: item.creationDate)
                }
                .padding(3)
            }
            .navigationBarTitle("Item Details", displayMode: .inline)
            .scrollIndicators(.hidden)
            
            
        
    }

    private func detailRow(icon: String, title: String, value: String) -> some View {
            HStack {
                Image(systemName: icon)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.accentColor)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    
                    Text(value)
                        .font(.caption)
                }

        }
    }
        
        private func iconName(for sku: String) -> String {
            guard let skuNumber = Int(sku), skuNumber >= 1, skuNumber <= 10 else {
                return "circle.fill" // Default icon
            }
            return "\(String(format: "%02d", skuNumber)).circle.fill"
        }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
        
        
}

func colorForQuantity(_ quantity: Int) -> Color {
    switch quantity {
    case 1...2:
        return .red
    case 3...4:
        return .orange
    case 5...6:
        return .yellow
    case 7...8:
        return .green
    case 9...10:
        return .blue
    default:
        return .gray
    }
}




struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock item to preview the view
        let mockItem = ItemFetch(
            id: 1,
            name: "Mock Item",
            barcode: "123456789",
            SKU: ["SKU1", "SKU2"],
            quantity: 10,
            description: "This is a mock item for preview purposes.",
            manufacturer: "Mock Manufacturer",
            status: "Available",
            origin: "Mock Origin",
            client: "Mock Client",
            material: "Mock Material",
            repairCompanyOne: "Repair Company 1",
            repairCompanyTwo: "Repair Company 2",
            historyNumber: 1,
            comments: "No comments",
            tagName: "Mock Tag",
            isFavorite: true,
            isPriority: false,
            receiveDate: Date(),
            expectedDate: Date(),
            fileData: nil, // Assuming no file for preview
            createdBy: "Mock User",
            creationDate: "13-07-1996"
        )

        // Return the view with the mock item
        ItemDetailView(item: mockItem)
    }
}
