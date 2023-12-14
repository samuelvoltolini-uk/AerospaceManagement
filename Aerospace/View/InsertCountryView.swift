import SwiftUI
import PartialSheet

struct InsertCountryView: View {
    
    @State private var errorMessage: String = ""
    
    @State private var isSaving: Bool = false
    
    @State private var countryOfOrigin: String = ""
    @State private var showErrorSheet: Bool = false
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
                        Image("CountryView")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Country Details")
                    }) {
                    TextField("Country of Origin", text: $countryOfOrigin)
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
                
                Button(action: {
                    
                    databaseManager.createCountryTable()
                    
                    if countryOfOrigin.isEmpty {
                        errorMessage = "Country of Origin cannot be empty."
                        showErrorSheet = true
                    } else if databaseManager.countryExists(name: countryOfOrigin) {
                        errorMessage = "This country already exists."
                        showErrorSheet = true
                    } else {
                        isSaving = true
                        databaseManager.insertCountry(name: countryOfOrigin, userName: loggedInUser.name, creationDate: currentDateTime)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isSaving = false
                            countryOfOrigin = ""
                        }
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
            .navigationBarTitle("Enter Details", displayMode: .inline)
        .partialSheet(isPresented: $showErrorSheet) {
            // Error message content
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
            .padding()
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

struct InsertCountryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(id: 1, name: "", email: "", password: "")
        InsertCountryView(loggedInUser: mockUser)
    }
}
