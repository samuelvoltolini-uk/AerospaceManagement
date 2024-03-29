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
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    //.foregroundStyle(Color.green)
                                
                                Text("Priority View")
                            }
                        }
                    }
                    
                    Section(header: Text("Scan"), footer: Text("Efficiently review and verify inventory items with the added capability of machine learning. Users can effortlessly identify item names by simply pointing the camera at them.")) {
                        NavigationLink(destination: ScanView()) {
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
                        
                        NavigationLink(destination: MLView()) {
                            HStack {
                                Image(systemName: "scale.3d")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Machine Learning Inventory")
                            }
                        }
                    }
                    
                    Section(header: Text("View By"), footer: Text("Access to view items by diferente metrics")) {
                        
                        NavigationLink(destination: ViewByTags()) {
                            HStack {
                                Image(systemName: "tag.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.pink)
                                
                                Text("View by Tags")
                            }
                        }
                        
                        NavigationLink(destination: ViewByManufacturer()) {
                            HStack {
                                Image(systemName: "lightswitch.on.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.indigo)
                                
                                Text("View by Manufacturer")
                            }
                        }
                        
                        NavigationLink(destination: ViewByStatus()) {
                            HStack {
                                Image(systemName: "flag.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View by Status")
                            }
                        }

                        
                        NavigationLink(destination: ViewByOrigin()) {
                            HStack {
                                Image(systemName: "mappin.square.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View by Origin")
                            }
                        }

                        
                        NavigationLink(destination: ViewByClient()) {
                            HStack {
                                Image(systemName: "square.grid.2x2.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("View by Client")
                            }
                        }

                    }
                    
                    Section(header: Text("Delete Full Item Inventory"), footer: Text("Deleting an item will remove it entirely, including all quantities.").foregroundStyle(Color.purple)) {
                        
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
                        
                        NavigationLink(destination: DeleteItemAndHistory()) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Delete Item & History")
                            }
                        }
                    }
                        
                    
                    Section(header: Text("Update SKU"), footer: Text("Access to delete or add new SKU")) {
                        
                        NavigationLink(destination: AddSKU()) {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Insert SKU")
                            }
                        }
                        
                        NavigationLink(destination: DeleteSKU()) {
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
                        
                        
                        
                        NavigationLink(destination: CountryDeleteView()) {
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
                        NavigationLink(destination: HistoryView()) {
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
                        NavigationLink(destination: HistoryUpdateView()) {
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
                    
                    Section(header: Text("Warehouse Statistics"), footer: Text("Access detailed statistics and reports about your inventory.")) {
                        
                        NavigationLink(destination: NumberStatistics()) {
                            HStack {
                                Image(systemName: "shared.with.you")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.purple)
                                
                                Text("Express Data")
                            }
                        }
                        
                        NavigationLink(destination: ProductPerStatus()) {
                            HStack {
                                Image(systemName: "chart.pie.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Text("Item Per Status")
                            }
                        }
                        
                        NavigationLink(destination: ProductFavoritePriority()) {
                            HStack {
                                Image(systemName: "chart.pie.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.orange)
                                
                                Text("Item Per Favortite & Priority")
                            }
                        }

                        NavigationLink(destination: Item7Days()) {
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.cyan)
                                
                                Text("Item Created Per Day")
                            }
                        }

                        
                        NavigationLink(destination: ItemMonth()) {
                            HStack {
                                Image(systemName: "chart.bar.xaxis.ascending")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor, Color.pink)
                                
                                Text("Item Created Per Month")
                            }
                        }

                        
                        NavigationLink(destination: ItemPerTag()) {
                            HStack {
                                Image(systemName: "chart.bar.xaxis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.orange, Color.indigo)
                                
                                Text("Item Per Tag")
                            }
                        }

                        
                        NavigationLink(destination: ItemManufacturer()) {
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.green)
                                
                                Text("Item Per Manufacturer")
                            }
                        }

                        
                        NavigationLink(destination: ItemOrigin()) {
                            HStack {
                                Image(systemName: "chart.dots.scatter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor, Color.pink)
                                
                                Text("Item Per Origin")
                            }
                        }

                        
                        NavigationLink(destination: ItemClient()) {
                            HStack {
                                Image(systemName: "chart.bar.xaxis.ascending.badge.clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor, Color.pink)
                                
                                Text("Item Per Client")
                            }
                        }
                        
                        NavigationLink(destination: OverviewView()) {
                            HStack {
                                Image(systemName: "person.fill.and.arrow.left.and.arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor, Color.orange)
                                
                                Text("Item Per Employee")
                            }
                        }

                    }
                    
                    Section(header: Text("Account and Configuration"), footer: Text("Configure settings and account preferences.")) {
                                NavigationLink(destination: Settings(loggedInUserEmail: user.email)) {
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
        .navigationViewStyle(StackNavigationViewStyle())
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
