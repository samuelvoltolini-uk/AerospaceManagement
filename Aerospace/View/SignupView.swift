import SwiftUI

struct SignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    let databaseManager = DatabaseManager()

    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            // Name Section
            VStack(alignment: .leading) {
                HStack {
                    Image("User")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text("Name")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                TextField("Full Name", text: $name)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Email Section
            VStack(alignment: .leading) {
                HStack {
                    Image("Email")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Email")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Password Section
            VStack(alignment: .leading) {
                HStack {
                    Image("Password")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Password")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(.horizontal)


            Button(action: {createAccount()}) {
                            Text("Create Account")
                                .frame(width: 150)
                                .padding()
                                .foregroundColor(.white)
                                .background(isFormValid ? Color.accentColor : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .padding(.top, 20)
            
            Spacer()
            
            VStack {
                Image("Security")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                
                Text("Please note that your login details will be stored in your iCloud account and processed exclusively on your device. No information will be processed on any external server.")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
            }
            
        }
        .padding()
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
    
    private func createAccount() {
            databaseManager.addUser(name: name, email: email, password: password)
            // Handle success or error accordingly
        }

    }




#Preview {
    SignupView()
}
