import SwiftUI

struct WelcomeView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Inventory"), footer: Text("Manage your inventory items, including adding, editing, and deleting items.")) {
                        NavigationLink(destination: Text("Overview View")) {
                            HStack {
                                Image("ItemOverview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                
                                Text("Overview")
                            }
                        }
                        NavigationLink(destination: Text("Insert Item View")) {
                            HStack {
                                Image("InsertItem")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Insert Item")
                            }
                        }
                        NavigationLink(destination: Text("Edit Item View")) {
                            HStack {
                                Image("EditItem")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Edit Item")
                            }
                        }
                        NavigationLink(destination: Text("Delete Item View")) {
                            HStack {
                                Image("DeleteItem")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Delete Item")
                            }
                        }
                    }
                    
                    Section(header: Text("Tags"), footer: Text("Organize your inventory with tags, allowing for easier item categorization and retrieval.")) {
                        NavigationLink(destination: DisplayTagsView()) {
                            HStack {
                                Image("TagsOverview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Overview")
                            }
                        }
                        NavigationLink(destination: InsertTagsView(loggedInUser: user)) {
                            HStack {
                                Image("InsertTags")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Insert Tag")
                            }
                        }
                        NavigationLink(destination: DeleteTagView()) {
                            HStack {
                                Image("DeleteTags")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Delete Tag")
                            }
                        }
                    }
                    
                    Section(header: Text("Manufacturer"), footer: Text("Enter, view and delete manufacturer.")) {
                        NavigationLink(destination: InsertManufacturerView(loggedInUser: user)) {
                            HStack {
                                Image("NewManufacturer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Insert Manufacturer")
                            }
                        }
                        NavigationLink(destination: ManufacturerDeleteView()) {
                            HStack {
                                Image("ViewManufacturer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    
                    Section(header: Text("Status"), footer: Text("Enter, view and delete status.")) {
                        NavigationLink(destination: InsertStatusView(loggedInUser: user)) {
                            HStack {
                                Image("NewStatus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Insert Status")
                            }
                        }
                        NavigationLink(destination: StatusDeleteView()) {
                            HStack {
                                Image("ViewStatus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Country Origin"), footer: Text("Enter, view and delete the country origin.")) {
                        NavigationLink(destination: InsertCountryView(loggedInUser: user)) {
                            HStack {
                                Image("NewCountry")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Insert Country")
                            }
                        }
                        NavigationLink(destination: Text("Delete Customer")) {
                            HStack {
                                Image("ViewCountry")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Client"), footer: Text("Enter, view and delete customers.")) {
                        NavigationLink(destination: Text("Insert Client")) {
                            HStack {
                                Image("NewCustomer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Insert Customer")
                            }
                        }
                        NavigationLink(destination: Text("Delete Client")) {
                            HStack {
                                Image("ViewCustomer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("History"), footer: Text("View the history and log of all item transactions and modifications.")) {
                        NavigationLink(destination: Text("History View")) {
                            HStack {
                                Image("HistoryView")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("History View")
                            }
                        }
                        NavigationLink(destination: Text("History View")) {
                            HStack {
                                Image("HistoryUpdate")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("History Update")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Scan"), footer: Text("Quickly scan and update inventory items using barcode scanning.")) {
                        NavigationLink(destination: Text("Scan Item View")) {
                            HStack {
                                Image("ScanView")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Scan Item")
                            }
                        }
                    }
                    
                    Section(header: Text("Warehouse Statistics"), footer: Text("Access detailed statistics and reports about your inventory.")) {
                        NavigationLink(destination: Text("Statistics View")) {
                            HStack {
                                Image("StatisticsView")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Overview")
                            }
                        }
                    }
                    
                    Section(header: Text("Account and Configuration"), footer: Text("Configure settings and account preferences.")) {
                        NavigationLink(destination: Text("Settings View")) {
                            HStack {
                                Image("SettingsView")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Settings")
                            }
                        }
                    }
                    
                    Section(header: Text("Current User & Date"), footer: Text("Current user logged in and date.")) {
                        HStack {
                            Image("User")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("\(user.name)")
                                .foregroundStyle(Color.gray)
                        }
                        HStack {
                            Image("Date")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text(currentDateTime)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .disabled(true)
                }
            }
            .navigationTitle("Aerospace Manager")
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var currentDateTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(user: User(id: 1, name: "John Doe", email: "", password: ""))
    }
}
