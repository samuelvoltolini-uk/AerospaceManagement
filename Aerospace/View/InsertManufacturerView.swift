import SwiftUI
import PartialSheet

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
    
    @State private var showingErrorSheet = false
    @State private var errorMessage = ""
    
    let creationDate: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    
    let countries = ["United Kingdom","Australia","Austria","Brazil","Chile","China","Colombia","Denmark","France","Germany","Israel","Italy","Japan","Luxembourg","Mexico","New Zealand","Norway","Poland","Portugal","Romania","Russia","Singapore","South Africa","South Korea","Spain","Switzerland","Sweden"]
    
    
    var body: some View {
        Form {
            Section(header: HStack {
                Image("ManufacturerView")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("Manufacturer Identification")
            }) {
                TextField("Name", text: $manufacturerName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                
                TextField("Code", text: $manufacturerCode)
                    .textInputAutocapitalization(.characters)
            }
            
            Section(header: HStack {
                Image("AddressView")
                    .resizable()
                    .frame(width: 20, height: 20)
                
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
                Image("EmailView")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("Contact")
            }) {
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.numberPad)
                
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
            }
            
            Section(header: HStack {
                Image("WorkerID")
                    .resizable()
                    .frame(width: 20, height: 20)
                
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
                    .foregroundStyle(Color.accentColor)
            } else {
                Button("Save") {
                    if validateFields() {
                        if databaseManager.checkIfManufacturerExists(name: manufacturerName, code: manufacturerCode) {
                            errorMessage = "Manufacturer with same name or code already exists."
                            showingErrorSheet = true
                        } else {
                            saveManufacturer()
                        }
                    } else {
                        showingErrorSheet = true
                    }
                }
                .font(.callout)
                .frame(maxWidth: .infinity)
                .foregroundColor(.accentColor)
            }
        }
        .navigationTitle("New Manufacturer")
                .partialSheet(isPresented: $showingErrorSheet) {
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
                } // End of error sheet modifier
                .attachPartialSheetToRoot()
            }

    
    func validateFields() -> Bool {
        let fields = [manufacturerName, manufacturerCode, selectedCountry, stateOrProvince, postCode, street, number, phoneNumber]
        for field in fields {
            if field.isEmpty {
                errorMessage = "Please fill in all the fields."
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
