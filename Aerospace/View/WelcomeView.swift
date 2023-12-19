import SwiftUI

struct WelcomeView: View {
    
    let user: User
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Inventory"), footer: Text("Manage your inventory items, which includes the ability to add, edit, and delete items. Additionally, you can also view products flagged as favorites and as priority.")) {
                        NavigationLink(destination: ViewItemView()) {
                            HStack {
                                Image(systemName: "archivebox.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Overview")
                            }
                        }
                        NavigationLink(destination: InsertItemView(loggedInUser: user)) {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert Item")
                            }
                        }
                        
                        NavigationLink(destination: EditItemView(user: user)) {
                            HStack {
                                Image(systemName: "square.text.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Edit Item")
                            }
                        }
                        
                        
                        NavigationLink(destination: FavoritePriorityView()) {
                            HStack {
                                Image(systemName: "arrow.down.left.arrow.up.right.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.purple)
                                
                                Text("Favorite & Priority Change")
                            }
                        }
                        
                        NavigationLink(destination: FavoriteView()) {
                            HStack {
                                Image(systemName: "star.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Favorite View")
                            }
                        }
                        
                        NavigationLink(destination: PriorityView()) {
                            HStack {
                                Image(systemName: "exclamationmark.square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.green)
                                
                                Text("Priority View")
                            }
                        }
                    }
                    
                    Section(header: Text("Delete Full Item Invesntory"), footer: Text("Deleting an item will remove it entirely, including all quantities. Item history will not be deleted.").foregroundStyle(Color.purple)) {
                        
                        NavigationLink(destination: DeleteItemView()) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Delete Item")
                            }
                        }
                    }
                        
                    
                    Section(header: Text("Update SKU"), footer: Text("Access to delete or add new SKU")) {
                        
                        NavigationLink(destination: Text("")) {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                    //.renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert SKU")
                            }
                        }
                        
                        NavigationLink(destination: Text("Delete Item View")) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Delete SKU")
                            }
                        }
                    }
                    
                    Section(header: Text("Tags"), footer: Text("Organize your inventory with tags, allowing for easier item categorization and retrieval.")) {
                        NavigationLink(destination: DisplayTagsView()) {
                            HStack {
                                Image(systemName: "tag.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Overview")
                            }
                        }
                        NavigationLink(destination: InsertTagsView(loggedInUser: user)) {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert Tag")
                            }
                        }
                        NavigationLink(destination: DeleteTagView()) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Delete Tag")
                            }
                        }
                    }
                    
                    Section(header: Text("Manufacturer"), footer: Text("Enter, view and delete manufacturer.")) {
                        NavigationLink(destination: InsertManufacturerView(loggedInUser: user)) {
                            HStack {
                                
                                Image(systemName: "building.2.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert Manufacturer")
                            }
                        }
                        NavigationLink(destination: ManufacturerDeleteView()) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    
                    Section(header: Text("Status"), footer: Text("Enter, view and delete status.")) {
                        NavigationLink(destination: InsertStatusView(loggedInUser: user)) {
                            HStack {
                                Image(systemName: "checkmark.rectangle.stack.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert Status")
                            }
                        }
                        NavigationLink(destination: StatusDeleteView()) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Country Origin"), footer: Text("Enter, view and delete the country origin.")) {
                        NavigationLink(destination: InsertCountryView(loggedInUser: user)) {
                            HStack {
                                Image(systemName: "globe")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert Country")
                            }
                        }
                        
                        
                        
                        NavigationLink(destination: Text("Delete Customer")) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Client"), footer: Text("Enter, view and delete customers.")) {
                        NavigationLink(destination: InsertClientView(loggedInUser: user)) {
                            HStack {
                                Image(systemName: "person.crop.rectangle.stack.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert Customer")
                            }
                        }
                        NavigationLink(destination: ClientDeleteView()) {
                            HStack {
                                Image(systemName: "minus.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View & Delete")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("History"), footer: Text("View the history and log of all item transactions and modifications.")) {
                        NavigationLink(destination: Text("History View")) {
                            HStack {
                                Image(systemName: "calendar.badge.checkmark")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("History View")
                            }
                        }
                        NavigationLink(destination: Text("History View")) {
                            HStack {
                                Image(systemName: "calendar.badge.plus")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                            
                                Text("History Update")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Scan"), footer: Text("Quickly scan and update inventory items using barcode scanning.")) {
                        NavigationLink(destination: Text("Scan Item View")) {
                            HStack {
                                Image(systemName: "qrcode")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Scan Item")
                            }
                        }
                    }
                    
                    Section(header: Text("Warehouse Statistics"), footer: Text("Access detailed statistics and reports about your inventory.")) {
                        NavigationLink(destination: Text("Statistics View")) {
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Overview")
                            }
                        }
                    }
                    
                    Section(header: Text("Account and Configuration"), footer: Text("Configure settings and account preferences.")) {
                        NavigationLink(destination: Text("Settings View")) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Settings")
                            }
                        }
                    }
                    
                    Section(header: Text("Current User & Date"), footer: Text("Current user logged in and date.")) {
                        HStack {
                            Image(systemName: "person.text.rectangle")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Text("\(user.name)")
                                .foregroundStyle(Color.gray)
                        }
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
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
