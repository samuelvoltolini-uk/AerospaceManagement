import Foundation
import SQLite3

struct User: Hashable {
    var id: Int64
    var name: String
    var email: String
    var password: String
}

struct Tag {
    var id: Int64?
    var name: String
    var description: String
    var imageName: String
    var creatorName: String
    var creationDate: Date
}

struct FullTag {
    var id: Int64
    var name: String
    var description: String
    var imageName: String
    var creatorName: String
    var creationDate: Date
}

struct Manufacturer {
    var id: Int
    var name: String
    var code: String
    var country: String
    var stateOrProvince: String
    var postCode: String
    var street: String
    var number: String
    var phoneNumber: String
    var email: String
    var createdBy: String
    var creationDate: String
}

struct Status {
    var id: Int
    var name: String
    var description: String
    var user: String
    var date: String // Use String for simplicity; you might use Date with a DateFormatter
}

struct Country: Identifiable {
    let id: Int
    let name: String
    let userName: String
    let creationDate: String
}

struct Client {
    var name: String
    var code: String
    var phoneNumber: String
    var email: String
    var registeredBy: String
    var registrationDate: String
}

struct ClientFetch: Identifiable {
    let id: Int
    let name: String
    let code: String
    let phoneNumber: String
    let email: String
    let registeredBy: String
    let registrationDate: String
    
}

struct Item {
    var name: String
    var barcode: String
    var description: String
    var manufacturer: String
    var status: String
    var origin: String
    var client: String
    var material: String
    var repairCompanyOne: String
    var repairCompanyTwo: String
    var historyNumber: Int
    var comments: String
    var tagName: String
    var isFavorite: Bool
    var isPriority: Bool
    var quantity: Double
    var receiveDate: Date
    var expectedDate: Date
    var file: Data? // File data
    var createdBy: String
    var creationDate: String
}


struct ManufacturerPicker: Hashable {
    var id: Int
    var name: String
}

struct StatusPicker: Hashable {
    var id: Int
    var name: String
}

struct CountryOfOriginPicker: Hashable {
    var id: Int
    var name: String
}

struct ClientPicker: Hashable {
    var id: Int
    var name: String
}

struct TagPicker: Hashable {
    var id: Int
    var name: String
}



class DatabaseManager {
    var db: OpaquePointer?
    
    init() {
        // Open the database
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("UsersDatabase.sqlite")
            
            // Print the database path
            print("Database Path: \(fileURL.path)")
            
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                print("Error opening database")
                return
            }
            
