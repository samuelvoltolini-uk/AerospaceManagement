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
                Text("Nothing to see here!")
                    .font(.headline)
            }
        } else {
            List {
                ForEach(manufacturers, id: \.id) { manufacturer in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "info.square.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(manufacturer.name)
                                .font(.headline)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "circle.hexagongrid.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(manufacturer.code)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "location.square.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(manufacturer.country + ", " + manufacturer.stateOrProvince + ", " + manufacturer.postCode)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(manufacturer.email)
                                .font(.footnote)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "person.text.rectangle.fill")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Text(manufacturer.createdBy)
                                .font(.footnote)
                        }
                        .foregroundStyle(Color.gray)
                        .padding(.top, 5)
                        
                        HStack {
                            Image(systemName: "clock.arrow.2.circlepath")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
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
        fetchManufacturers()
    }
}

#Preview {
    ManufacturerDeleteView()
}
