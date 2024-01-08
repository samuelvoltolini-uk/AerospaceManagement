import SwiftUI

struct InsertStatusView: View {
    
    @State private var statusName: String = ""
    @State private var statusDescription: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSubmitting = false
    @State private var showProgressView = false
    
    let databaseManager = DatabaseManager()
    let loggedInUser: User
    let currentDate = Date()
    
    
    var body: some View {
        
        Form {
            Section(header: headerWithIcon("info.square.fill", title: "Status Details")) {
                TextField("Status Name", text: $statusName)
                    .textInputAutocapitalization(.words)
                TextField("Description", text: $statusDescription)
                    .textInputAutocapitalization(.sentences)
            }
            
            Section(header: headerWithIcon("person.text.rectangle.fill", title: "User Information")) {
                HStack {
                    Text("User")
                    Spacer()
                    Text(loggedInUser.name)
                }
                .foregroundStyle(Color.gray)
                
                HStack {
                    Text("Current Date")
                    Spacer()
                    Text(currentDateFormatted())
                }
                .foregroundStyle(Color.gray)
            }
            
            Section {
                if showProgressView {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity)
                        .tint(.accentColor)
                    
                } else {
                    Button("Save") {
                        submitStatus()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
                }
            }
        }
        .navigationTitle("Insert Status")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    private func currentDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: currentDate)
    }
    
    private func headerWithIcon(_ iconName: String, title: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.accentColor)
            
            Text(title)
        }
    }
    
    private func submitStatus() {
        guard !statusName.isEmpty, !statusDescription.isEmpty else {
            alertMessage = "Status name and description cannot be blank."
            showAlert = true
            return
        }
        
        if databaseManager.statusExists(name: statusName) {
            alertMessage = "Status already exists."
            showAlert = true
            return
        }
        
        isSubmitting = true
        showProgressView = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let success = databaseManager.insertStatus(name: statusName, description: statusDescription, user: loggedInUser.name, date: currentDate)
            if success {
                statusName = ""
                statusDescription = ""
                // Optionally, handle successful submission here
            } else {
                alertMessage = "Error creating status."
                showAlert = true
            }
            isSubmitting = false
            showProgressView = false
        }
    }
}

struct InsertStatusView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertStatusView(loggedInUser: mockUser)
    }
}
