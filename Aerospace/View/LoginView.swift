import SwiftUI
import PartialSheet

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showingSheet = false
    @State private var alertMessage = ""
    
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
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.accentColor)
                        }
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
            .partialSheet(isPresented: $showingSheet) {
                VStack {
                    Image(systemName: "questionmark.square.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.accentColor)
                        .padding(.top, 5)
                    
                    Text(alertMessage)
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
            }
            .attachPartialSheetToRoot()
            .navigationDestination(for: User.self) { user in
                WelcomeView(user: user)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .scrollDisabled(true)
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

    private func labelWithIcon(_ text: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.accentColor)
            Text(text)
        }
    }
}

#Preview {
    LoginView()
}
