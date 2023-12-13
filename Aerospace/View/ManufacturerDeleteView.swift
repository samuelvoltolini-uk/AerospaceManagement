import SwiftUI

struct ManufacturerDeleteView: View {
    
    @State private var manufacturers: [Manufacturer] = []
    @State private var fetchFailed: Bool = false
    
    let databaseManager = DatabaseManager()

    var body: some View {
        if fetchFailed {
            VStack {
                Image("NothingHere") // Replace with your 'Nothing to see here' image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("Nothing to see here")
                    .font(.headline)
            }
        } else {
            List {
                ForEach(manufacturers, id: \.id) { manufacturer in
                    VStack(alignment: .leading) {
                        HStack {
                            Image("ManufacturerView")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(manufacturer.name)
                                .font(.headline)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image("ManufacturerCode")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(manufacturer.code)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image("AddressView")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(manufacturer.country + ", " + manufacturer.stateOrProvince + ", " + manufacturer.postCode)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image("ContactView")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(manufacturer.email)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image("UserCreated")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(manufacturer.createdBy)
                                .font(.footnote)
                        }
                        .foregroundStyle(Color.gray)
                        .padding(.top, 5)
                        
                        HStack {
                            Image("Date")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(manufacturer.creationDate)
                                .font(.footnote)
                        }
                        .foregroundStyle(Color.gray)
                        .padding(.top, 5)
                    }
                }
                .onDelete(perform: deleteManufacturer)
            }
            .onAppear {
                fetchManufacturers()
            }
        }
    }

    func fetchManufacturers() {
        let result = databaseManager.fetchManufacturers()
        if result.isEmpty {
            fetchFailed = true
        } else {
            manufacturers = result
        }
    }

    func deleteManufacturer(at offsets: IndexSet) {
        for index in offsets {
            let manufacturer = manufacturers[index]
            databaseManager.deleteManufacturer(id: manufacturer.id)
            manufacturers.remove(at: index)
        }
    }
}

#Preview {
    ManufacturerDeleteView()
}