            // Create the table
            if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)", nil, nil, nil) != SQLITE_OK {
                print("Error creating table")
                return
            }
        } catch {
            print("Error getting file URL: \(error)")
        }
    }
    
    func addUser(name: String, email: String, password: String) {
        // Prepare the insert query
        let insertStatementString = "INSERT INTO Users (name, email, password) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer?
        
        // Prepare statement
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
            
            // Execute the query
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        // Finalize statement
        sqlite3_finalize(insertStatement)
    }
    
    
    deinit {
        sqlite3_close(db)
    }
    
    func createTagsTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS Tags(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            imageName TEXT,
            creatorName TEXT,
            creationDate TEXT);
            """
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tags table created.")
            } else {
                print("Tags table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func addTag(tag: Tag) {
        let insertStatementString = "INSERT INTO Tags (name, description, imageName, creatorName, creationDate) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let dateString = DateFormatter.localizedString(from: tag.creationDate, dateStyle: .medium, timeStyle: .medium)
            
            sqlite3_bind_text(insertStatement, 1, (tag.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (tag.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (tag.imageName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (tag.creatorName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (dateString as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Existing database functions...
}

extension DatabaseManager {
    func fetchUser(email: String, password: String) -> User? {
        let queryStatementString = "SELECT * FROM Users WHERE email = ? AND password = ?;"
        var queryStatement: OpaquePointer?
        var user: User?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int64(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                user = User(id: id, name: name, email: email, password: password)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return user
    }
}

extension DatabaseManager {
    func fetchTagsInfo() -> [Tag] {
        var tags = [Tag]()
        let queryStatementString = "SELECT * FROM Tags;"
        
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let imageName = String(cString: sqlite3_column_text(queryStatement, 3))
                // Assuming other relevant columns for creator and date.
                let tag = Tag(name: name, description: description, imageName: imageName, creatorName: "", creationDate: Date()) // Update as per your Tag structure
                tags.append(tag)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return tags
    }
}

extension DatabaseManager {
    func fetchAllTags() -> [FullTag] {
        var fulltags: [FullTag] = []
        let queryStatementString = "SELECT id, name, description, imageName, creatorName, creationDate FROM Tags;"
        
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int64(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let imageName = String(cString: sqlite3_column_text(queryStatement, 3))
                let creatorName = String(cString: sqlite3_column_text(queryStatement, 4))
                
                let dateString = String(cString: sqlite3_column_text(queryStatement, 5))
                let creationDate = dateFormatter.date(from: dateString) ?? Date()
                
                let tag = FullTag(id: id, name: name, description: description, imageName: imageName, creatorName: creatorName, creationDate: creationDate)
                fulltags.append(tag)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return fulltags
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'at' HH:mm:ss" // Adjust to match the format in the database
        return formatter
    }
}

extension DatabaseManager {
    func deleteTag(withId id: Int64) {
        let deleteStatementString = "DELETE FROM Tags WHERE id = ?;"
        
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int64(deleteStatement, 1, id)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        
        sqlite3_finalize(deleteStatement)
    }
}

extension DatabaseManager {
    
    func createManufacturerTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Manufacturer(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        code TEXT,
        country TEXT,
        stateOrProvince TEXT,
        postCode TEXT,
        street TEXT,
        number TEXT,
        phoneNumber TEXT,
        email TEXT,
        createdBy TEXT,
        creationDate TEXT);
        """
        
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Manufacturer table created.")
            } else {
                print("Manufacturer table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertManufacturer(name: String, code: String, country: String, stateOrProvince: String, postCode: String, street: String, number: String, phoneNumber: String, email: String, createdBy: String, creationDate: String) {
        let insertStatementString = """
        INSERT INTO Manufacturer (name, code, country, stateOrProvince, postCode, street, number, phoneNumber, email, createdBy, creationDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (code as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (country as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (stateOrProvince as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (postCode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (street as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (number as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (phoneNumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (createdBy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (creationDate as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
}

extension DatabaseManager {
    
    func checkIfManufacturerExists(name: String, code: String) -> Bool {
        let queryStatementString = "SELECT * FROM Manufacturer WHERE name = ? OR code = ?;"
        var queryStatement: OpaquePointer?
        var exists = false
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (code as NSString).utf8String, -1, nil)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                exists = true
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return exists
    }
}

extension DatabaseManager {
    func fetchManufacturers() -> [Manufacturer] {
        var manufacturers = [Manufacturer]()
        let queryStatementString = "SELECT * FROM Manufacturer;"
        
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let code = String(cString: sqlite3_column_text(queryStatement, 2))
                let country = String(cString: sqlite3_column_text(queryStatement, 3))
                let stateOrProvince = String(cString: sqlite3_column_text(queryStatement, 4))
                let postCode = String(cString: sqlite3_column_text(queryStatement, 5))
                let street = String(cString: sqlite3_column_text(queryStatement, 6))
                let number = String(cString: sqlite3_column_text(queryStatement, 7))
                let phoneNumber = String(cString: sqlite3_column_text(queryStatement, 8))
                let email = String(cString: sqlite3_column_text(queryStatement, 9))
                let createdBy = String(cString: sqlite3_column_text(queryStatement, 10))
                let creationDate = String(cString: sqlite3_column_text(queryStatement, 11))
                
                let manufacturer = Manufacturer(id: Int(id), name: name, code: code, country: country, stateOrProvince: stateOrProvince, postCode: postCode, street: street, number: number, phoneNumber: phoneNumber, email: email, createdBy: createdBy, creationDate: creationDate)
                manufacturers.append(manufacturer)
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)
        return manufacturers
    }
}

extension DatabaseManager {
    func deleteManufacturer(id: Int) {
        let deleteStatementString = "DELETE FROM Manufacturer WHERE id = ?;"
        
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
    }
}

extension DatabaseManager {
    
    // Function to create the Status table
    func createStatusTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Status(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT,
        Description TEXT,
        User TEXT,
        Date TEXT);
        """
        
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Status table created.")
                
            } else {
                print("Status table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
        
    }
    
    func insertStatus(name: String, description: String, user: String, date: Date) -> Bool {
        var success = false
        let insertStatementString = "INSERT INTO Status (Name, Description, User, Date) VALUES (?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (user as NSString).utf8String, -1, nil)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            sqlite3_bind_text(insertStatement, 4, (dateString as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                success = true
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        
        return success
    }
}

extension DatabaseManager {
    
    func statusExists(name: String) -> Bool {
        let queryStatementString = "SELECT * FROM Status WHERE Name = ?;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                sqlite3_finalize(queryStatement)
                return true // Status exists
            } else {
                sqlite3_finalize(queryStatement)
                return false // Status does not exist
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return false
    }
}

extension DatabaseManager {
    
    func fetchStatuses() -> [Status] {
        var statuses = [Status]()
        let queryStatementString = "SELECT Id, Name, Description, User, Date FROM Status;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let user = String(cString: sqlite3_column_text(queryStatement, 3))
                let date = String(cString: sqlite3_column_text(queryStatement, 4))
                statuses.append(Status(id: Int(id), name: name, description: description, user: user, date: date))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return statuses
    }
    
    func deleteStatus(withId id: Int) -> Bool {
        let deleteStatementString = "DELETE FROM Status WHERE Id = ?;"
        var deleteStatement: OpaquePointer?
        
        var result = false
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            result = sqlite3_step(deleteStatement) == SQLITE_DONE
            if result {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
        return result
    }
}

extension DatabaseManager {
    
    func createCountryTable() {
            let createTableString = """
            CREATE TABLE IF NOT EXISTS Countries(
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            CountryName TEXT,
            UserName TEXT,
            CreationDate TEXT);
            """

            var createTableStatement: OpaquePointer?
            if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
                if sqlite3_step(createTableStatement) == SQLITE_DONE {
                    print("Countries table created.")
                } else {
                    print("Countries table could not be created.")
                }
            } else {
                print("CREATE TABLE statement could not be prepared.")
            }
            sqlite3_finalize(createTableStatement)
        }
    
    func insertCountry(name: String, userName: String, creationDate: String) {
            let insertStatementString = "INSERT INTO Countries (CountryName, UserName, CreationDate) VALUES (?, ?, ?);"
            var insertStatement: OpaquePointer?

            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (userName as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (creationDate as NSString).utf8String, -1, nil)

                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
}

extension DatabaseManager {

    func countryExists(name: String) -> Bool {
        let queryStatementString = "SELECT * FROM Countries WHERE CountryName = ?;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (name as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                sqlite3_finalize(queryStatement)
                return true // Country exists
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return false // Country does not exist
    }
}

extension DatabaseManager {
    func fetchCountries() -> [Country] {
        let queryStatementString = "SELECT Id, CountryName, UserName, CreationDate FROM Countries;"
        var queryStatement: OpaquePointer?
        var countries = [Country]()

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let userName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let creationDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))

                countries.append(Country(id: Int(id), name: name, userName: userName, creationDate: creationDate))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return countries
    }
}

