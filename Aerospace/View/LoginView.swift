import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
        @State private var password: String = ""
        @State private var isPasswordVisible: Bool = false
        @State private var showAlert = false
        
        @State private var navigationPath = NavigationPath()
        @State private var loggedInUser: User?

        let databaseManager = DatabaseManager()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            Form {
                // Email Section
                Section(header: labelWithIcon("Email", image: "at")) {
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                }

                // Password Section
                Section(header: labelWithIcon("Password", image: "lock.open.fill")) {
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter your password", text: $password)
                        } else {
                            SecureField("Enter your password", text: $password)
                        }
                        Spacer() // Add a spacer to push the button to the edge
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

                // Login Button Section
                Section {
                    Button(action: loginAction) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.accentColor)
                            .fontWeight(.semibold)
                    }
                    .disabled(email.isEmpty || password.isEmpty)
                }
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .alert("Login Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Incorrect email or password.")
            }
            .navigationDestination(for: User.self) { user in
                WelcomeView(user: user)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .scrollDisabled(true)
    }

    private func loginAction() {
        if let user = databaseManager.fetchUser(email: email, password: password) {
            DispatchQueue.main.async {
                self.loggedInUser = user
                self.navigationPath.append(user)
            }
        } else {
            showAlert = true
        }
    }

    private func labelWithIcon(_ text: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.accentColor)
            Text(text)
        }
    }
}

#Preview {
    LoginView()
}
