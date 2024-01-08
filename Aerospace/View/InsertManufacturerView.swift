import SwiftUI

struct InsertManufacturerView: View {
    
    @State private var isSaving: Bool = false
    
    @State private var manufacturerName: String = ""
    @State private var manufacturerCode: String = ""
    @State private var selectedCountry: String = "United Kingdom"
    @State private var stateOrProvince: String = ""
    @State private var postCode: String = ""
    @State private var street: String = ""
    @State private var number: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var createdBy: String = ""
    
    let databaseManager = DatabaseManager()
    let loggedInUser: User
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let creationDate: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    
    let countries = ["United Kingdom","Australia","Austria","Brazil","Chile","China","Colombia","Denmark","France","Germany","Israel","Italy","Japan","Luxembourg","Mexico","New Zealand","Norway","Poland","Portugal","Romania","Russia","Singapore","South Africa","South Korea","Spain","Switzerland","Sweden"]
    
    
    var body: some View {
        Form {
            Section(header: HStack {
                Image(systemName: "info.square.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("Manufacturer Identification")
            }) {
                TextField("Name", text: $manufacturerName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                
                TextField("Code", text: $manufacturerCode)
                    .textInputAutocapitalization(.characters)
            }
            
            Section(header: HStack {
                Image(systemName: "globe")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("Address")
            }) {
                Picker("Country", selection: $selectedCountry) {
                    ForEach(countries, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                TextField("State/Province/County", text: $stateOrProvince)
                    .textInputAutocapitalization(.words)
                
                TextField("Post Code", text: $postCode)
                    .textInputAutocapitalization(.characters)
                
                TextField("Street", text: $street)
                    .textInputAutocapitalization(.words)
                
                TextField("Number", text: $number)
                    .keyboardType(.phonePad)
            }
            
            Section(header: HStack {
                Image(systemName: "phone.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("Contact")
            }) {
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.numberPad)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            
            Section(header: HStack {
                Image(systemName: "person.text.rectangle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("User")
                
            }) {
                Text(loggedInUser.name)
                    .foregroundStyle(Color.gray)
                Text("\(creationDate)")
                    .foregroundStyle(Color.gray)
            }
            if isSaving {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .tint(.accentColor)
                
            } else {
                Button("Save") {
                    if validateFields() {
                        if databaseManager.checkIfManufacturerExists(name: manufacturerName, code: manufacturerCode) {
                            alertMessage = "Manufacturer with same name or code already exists."
                            showAlert = true
                        } else {
                            saveManufacturer()
                        }
                    } else {
                        showAlert = true
                    }
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
            }
        }
        .navigationTitle("New Manufacturer")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    
    
    func validateFields() -> Bool {
        let fields = [manufacturerName, manufacturerCode, selectedCountry, stateOrProvince, postCode, street, number, phoneNumber]
        for field in fields {
            if field.isEmpty {
                alertMessage = "Please fill in all the fields."
                return false
            }
        }
        return true
    }
    
    func saveManufacturer() {
        isSaving = true
        databaseManager.createManufacturerTable()
        databaseManager.insertManufacturer(name: manufacturerName, code: manufacturerCode, country: selectedCountry, stateOrProvince: stateOrProvince, postCode: postCode, street: street, number: number, phoneNumber: phoneNumber, email: email, createdBy: loggedInUser.name, creationDate: creationDate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSaving = false
            resetFormFields()
        }
    }
    
    func resetFormFields() {
        manufacturerName = ""
        manufacturerCode = ""
        selectedCountry = "United Kingdom"
        stateOrProvince = ""
        postCode = ""
        street = ""
        number = ""
        phoneNumber = ""
        email = ""
    }
}



struct InsertManufacturerView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertManufacturerView(loggedInUser: mockUser)
    }
}