extension DatabaseManager {
    func deleteCountry(withId id: Int) {
        let deleteStatementString = "DELETE FROM Countries WHERE Id = ?;"
        var deleteStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}

extension DatabaseManager {
    // Function to create the clients table
    func createClientsTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Clients(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT,
        Code TEXT,
        PhoneNumber TEXT,
        Email TEXT,
        RegisteredBy TEXT,
        RegistrationDate TEXT);
        """

        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Clients table created.")
            } else {
                print("Clients table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    // Function to insert a new client
    func insertClient(client: Client) {
        let insertStatementString = "INSERT INTO Clients (Name, Code, PhoneNumber, Email, RegisteredBy, RegistrationDate) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (client.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (client.code as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (client.phoneNumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (client.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (client.registeredBy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (client.registrationDate as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func customerNameExists(name: String) -> Bool {
        let queryStatementString = "SELECT * FROM Clients WHERE Name = ?;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (name as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                sqlite3_finalize(queryStatement)
                return true // Country exists
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return false // Country does not exist
    }
    
    func customerCodeExists(code: String) -> Bool {
        let queryStatementString = "SELECT * FROM Clients WHERE Code = ?;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (code as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                sqlite3_finalize(queryStatement)
                return true // Country exists
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return false // Country does not exist
    }
}

extension DatabaseManager {
    func fetchClients() -> [ClientFetch] {
        var clients = [ClientFetch]()
        let queryStatementString = "SELECT * FROM Clients;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let code = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let phoneNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let registeredBy = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let registrationDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                // Fetch other fields as necessary

                let client = ClientFetch(id: Int(id), name: name, code: code, phoneNumber: phoneNumber, email: email, registeredBy: registeredBy, registrationDate: registrationDate)
                clients.append(client)
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)
        return clients
    }
}

extension DatabaseManager {
    func deleteClient(withId id: Int) {
        let deleteStatementString = "DELETE FROM Clients WHERE Id = ?;"
        var deleteStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted client.")
            } else {
                print("Could not delete client.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
    }
}

extension DatabaseManager {
    func createItemsTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Items(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT,
        Barcode TEXT,
        Description TEXT,
        Manufacturer TEXT,
        Status TEXT,
        Origin TEXT,
        Client TEXT,
        Material TEXT,
        RepairCompanyOne TEXT,
        RepairCompanyTwo TEXT,
        HistoryNumber INTEGER,
        Comments TEXT,
        TagName TEXT,
        IsFavorite INTEGER,
        IsPriority INTEGER,
        Quantity REAL,
        ReceiveDate TEXT,
        ExpectedDate TEXT,
        File BLOB,
        CreatedBy TEXT,
        CreationDate TEXT);
        """

        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Items table created.")
            } else {
                print("Items table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    func insertItem(item: Item) {
        let insertStatementString = """
        INSERT INTO Items (Name, Barcode, Description, Manufacturer, Status, Origin, Client, Material, RepairCompanyOne, RepairCompanyTwo, HistoryNumber, Comments, TagName, IsFavorite, IsPriority, Quantity, ReceiveDate, ExpectedDate, File, CreatedBy, CreationDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (item.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (item.barcode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (item.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (item.manufacturer as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (item.status as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (item.origin as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (item.client as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (item.material as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (item.repairCompanyOne as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (item.repairCompanyTwo as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 11, Int32(item.historyNumber))
            sqlite3_bind_text(insertStatement, 12, (item.comments as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 13, (item.tagName as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 14, item.isFavorite ? 1 : 0)
            sqlite3_bind_int(insertStatement, 15, item.isPriority ? 1 : 0)
            sqlite3_bind_double(insertStatement, 16, item.quantity)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-mm-yyyy"
            let receiveDateString = dateFormatter.string(from: item.receiveDate)
            let expectedDateString = dateFormatter.string(from: item.expectedDate)
            sqlite3_bind_text(insertStatement, 17, (receiveDateString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 18, (expectedDateString as NSString).utf8String, -1, nil)

            if let fileData = item.file {
                    fileData.withUnsafeBytes { rawBufferPointer in
                        guard let pointer = rawBufferPointer.baseAddress?.assumingMemoryBound(to: UInt8.self) else { return }
                        sqlite3_bind_blob(insertStatement, 19, pointer, Int32(fileData.count), nil)
                    }
                } else {
                    sqlite3_bind_blob(insertStatement, 19, nil, 0, nil)
                }

            sqlite3_bind_text(insertStatement, 20, (item.createdBy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 21, (item.creationDate as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
}


extension DatabaseManager {
    // Function to fetch manufacturers
    func fetchManufacturersPicker() -> [ManufacturerPicker] {
        var manufacturers: [ManufacturerPicker] = []
        let queryStatementString = "SELECT id, name FROM Manufacturer;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 1) {
                    let name = String(cString: queryResultCol1)
                    manufacturers.append(ManufacturerPicker(id: Int(id), name: name))
                }
            }
        } else {
            print("SELECT statement could not be prepared for Manufacturer")
        }
        sqlite3_finalize(queryStatement)
        return manufacturers
    }
    
    // Function to fetch statuses
    func fetchStatusesPicker() -> [StatusPicker] {
        var statuses: [StatusPicker] = []
        let queryStatementString = "SELECT id, name FROM Status;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 1) {
                    let name = String(cString: queryResultCol1)
                    statuses.append(StatusPicker(id: Int(id), name: name))
                }
            }
        } else {
            print("SELECT statement could not be prepared for Status")
        }
        sqlite3_finalize(queryStatement)
        return statuses
    }
    
    // Function to fetch countries of origin
    func fetchCountriesOfOriginPicker() -> [CountryOfOriginPicker] {
        var countries: [CountryOfOriginPicker] = []
        let queryStatementString = "SELECT id, CountryName FROM Countries;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 1) {
                    let name = String(cString: queryResultCol1)
                    countries.append(CountryOfOriginPicker(id: Int(id), name: name))
                }
            }
        } else {
            print("SELECT statement could not be prepared for Countries")
        }
        sqlite3_finalize(queryStatement)
        return countries
    }
    
    // Function to fetch clients
    func fetchClientsPicker() -> [ClientPicker] {
        var clients: [ClientPicker] = []
        let queryStatementString = "SELECT id, name FROM Clients;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 1) {
                    let name = String(cString: queryResultCol1)
                    clients.append(ClientPicker(id: Int(id), name: name))
                }
            }
        } else {
            print("SELECT statement could not be prepared for Clients")
        }
        sqlite3_finalize(queryStatement)
        return clients
    }
    
    // Function to fetch tags
    func fetchTagPicker() -> [TagPicker] {
        var tags: [TagPicker] = []
        let queryStatementString = "SELECT id, name FROM Tags;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 1) {
                    let name = String(cString: queryResultCol1)
                    tags.append(TagPicker(id: Int(id), name: name))
                }
            }
        } else {
            print("SELECT statement could not be prepared for Tags")
        }
        sqlite3_finalize(queryStatement)
        return tags
    }
}


