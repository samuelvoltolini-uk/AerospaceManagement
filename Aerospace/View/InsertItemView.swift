import SwiftUI
import PartialSheet

struct InsertItemView: View {
    
    @State private var showErrorSheet: Bool = false
    @State private var errorMessage: String = ""
    
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
    @State private var historyNumber: Int = 1 // Assuming non-editable
    @State private var comments: String = ""
    @State private var selectedFile: URL?
    
    @State private var skus: [String] = []
    
    @State private var isFavorite: Bool = false
    @State private var isPriority: Bool = false
    @State private var quantity: Double = 1
    
    @State private var receiveDate: Date = Date()
    @State private var expectedDate: Date = Date()
    
    @State private var manufacturers: [ManufacturerPicker] = []
    @State private var statuses: [StatusPicker] = []
    @State private var countriesOfOrigin: [CountryOfOriginPicker] = []
    @State private var clients: [ClientPicker] = []
    @State private var tags: [TagPicker] = []
    
    @State private var showDocumentPicker = false
    
    // Assuming loggedInUser is a property of your User model
    let loggedInUser: User
    private var currentDate: String {
        formatDate(Date())
    }
    
    var body: some View {
        Form {
            Section(header: labelWithIcon("Item Details", image: "InsertItem")) {
                TextField("Name", text: $itemName)
                TextField("Barcode", text: $barcode)
                TextField("Description", text: $description)
            }
            
            Section(header: labelWithIcon("Receive Date", image: "DateCreated")) {
                DatePicker("Select Date", selection: $receiveDate, displayedComponents: .date)
                    .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Expected Date", image: "Date")) {
                DatePicker("Select Date", selection: $expectedDate, displayedComponents: .date)
                    .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Manufacturer", image: "NewManufacturer")) {
                Picker("Select Manufacturer", selection: $manufacturer) {
                    ForEach(manufacturers, id: \.id) { option in
                        Text(option.name).tag(option.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Status", image: "StatusView")) {
                Picker("Select Status", selection: $status) {
                    ForEach(statuses, id: \.id) { status in
                        Text(status.name).tag(status.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Country of Origin", image: "CountryView")) {
                Picker("Select Country of Origin", selection: $origin) {
                    ForEach(countriesOfOrigin, id: \.id) { country in
                        Text(country.name).tag(country.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Select Client", image: "NewCustomer")) {
                Picker("Select Client", selection: $client) {
                    ForEach(clients, id: \.id) { client in
                        Text(client.name).tag(client.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Material", image: "MaterialView")) {
                TextField("Item Material", text: $material)
            }
            
            Section(header: labelWithIcon("Repair Company", image: "Repair")) {
                TextField("Repair Company 1", text: $repairCompanyOne)
                TextField("Repair Company 2", text: $repairCompanyTwo)
            }
            
            Section(header: labelWithIcon("History", image: "HistoryView")) {
                Text("\(historyNumber)")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Comments", image: "Comments")) {
                TextField("Comments", text: $comments)
            }
            
            Section(header: labelWithIcon("Assign Tag", image: "InsertTags")) {
                Picker("Tag Name", selection: $tagName) {
                    ForEach(tags, id: \.id) { tag in
                        Text(tag.name).tag(tag.name)
                    }
                }
                .foregroundStyle(Color.gray)
            }
            
            Section(header: labelWithIcon("Favorite Item", image: "Favorite")) {
                Toggle("Mark as Favorite", isOn: $isFavorite)
                    .tint(.accentColor)
            }
            
            Section(header: labelWithIcon("Priority", image: "Priority")) {
                Toggle("High Priority", isOn: $isPriority)
                    .tint(.accentColor)
            }
            
            Section(header: labelWithIcon("Quantity", image: "Quantity")) {
                Slider(value: $quantity, in: 1...10, step: 1, onEditingChanged: quantityChanged)
                Text("\(Int(quantity))")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
            }
            
            Section(header: labelWithIcon("SKU (Stock Keeping Unit)", image: "SKU")) {
                ForEach(0..<Int(quantity), id: \.self) { index in
                    TextField("SKU for item \(index + 1)", text: Binding(
                        get: { self.skus.count > index ? self.skus[index] : "" },
                        set: { self.skus[index] = $0 }
                    ))
                    .textInputAutocapitalization(.characters)
                    .keyboardType(.numberPad)
                }
            }
            
            
            Section(header: labelWithIcon("File", image: "Image")) {
                Button("Select File") {
                    showDocumentPicker = true
                }
                if let selectedFile = selectedFile {
                    Text(selectedFile.lastPathComponent)
                }
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker(selectedFile: $selectedFile)
            }
            
            Section(header: labelWithIcon("Created By", image: "WorkerID")) {
                HStack {
                    Text("User")
                    Spacer()
                    Text(loggedInUser.name)
                }
                HStack {
                    Text("Date")
                    Spacer()
                    Text(currentDate)
                }
            }
            .foregroundStyle(Color.gray)
            
            Button("Save") {
                // Validate required fields
                guard !itemName.isEmpty, !barcode.isEmpty, !description.isEmpty,
                      !material.isEmpty, !repairCompanyOne.isEmpty, !comments.isEmpty else {
                    errorMessage = "Please fill all required fields."
                    showErrorSheet = true
                    return
                }
                
                // Ensure all SKUs are provided
                guard skus.count == Int(quantity), !skus.contains(where: { $0.isEmpty }) else {
                    errorMessage = "Please provide SKUs for all items."
                    showErrorSheet = true
                    return
                }
                
                // Check if barcode or SKUs already exist
                let dbManager = DatabaseManager()
                if dbManager.barcodeExists(barcode) {
                    errorMessage = "Barcode already exists. Please use the update screen."
                    showErrorSheet = true
                    return
                }
                
                for sku in skus {
                    if dbManager.skuExists(sku) {
                        errorMessage = "SKU \(sku) is already in the system."
                        showErrorSheet = true
                        return
                    }
                }
                
                // Proceed with saving the item
                var fileData: Data? = nil
                if let selectedFileURL = selectedFile {
                    do {
                        fileData = try Data(contentsOf: selectedFileURL)
                    } catch {
                        errorMessage = "Error reading file data: \(error.localizedDescription)"
                        showErrorSheet = true
                        return
                    }
                }
                
                let newItem = Item(
                    name: itemName,
                    barcode: barcode,
                    SKU: skus,
                    description: description,
                    manufacturer: manufacturer,
                    status: status,
                    origin: origin,
                    client: client,
                    material: material,
                    repairCompanyOne: repairCompanyOne,
                    repairCompanyTwo: repairCompanyTwo,
                    historyNumber: historyNumber,
                    comments: comments,
                    tagName: tagName,
                    isFavorite: isFavorite,
                    isPriority: isPriority,
                    quantity: quantity,
                    receiveDate: receiveDate,
                    expectedDate: expectedDate,
                    file: fileData,
                    createdBy: loggedInUser.name,
                    creationDate: currentDate
                )
                
                dbManager.createItemsTable()
                dbManager.insertItem(item: newItem)
                
                // Reset fields or navigate away as needed after successful save
            }
            .frame(maxWidth: .infinity)
            
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Insert Item")
        .partialSheet(isPresented: $showErrorSheet) {
            VStack {
                Image("Attention")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(errorMessage)
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
            }
        }
        .attachPartialSheetToRoot()
        
        .onAppear {
            loadPickerData()
        }
    }
    
    
    private func validateFields() -> Bool {
        // Basic validation for empty fields
        if itemName.isEmpty || barcode.isEmpty || description.isEmpty ||
            material.isEmpty || repairCompanyOne.isEmpty || comments.isEmpty {
            errorMessage = "Please fill all required fields."
            showErrorSheet = true
            return false
        }
        
        // Validate SKUs
        if skus.contains(where: { $0.isEmpty }) || skus.count < Int(quantity) {
            errorMessage = "Please provide SKUs for all items."
            showErrorSheet = true
            return false
        }
        
        // Check if barcode or SKUs already exist in the database
        let dbManager = DatabaseManager()
        if dbManager.barcodeExists(barcode) {
            errorMessage = "Barcode already exists. Please use the update screen."
            showErrorSheet = true
            return false
        }
        
        for sku in skus {
            if dbManager.skuExists(sku) {
                errorMessage = "SKU \(sku) is already in the system."
                showErrorSheet = true
                return false
            }
        }
        
        return true
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
    
    private func quantityChanged(_ editing: Bool) {
        if !editing {
            // Adjust the size of the SKUs array to match the quantity
            skus = Array(skus.prefix(Int(quantity)))
            while skus.count < Int(quantity) {
                skus.append("")
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func labelWithIcon(_ text: String, image: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 20, height: 20)
            
            Text(text)
        }
    }
}

struct InsertItemView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertItemView(loggedInUser: mockUser)
    }
}
