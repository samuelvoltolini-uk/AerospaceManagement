import SwiftUI
import PartialSheet

struct SignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showingErrorSheet: Bool = false
    @State private var errorMessage: String = ""

    let databaseManager = DatabaseManager()

    var body: some View {

            Form {
                Section(header: labelWithIcon("Name", image: "person.fill.badge.plus")) {
                    TextField("Full Name", text: $name)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }

                Section(header: labelWithIcon("Email", image: "at.badge.plus")) {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                }

                Section(header: labelWithIcon("Password", image: "person.badge.key.fill")) {
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Spacer() // Push the button to the edge
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.accentColor)
                        }
                        .buttonStyle(PlainButtonStyle()) // Apply plain button style
                        //.padding(8) // Add padding around the button
                    }
                }

                Section {
                    Button("Create Account") {
                        attemptCreateAccount()
                        
                        name = ""
                        email = ""
                        password = ""
                    }
                    .disabled(!isFormValid)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
                }
            }
            .navigationBarTitle("Signup", displayMode: .inline)
            .scrollDisabled(true)
            .partialSheet(isPresented: $showingErrorSheet) {
                VStack {
                    Image(systemName: "questionmark.square.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.accentColor)
                    
                    Text(errorMessage)
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
            }
            .attachPartialSheetToRoot()
    }

    private var isFormValid: Bool {
        !name.isEmpty && isValidEmail(email) && isValidPassword(password)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        let passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPred.evaluate(with: password)
    }

    private func attemptCreateAccount() {
        if databaseManager.userExists(email: email) {
            errorMessage = "A user with this email already exists. Please try another email."
            showingErrorSheet = true
        } else {
            createAccount()
        }
    }

    private func createAccount() {
        databaseManager.addUser(name: name, email: email, password: password)
        // Handle success or error accordingly
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
}

#Preview {
    SignupView()
}
