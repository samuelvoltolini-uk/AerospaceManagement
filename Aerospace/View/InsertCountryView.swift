import SwiftUI

struct InsertCountryView: View {
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isSaving: Bool = false
    
    @State private var countryOfOrigin: String = ""
    private var currentDateTime: String {
        formatDate(Date())
    }
    
    let loggedInUser: User
    let databaseManager = DatabaseManager()
    
    var body: some View {
        Form {
            // Country Details Section
            Section(header:
                        HStack {
                Image(systemName: "info.square.fill")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.accentColor)
                
                Text("Country Details")
            }) {
                TextField("Country of Origin", text: $countryOfOrigin)
                    .textInputAutocapitalization(.words)
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
            
            Button(action: saveCountry) {
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
        .navigationBarTitle("Enter Details", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    private func saveCountry() {
        if countryOfOrigin.isEmpty {
            alertMessage = "Country of Origin cannot be empty."
            showAlert = true
            return
        }
        
        if databaseManager.countryExists(name: countryOfOrigin) {
            alertMessage = "This country already exists."
            showAlert = true
            return
        }
        
        isSaving = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            databaseManager.createCountryTable()
            databaseManager.insertCountry(name: countryOfOrigin, userName: loggedInUser.name, creationDate: currentDateTime)
            isSaving = false
            countryOfOrigin = ""
        }
    }
    
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct InsertCountryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertCountryView(loggedInUser: mockUser)
    }
}
