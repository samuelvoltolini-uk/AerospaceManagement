import SwiftUI

struct Settings: View {
    @State private var users: [UserSettings] = []
    @State private var searchQuery = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    let databaseManager = DatabaseManager()

    let loggedInUserEmail: String  // The email of the currently logged-in user

    var body: some View {
        List {
            ForEach(filteredUsers, id: \.id) { user in
                HStack {
                    Image(systemName: "person.crop.square.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.accentColor)

                    VStack(alignment: .leading) {
                        Text(user.name)
                            .fontWeight(.bold)
                        Text(user.email)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(PlainListStyle())
        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Name")
        .navigationBarTitle("Users", displayMode: .inline)
        .onAppear {
            users = databaseManager.fetchAllUsers()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private var filteredUsers: [UserSettings] {
        if searchQuery.isEmpty {
            return users
        } else {
            return users.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]

            if loggedInUserEmail != "sam@icloud.com" {
                alertMessage = "You do not have permission to delete users."
                showAlert = true
            } else if user.email == loggedInUserEmail {
                alertMessage = "You cannot delete your own account."
                showAlert = true
            } else {
                databaseManager.deleteUser(withID: user.id)
                users.remove(at: index)
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(loggedInUserEmail: "sample@icloud.com")
    }
}
