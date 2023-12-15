import SwiftUI

struct ClientDeleteView: View {
    @State private var clients: [ClientFetch] = []
    let databaseManager = DatabaseManager()
    
    @State private var fetchFailed: Bool = false

    var body: some View {
            if fetchFailed {
                // Display when there are no clients
                VStack {
                    Image("NothingHere") // Replace with your 'Nothing to see here' image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Nothing to see here!")
                        .font(.headline)
                }
                
            } else {
                // Existing list view
                List {
                    ForEach(clients, id: \.id) { client in
                        VStack(alignment: .leading) {
                            HStack {
                                Image("NewCustomer")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(client.name).font(.headline)
                            }
                            .padding(.top, 5)

                            HStack {
                                Image("ManufacturerCode")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(client.code).font(.footnote)
                            }
                            .padding(.top, 5)

                            HStack {
                                Image("PhoneView")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(client.phoneNumber).font(.footnote)
                            }
                            .padding(.top, 5)

                            HStack {
                                Image("ContactView")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(client.email).font(.footnote)
                            }
                            .padding(.top, 5)

                            HStack {
                                Image("WorkerID")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(client.registeredBy).font(.footnote)
                                    .foregroundStyle(Color.gray)
                            }
                            .padding(.top, 5)

                            HStack {
                                Image("TagCreated")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(client.registrationDate).font(.footnote)
                                    .foregroundStyle(Color.gray)
                            }
                            .padding(.top, 5)
                        }
                    }
                    .onDelete(perform: deleteClient)
                }
                .navigationBarTitle("Clients")
                .onAppear {
                    fetchStatusIfFail()
                }
            }
        }
    
    
    func fetchStatusIfFail() {
        let result = databaseManager.fetchClients()
        if result.isEmpty {
            fetchFailed = true
        } else {
            clients = result
        }
    }

    private func deleteClient(at offsets: IndexSet) {
        offsets.forEach { index in
            let clientId = clients[index].id
            databaseManager.deleteClient(withId: clientId)
            clients.remove(at: index)
        }
        fetchStatusIfFail()
    }
}

#Preview {
    ClientDeleteView()
}
