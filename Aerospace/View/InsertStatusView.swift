import SwiftUI
import PartialSheet

struct InsertStatusView: View {
    @State private var statusName: String = ""
    @State private var statusDescription: String = ""
    @State private var showingSheet = false
    @State private var sheetMessage = ""
    @State private var isSubmitting = false
    @State private var showProgressView = false

    let databaseManager = DatabaseManager()
    let loggedInUser: User
    let currentDate = Date()

    var body: some View {
        
            Form {
                Section(header: headerWithIcon("StatusView", title: "Status Details")) {
                    TextField("Status Name", text: $statusName)
                        .textInputAutocapitalization(.words)
                    TextField("Description", text: $statusDescription)
                        .textInputAutocapitalization(.sentences)
                }
                
                Section(header: headerWithIcon("User", title: "User Information")) {
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
                            .foregroundStyle(Color.accentColor)
                        
                    } else {
                        Button("Submit") {
                            
                            databaseManager.createStatusTable()
                            
                            submitStatus()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Insert Status")
            .partialSheet(isPresented: $showingSheet) {
                    VStack {
                        Image("Attention")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text(sheetMessage)
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                    }
            }
            .attachPartialSheetToRoot()
    }
    
    private func currentDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: currentDate)
    }
    
    private func headerWithIcon(_ iconName: String, title: String) -> some View {
        HStack {
            Image(iconName)
                .resizable()
                .frame(width: 20, height: 20)
            Text(title)
        }
    }
    
    private func submitStatus() {
        guard !statusName.isEmpty, !statusDescription.isEmpty else {
            sheetMessage = "Status name and description cannot be blank."
            showingSheet = true
            return
        }

        if databaseManager.statusExists(name: statusName) {
            sheetMessage = "Status already exists."
            showingSheet = true
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
                sheetMessage = "Error creating status."
                showingSheet = true
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
