import SwiftUI

struct CountryDeleteView: View {
    @State private var countries: [Country] = []
    let databaseManager = DatabaseManager()
    
    @State private var fetchFailed: Bool = false

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
                    ForEach(countries, id: \.id) { country in
                        VStack(alignment: .leading) {
                            HStack {
                                Image("CountryView")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(country.name).font(.headline)
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                Image("WorkerID")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(country.userName)
                                    .foregroundStyle(Color.gray)
                                    .font(.footnote)
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                Image("DateCreated")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(country.creationDate)
                                    .foregroundStyle(Color.gray)
                                    .font(.footnote)
                            }
                            .padding(.top, 5)
                        }
                    }
                    .onDelete(perform: deleteCountry)
                }
                .navigationBarTitle("Countries")
                .onAppear {
                    fetchStatusIfFail()
                }
        }
    }
    
    func fetchStatusIfFail() {
        let result = databaseManager.fetchCountries()
        if result.isEmpty {
            fetchFailed = true
        } else {
            countries = result
        }
    }

    private func deleteCountry(at offsets: IndexSet) {
        offsets.forEach { index in
            let countryId = countries[index].id
            databaseManager.deleteCountry(withId: countryId)
            countries.remove(at: index)
        }
        fetchStatusIfFail()
    }
}


#Preview {
    CountryDeleteView()
}
