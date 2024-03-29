import SwiftUI

struct EditItemViewDetails: View {
    
    let databaseManager = DatabaseManager()
    
    let user: User
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    @State private var itemName: String = ""
    @State private var barcode: String = ""
    @State private var description: String = ""
    
    @State private var manufacturer: String = ""
    @State private var status: String = ""
    @State private var origin: String = ""
    @State private var client: String = ""
    @State private var tagName: String = ""
    @State private var material: String = ""
    @State private var repairCompanyOne: String = ""
    @State private var repairCompanyTwo: String = ""
    @State private var historyNumber: Int = 0
    @State private var comments: String = ""
    
    @State private var skus: [String] = []
    
    @State private var manufacturers: [ManufacturerPicker] = []
    @State private var statuses: [StatusPicker] = []
    @State private var countriesOfOrigin: [CountryOfOriginPicker] = []
    @State private var clients: [ClientPicker] = []
    @State private var tags: [TagPicker] = []
    
    private var currentDate: String {
        formatDate(Date())
    }
    
    @State var item: ItemFetch
    
    var body: some View {
        Form {
            Section(
                header: labelWithIcon("Item Details", image: "info.square.fill"),
                footer: Text("These fields cannot be edited. If you need to update this information, please create a new item and delete this one.")
            ) {
                TextField(item.name, text: $itemName)
                TextField(item.barcode, text: $barcode)
                TextField(item.description, text: $description)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Receive Date")
                    Spacer()
                    Text(formatDate(item.expectedDate))
                }
                HStack {
                    Text("Expect Date")
                    Spacer()
                    Text(formatDate(item.expectedDate))
                }
                HStack {
                    Text("History")
                    Spacer()
                    Text("\(historyNumber)")
                        .fontWeight(.bold)
                }
            }
            .disabled(true)
            .foregroundStyle(Color.gray)
            
            Section(header: labelWithIcon("SKU", image: "number.square.fill"), footer: Text("These fields cannot be edited. If you need to update this information, please go to edit SKU.")) {
                ForEach(Array(item.SKU.enumerated()), id: \.element) { index, sku in
                    HStack {
                        detailRow(icon: "shippingbox.fill", title: "SKU", value: sku)
                        Spacer()
                        Image(systemName: "\(String(format: "%02d", index + 1)).circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.accentColor)
                    }
                }
                .disabled(true)
            }
            
            
            Section(header: labelWithIcon("Assign Tag", image: "tag.square.fill"), footer: Text("Current: " + item.tagName)) {
                Picker("", selection: $tagName) {
                    ForEach(tags, id: \.id) { tag in
                        Text(tag.name).tag(tag.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Manufacturer", image: "building.2.fill"), footer: Text("Current: " + item.manufacturer)) {
                Picker("", selection: $manufacturer) {
                    ForEach(manufacturers, id: \.id) { option in
                        Text(option.name).tag(option.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Status", image: "arrow.left.arrow.right.square.fill"), footer: Text("Current: " + item.status)) {
                Picker("", selection: $status) {
                    ForEach(statuses, id: \.id) { status in
                        Text(status.name).tag(status.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Country of Origin", image: "globe"), footer: Text("Current: " + item.origin)) {
                Picker("", selection: $origin) {
                    ForEach(countriesOfOrigin, id: \.id) { country in
                        Text(country.name).tag(country.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Client", image: "airplane"), footer: Text("Current: " + item.client)) {
                Picker("", selection: $client) {
                    ForEach(clients, id: \.id) { client in
                        Text(client.name).tag(client.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Material", image: "diamond.fill"), footer: Text("Current: " + item.material)) {
                TextField("", text: $material)
                    .textInputAutocapitalization(.words)
            }
            
            Section(header: labelWithIcon("Repair Company", image: "wrench.adjustable.fill"), footer: Text("Current: " + item.repairCompanyOne + " - " + item.repairCompanyTwo)) {
                TextField("", text: $repairCompanyOne)
                    .textInputAutocapitalization(.words)
                TextField("", text: $repairCompanyTwo)
                    .textInputAutocapitalization(.words)
            }
            
            Section(header: labelWithIcon("Comments", image: "bubble.left.and.text.bubble.right.fill"), footer: Text("Current: " + item.comments)) {
                TextField("", text: $comments)
                    .textInputAutocapitalization(.sentences)
            }
            
            
            Section(header: labelWithIcon("Created By", image: "person.text.rectangle.fill")) {
                HStack {
                    Text("Current User")
                    Spacer()
                    Text(user.name)
                }
                HStack {
                    Text("Current Date")
                    Spacer()
                    Text(currentDate)
                }
            }
            .foregroundStyle(Color.gray)
            
            Section {
                // Add other content here if needed
                Button(action: validateAndSave) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.accentColor)
                        .fontWeight(.semibold)
                }
            }
            
            
        }
        .navigationBarTitle("Edit Item", displayMode: .inline)
        .onAppear {
            loadPickerData()
            let statusHistory = databaseManager.fetchStatusHistoryForItem(itemBarcode: item.barcode)
            historyNumber = statusHistory.count
        }
        .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
    }
    
    private func handleSubmit() {
        print("Updating item...")
        databaseManager.updateItem(
            barcode: item.barcode,
            tagName: tagName,
            manufacturer: manufacturer,
            status: status,
            origin: origin,
            client: client,
            material: material,
            repairCompanyOne: repairCompanyOne,
            repairCompanyTwo: repairCompanyTwo,
            comments: comments
        )
        
        print("Appending to history...")
        databaseManager.appendToHistory(
            name: item.name,
            itemBarcode: item.barcode,
            newStatus: status,
            newComments: comments,
            user: user
        )

        print("Operation completed.")
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
    
    private func loadPickerData() {
        let dbManager = DatabaseManager()
        manufacturers = dbManager.fetchManufacturersPicker()
        if let firstManufacturer = manufacturers.first {
            manufacturer = firstManufacturer.name
        }
        
        statuses = dbManager.fetchStatusesPicker()
        if let firstStatus = statuses.first {
            status = firstStatus.name
        }
        
        countriesOfOrigin = dbManager.fetchCountriesOfOriginPicker()
        if let firstCountry = countriesOfOrigin.first {
            origin = firstCountry.name
        }
        
        clients = dbManager.fetchClientsPicker()
        if let firstClient = clients.first {
            client = firstClient.name
        }
        
        tags = dbManager.fetchTagPicker()
        if let firstTag = tags.first {
            tagName = firstTag.name
        }
    }
    
    private func labelWithIcon(_ text: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            
            Text(text)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func validateAndSave() {
            if tagName.isEmpty || manufacturer.isEmpty || status.isEmpty || origin.isEmpty || client.isEmpty || material.isEmpty || repairCompanyOne.isEmpty || comments.isEmpty {
                alertMessage = "All fields are required. Please fill out the missing information."
                showAlert = true
                return
            }

        // If all fields are filled, call the save function
        handleSubmit()
        
        material = ""
        repairCompanyOne = ""
        repairCompanyTwo = ""
        comments = ""
    }
}


struct EditItemViewDetails_Previews: PreviewProvider {
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
        let mockUser = User(id: 1, name: "", email: "", password: "")
        
        // Return the view with the mock item
        EditItemViewDetails(user: mockUser, item: mockItem)
    }
}

