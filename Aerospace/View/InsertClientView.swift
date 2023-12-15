import SwiftUI

struct InsertClientView: View {
    @State private var customerName: String = ""
    @State private var customerCode: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var showErrorSheet: Bool = false
    @State private var errorMessage: String = ""
    
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
                    Image("NewCustomer")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
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
                    Image("EmailView")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
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
                    Image("WorkerID")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
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
                Button(action: {
                    // Validate input fields
                    if customerName.isEmpty || customerCode.isEmpty || phoneNumber.isEmpty || email.isEmpty {
                        errorMessage = "All fields must be filled."
                        showErrorSheet = true
                        return
                    }
                    
                    let dbManager = DatabaseManager()

                    // Check if customer name or code already exists
                    if dbManager.customerNameExists(name: customerName) {
                        errorMessage = "Customer name already exists."
                        showErrorSheet = true
                        return
                    }

                    if dbManager.customerCodeExists(code: customerCode) {
                        errorMessage = "Customer code already exists."
                        showErrorSheet = true
                        return
                    }

                    // Proceed with saving the client if all validations pass
                    isSaving = true
                    let newClient = Client(name: customerName, code: customerCode, phoneNumber: phoneNumber, email: email, registeredBy: loggedInUser.name, registrationDate: currentDateTime)
                    dbManager.createClientsTable()
                    dbManager.insertClient(client: newClient)
                    
                    // Simulate saving delay and then revert back to the save button
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isSaving = false
                        // Clear the fields or perform other actions after saving
                        customerName = ""
                        customerCode = ""
                        phoneNumber = ""
                        email = ""
                    }
                }) {
                    if isSaving {
                        ProgressView()
                    } else {
                        Text("Save")
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .navigationBarTitle("Insert Client", displayMode: .inline)
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
