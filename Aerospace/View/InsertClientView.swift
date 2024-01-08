import SwiftUI

struct InsertClientView: View {
    @State private var customerName: String = ""
    @State private var customerCode: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isSaving: Bool = false
    
    // Assuming loggedInUser is a property of your User model
    let loggedInUser: User
    private var currentDateTime: String {
        formatDate(Date())
    }
    
    var body: some View {
        
        Form {
            // Customer Details Section
            Section(header:
                        HStack {
                Image(systemName: "info.square.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("Customer Details")
            }) {
                TextField("Customer Name", text: $customerName)
                    .textInputAutocapitalization(.words)
                
                TextField("Customer Code", text: $customerCode)
                    .textInputAutocapitalization(.characters)
            }
            
            // Contact Information Section
            Section(header:
                        HStack {
                Image(systemName: "phone.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("Contact Information")
                
            }) {
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            // User and Date Section
            Section(header:
                        HStack {
                Image(systemName: "person.text.rectangle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("User and Date")
            }) {
                HStack {
                    Text("User")
                    Spacer()
                    Text(loggedInUser.name)
                }
                
                HStack {
                    Text("Current Date")
                    Spacer()
                    Text(currentDateTime)
                        .foregroundColor(.gray)
                }
            }
            .foregroundStyle(Color.gray)
            
            
            // Save Button
            Button(action: saveClient) {
                if isSaving {
                    ProgressView()
                        .tint(.accentColor)
                } else {
                    Text("Save")
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.accentColor)
            .fontWeight(.semibold)
        }
        .navigationBarTitle("Insert Client", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func saveClient() {
        // Validate input fields
        if customerName.isEmpty || customerCode.isEmpty || phoneNumber.isEmpty || email.isEmpty {
            alertMessage = "All fields must be filled."
            showAlert = true
            return
        }
        
        let dbManager = DatabaseManager()
        
        // Check if customer name or code already exists
        if dbManager.customerNameExists(name: customerName) {
            alertMessage = "Customer name already exists."
            showAlert = true
            return
        }
        
        if dbManager.customerCodeExists(code: customerCode) {
            alertMessage = "Customer code already exists."
            showAlert = true
            return
        }
        
        // Proceed with saving the client
        isSaving = true
        let newClient = Client(name: customerName, code: customerCode, phoneNumber: phoneNumber, email: email, registeredBy: loggedInUser.name, registrationDate: currentDateTime)
        dbManager.createClientsTable()
        dbManager.insertClient(client: newClient)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSaving = false
            resetFormFields()
        }
    }
    
    private func resetFormFields() {
        customerName = ""
        customerCode = ""
        phoneNumber = ""
        email = ""
    }
    
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


struct InsertClientView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertClientView(loggedInUser: mockUser)
    }
}
