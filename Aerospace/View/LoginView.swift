import SwiftUI
import PartialSheet

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingSheet = false
    @State private var alertMessage = ""
    
    @State private var navigationPath = NavigationPath()
    @State private var loggedInUser: User?

    let databaseManager = DatabaseManager()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Spacer()

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
                        .cornerRadius(8)
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
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                // Login Button
                Button(action: loginAction) {
                    Text("Login")
                        .frame(width: 150)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                }
                .disabled(email.isEmpty || password.isEmpty)
                .padding(.top, 20)
                .partialSheet(isPresented: $showingSheet) {
                    VStack {
                        Image("Denied")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text(alertMessage)
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                    }
                }
                
                Spacer()
                
                VStack {
                    Image("Staff")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                    
                    Text("Only staff members who have completed the registration process will be able to log in. If you are not yet registered, please return to the previous screen to sign up.")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .padding()
            .attachPartialSheetToRoot()
            .navigationDestination(for: User.self) { user in
                WelcomeView(user: user)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

    private func loginAction() {
        if let user = databaseManager.fetchUser(email: email, password: password) {
            loggedInUser = user
            navigationPath.append(user)
        } else {
            alertMessage = "Incorrect email or password."
            showingSheet = true
        }
    }
}

#Preview {
    LoginView()
}
