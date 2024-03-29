import Foundation
import SQLite3

struct User: Hashable {
    var id: Int64
    var name: String
    var email: String
    var password: String
}

struct UserSettings: Identifiable {
    let id: Int
    var name: String
    var email: String
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
    var SKU: [String]
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

struct ItemFetch: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var SKU: [String]
    var quantity: Int
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
    var receiveDate: Date
    var expectedDate: Date
    var fileData: Data?  // Assuming this is a usdz file
    var createdBy: String
    var creationDate: String
}

struct ItemFetchEdit {
    var id: Int
    var name: String
    var barcode: String
    var sku: String
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
    var receiveDate: String
    var expectedDate: String
    var file: Data? // Assuming BLOB is used for binary data
    var createdBy: String
    var creationDate: String
}

struct ItemFetchFavoritePriority {
    var name: String
    var barcode: String
    var isFavorite: Bool
    var isPriority: Bool
    var quantity: Double
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

struct ItemFetchFavoriteView: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var isFavorite: Bool
    // Add other properties as needed
}

struct ItemFetchPriorityView: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var isPriority: Bool
    // Add other properties as needed
}

struct ItemFetchForSKU: Equatable {
    var id: Int
    var name: String
    var barcode: String
    var SKU: [String]

    static func == (lhs: ItemFetchForSKU, rhs: ItemFetchForSKU) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ItemFetchForSKUDelete {
    var id: Int
    var SKU: [String]
    var quantity: Double // Add this property

    init(id: Int, SKU: [String], quantity: Double) {
        self.id = id
        self.SKU = SKU
        self.quantity = quantity
        // Initialize other properties here
    }
}

struct HistoryRecord: Identifiable {
    var id: Int
    var name: [String]
    var barcode: String
    var status: [String]
    var comments: [String]
    var dates: [String]
    var users: [String]
}

struct ItemByTags: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var tagName: String

    // Initialize the struct with values
    init(id: Int, name: String, barcode: String, quantity: Double, tagName: String) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.quantity = quantity
        self.tagName = tagName
    }
}

struct ItemByManufacturer: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var manufacturer: String

    // Initialize the struct with values
    init(id: Int, name: String, barcode: String, quantity: Double, manufacturer: String) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.quantity = quantity
        self.manufacturer = manufacturer
    }
}


struct ItemByStatus: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var status: String

    // Initialize the struct with values
    init(id: Int, name: String, barcode: String, quantity: Double, status: String) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.quantity = quantity
        self.status = status
    }
}

struct ItemByOrigin: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var origin: String

    // Initialize the struct with values
    init(id: Int, name: String, barcode: String, quantity: Double, origin: String) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.quantity = quantity
        self.origin = origin
    }
}

struct ItemByClient: Identifiable {
    var id: Int
    var name: String
    var barcode: String
    var quantity: Double
    var client: String

    // Initialize the struct with values
    init(id: Int, name: String, barcode: String, quantity: Double, client: String) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.quantity = quantity
        self.client = client
    }
}

struct ItemScan {
    var id: Int
    var name: String
    var barcode: String
    var sku: String
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
    var receiveDate: String
    var expectedDate: String
    var createdBy: String
    var creationDate: String
}

struct StatusData: Identifiable {
    let id: String // Use 'status' as the unique identifier
    let status: String
    let count: Int
    
    init(status: String, count: Int) {
        self.id = status
        self.status = status
        self.count = count
    }
}

struct DailyCreationData: Identifiable {
    let id = UUID()
    let day: String
    let count: Int
}

struct MonthlyCreationData: Identifiable {
    let id = UUID()
    let month: String
    let count: Int
}

struct CategoryData: Identifiable {
    let id = UUID()
    let category: String
    let proportion: Double
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
        SKU TEXT,
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
        INSERT INTO Items (Name, Barcode, SKU, Description, Manufacturer, Status, Origin, Client, Material, RepairCompanyOne, RepairCompanyTwo, HistoryNumber, Comments, TagName, IsFavorite, IsPriority, Quantity, ReceiveDate, ExpectedDate, File, CreatedBy, CreationDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (item.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (item.barcode as NSString).utf8String, -1, nil)
            let uniqueSKUs = Set(item.SKU)
                   let skusString = Array(uniqueSKUs).joined(separator: ",")
                   sqlite3_bind_text(insertStatement, 3, (skusString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (item.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (item.manufacturer as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (item.status as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (item.origin as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (item.client as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (item.material as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (item.repairCompanyOne as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (item.repairCompanyTwo as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 12, Int32(item.historyNumber))
            sqlite3_bind_text(insertStatement, 13, (item.comments as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 14, (item.tagName as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 15, item.isFavorite ? 1 : 0)
            sqlite3_bind_int(insertStatement, 16, item.isPriority ? 1 : 0)
            sqlite3_bind_double(insertStatement, 17, item.quantity)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-mm-yyyy"
            let receiveDateString = dateFormatter.string(from: item.receiveDate)
            let expectedDateString = dateFormatter.string(from: item.expectedDate)
            sqlite3_bind_text(insertStatement, 18, (receiveDateString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 19, (expectedDateString as NSString).utf8String, -1, nil)

            if let fileData = item.file {
                    fileData.withUnsafeBytes { rawBufferPointer in
                        guard let pointer = rawBufferPointer.baseAddress?.assumingMemoryBound(to: UInt8.self) else { return }
                        sqlite3_bind_blob(insertStatement, 20, pointer, Int32(fileData.count), nil)
                    }
                } else {
                    sqlite3_bind_blob(insertStatement, 20, nil, 0, nil)
                }

            sqlite3_bind_text(insertStatement, 21, (item.createdBy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 22, (item.creationDate as NSString).utf8String, -1, nil)

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

extension DatabaseManager {
    
    func barcodeExists(_ barcode: String) -> Bool {
          let queryStatementString = "SELECT EXISTS(SELECT 1 FROM Items WHERE Barcode = ? LIMIT 1);"
          var queryStatement: OpaquePointer?

          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
              sqlite3_bind_text(queryStatement, 1, (barcode as NSString).utf8String, -1, nil)

              if sqlite3_step(queryStatement) == SQLITE_ROW {
                  let exists = sqlite3_column_int(queryStatement, 0)
                  sqlite3_finalize(queryStatement)
                  return exists == 1 // Returns true if barcode exists, false otherwise
              } else {
                  print("Query execution failed")
              }
          } else {
              print("SELECT statement for barcode could not be prepared")
          }
          sqlite3_finalize(queryStatement)
          return false
      }

      // Function to check if a SKU exists
      func skuExists(_ sku: String) -> Bool {
          let queryStatementString = "SELECT EXISTS(SELECT 1 FROM Items WHERE SKU = ? LIMIT 1);"
          var queryStatement: OpaquePointer?

          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
              sqlite3_bind_text(queryStatement, 1, (sku as NSString).utf8String, -1, nil)

              if sqlite3_step(queryStatement) == SQLITE_ROW {
                  let exists = sqlite3_column_int(queryStatement, 0)
                  sqlite3_finalize(queryStatement)
                  return exists == 1 // Returns true if SKU exists, false otherwise
              } else {
                  print("Query execution failed")
              }
          } else {
              print("SELECT statement for SKU could not be prepared")
          }
          sqlite3_finalize(queryStatement)
          return false
      }
    
}

extension DatabaseManager {
    func userExists(email: String) -> Bool {
        // Assuming the database setup and user table are already defined
        let queryStatementString = "SELECT * FROM Users WHERE email = ?;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                sqlite3_finalize(queryStatement)
                return true // User exists
            }
        }
        sqlite3_finalize(queryStatement)
        return false // User does not exist
    }
    
    // Other methods for adding user, creating tables etc.
    // Omitted for brevity
}

extension DatabaseManager {
    
    func fetchAllItems() -> [ItemFetch] {
        var items = [ItemFetch]()
        let queryStatementString = "SELECT * FROM Items;"  // Assuming your table is named 'Items'
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let skuString = String(cString: sqlite3_column_text(queryStatement, 3))
                let description = String(cString: sqlite3_column_text(queryStatement, 4))
                let manufacturer = String(cString: sqlite3_column_text(queryStatement, 5))
                let status = String(cString: sqlite3_column_text(queryStatement, 6))
                let origin = String(cString: sqlite3_column_text(queryStatement, 7))
                let client = String(cString: sqlite3_column_text(queryStatement, 8))
                let material = String(cString: sqlite3_column_text(queryStatement, 9))
                let repairCompanyOne = String(cString: sqlite3_column_text(queryStatement, 10))
                let repairCompanyTwo = String(cString: sqlite3_column_text(queryStatement, 11))
                let historyNumber = Int(sqlite3_column_int(queryStatement, 12))
                let comments = String(cString: sqlite3_column_text(queryStatement, 13))
                let tagName = String(cString: sqlite3_column_text(queryStatement, 14))
                let isFavorite = sqlite3_column_int(queryStatement, 15) != 0
                let isPriority = sqlite3_column_int(queryStatement, 16) != 0
                let quantity = Int(sqlite3_column_int(queryStatement, 17))
                
                let createdBy = getColumnString(queryStatement, index: 21)
                let creationDate = getColumnString(queryStatement, index: 22)

                var fileData: Data? = nil
                if let fileDataBlob = sqlite3_column_blob(queryStatement, 20) {
                    let fileDataSize = sqlite3_column_bytes(queryStatement, 20)
                    fileData = Data(bytes: fileDataBlob, count: Int(fileDataSize))
                }

                let skuArray = skuString.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-mm-yyyy HH:mm"
                let receiveDateString = getColumnString(queryStatement, index: 18)
                let expectedDateString = getColumnString(queryStatement, index: 19)
                let receiveDate = dateFormatter.date(from: receiveDateString) ?? Date()
                let expectedDate = dateFormatter.date(from: expectedDateString) ?? Date()

                let item = ItemFetch(
                    id: id,
                    name: name,
                    barcode: barcode,
                    SKU: skuArray,
                    quantity: quantity,
                    description: description,
                    manufacturer: manufacturer,
                    status: status,
                    origin: origin,
                    client: client,
                    material: material,
                    repairCompanyOne: repairCompanyOne,
                    repairCompanyTwo: repairCompanyTwo,
                    historyNumber: historyNumber,
                    comments: comments,
                    tagName: tagName,
                    isFavorite: isFavorite,
                    isPriority: isPriority,
                    receiveDate: receiveDate,
                    expectedDate: expectedDate,
                    fileData: fileData,
                    createdBy: createdBy,
                    creationDate: creationDate
                )

                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return items
    }

    private func getColumnString(_ queryStatement: OpaquePointer?, index: Int32) -> String {
        if let cString = sqlite3_column_text(queryStatement, index) {
            return String(cString: cString)
        } else {
            return ""
        }
    }
}

extension DatabaseManager {
    
    func createHistoryTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS History(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        barcode TEXT,
        status TEXT,
        comments TEXT,
        date TEXT,
        user TEXT);
        """
        // Execute the statement to create the table
        executeStatement(sqlStatement: createTableString)
    }
    
    func insertHistoryRecord(name: String, barcode: String, status: String, comments: String, user: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let currentDate = dateFormatter.string(from: Date())

        let insertStatementString = """
        INSERT INTO History (name, barcode, status, comments, date, user) VALUES (?, ?, ?, ?, ?, ?);
        """
        
        // Prepare SQLite statement and bind values
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (barcode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (status as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (comments as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (currentDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (user as NSString).utf8String, -1, nil)
            
            // Execute the statement
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
    
    private func executeStatement(sqlStatement sql: String) {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully executed statement.")
            } else {
                print("Could not execute statement.")
            }
        } else {
            print("Statement could not be prepared.")
        }
        sqlite3_finalize(statement)
    }
}

extension DatabaseManager {
    
    func updateItem(barcode: String, tagName: String, manufacturer: String, status: String, origin: String, client: String, material: String, repairCompanyOne: String, repairCompanyTwo: String, comments: String) {
        let updateStatementString = """
        UPDATE Items SET tagName = ?, manufacturer = ?, status = ?, origin = ?, client = ?, material = ?, repairCompanyOne = ?, repairCompanyTwo = ?, comments = ? WHERE barcode = ?;
        """

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (tagName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (manufacturer as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (status as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (origin as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (client as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (material as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 7, (repairCompanyOne as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 8, (repairCompanyTwo as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 9, (comments as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 10, (barcode as NSString).utf8String, -1, nil)

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
}


extension DatabaseManager {
    
    func appendToHistory(name: String, itemBarcode: String, newStatus: String, newComments: String, user: User) {
        let currentDate = getCurrentDateString()

        // Fetch the existing history data for the item
        let fetchStatementString = "SELECT name, status, comments, date, user FROM History WHERE barcode = ?;"
        var fetchStatement: OpaquePointer?
        var existingName = ""
        var existingStatus = ""
        var existingComments = ""
        var existingDate = ""
        var existingUser = ""
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(fetchStatement, 1, (itemBarcode as NSString).utf8String, -1, nil)
            
            if sqlite3_step(fetchStatement) == SQLITE_ROW {
                existingName = String(cString: sqlite3_column_text(fetchStatement, 0))
                existingStatus = String(cString: sqlite3_column_text(fetchStatement, 1))
                existingComments = String(cString: sqlite3_column_text(fetchStatement, 2))
                existingDate = String(cString: sqlite3_column_text(fetchStatement, 3))
                existingUser = String(cString: sqlite3_column_text(fetchStatement, 4))
            }
        }
        sqlite3_finalize(fetchStatement)

        // Append the new information to each column
        let updatedName = existingName + "; " + name
        let updatedStatus = existingStatus + "; " + newStatus
        let updatedComments = existingComments + "; " + newComments
        let updatedDate = existingDate + "; " + currentDate
        let updatedUser = existingUser + "; " + user.name

        // Update the history row with the appended data
        let updateStatementString = """
        UPDATE History SET name = ?, status = ?, comments = ?, date = ?, user = ? WHERE barcode = ?;
        """
        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (updatedName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (updatedStatus as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (updatedComments as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (updatedDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (updatedUser as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (itemBarcode as NSString).utf8String, -1, nil)

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated history.")
            } else {
                print("Could not update history.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }

    private func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date())
    }
}

extension DatabaseManager {
    
    func fetchStatusHistoryForItem(itemBarcode: String) -> [String] {
        var statusHistory = [String]()

        let queryStatementString = "SELECT status FROM History WHERE barcode = ?;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (itemBarcode as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let queryResultCol = sqlite3_column_text(queryStatement, 0) {
                    let status = String(cString: queryResultCol)
                    statusHistory.append(contentsOf: status.components(separatedBy: "; "))
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }

        sqlite3_finalize(queryStatement)
        return statusHistory
    }
}

extension DatabaseManager {
    func fetchItems() -> [ItemFetchFavoritePriority] {
        var items = [ItemFetchFavoritePriority]()
        let queryStatementString = "SELECT name, barcode, quantity, isFavorite, isPriority FROM Items;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 1))
                let quantity = sqlite3_column_double(queryStatement, 2)
                let isFavorite = sqlite3_column_int(queryStatement, 3) != 0
                let isPriority = sqlite3_column_int(queryStatement, 4) != 0
                
                items.append(ItemFetchFavoritePriority(name: name, barcode: barcode, isFavorite: isFavorite, isPriority: isPriority, quantity: quantity))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return items
    }
}

extension DatabaseManager {

    func toggleFavorite(for itemBarcode: String) {
        let updateStatementString = """
        UPDATE Items SET isFavorite = CASE WHEN isFavorite = 1 THEN 0 ELSE 1 END WHERE barcode = ?;
        """

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (itemBarcode as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully toggled favorite.")
            } else {
                print("Could not toggle favorite.")
            }
        } else {
            print("UPDATE statement for isFavorite could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
    
    func togglePriority(for itemBarcode: String) {
        let updateStatementString = """
        UPDATE Items SET isPriority = CASE WHEN isPriority = 1 THEN 0 ELSE 1 END WHERE barcode = ?;
        """

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (itemBarcode as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully toggled priority.")
            } else {
                print("Could not toggle priority.")
            }
        } else {
            print("UPDATE statement for isPriority could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
}

extension DatabaseManager {

    func fetchFavoriteItems() -> [ItemFetchFavoriteView] {
        var items: [ItemFetchFavoriteView] = []
        let queryStatementString = "SELECT * FROM Items WHERE isFavorite = 1;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                guard let nameCString = sqlite3_column_text(queryStatement, 1) else { continue }
                guard let barcodeCString = sqlite3_column_text(queryStatement, 2) else { continue }
                let quantity = sqlite3_column_double(queryStatement, 17) // Fetching double value
                let isFavorite = sqlite3_column_int(queryStatement, 15) != 0 // Assuming 5th column is isFavorite

                let name = String(cString: nameCString)
                let barcode = String(cString: barcodeCString)

                let item = ItemFetchFavoriteView(id: Int(id), name: name, barcode: barcode, quantity: quantity, isFavorite: isFavorite)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {

    func fetchPriorityItems() -> [ItemFetchPriorityView] {
        var items: [ItemFetchPriorityView] = []
        let queryStatementString = "SELECT * FROM Items WHERE isPriority = 1;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                // Similar logic as in fetchFavoriteItems
                let id = sqlite3_column_int(queryStatement, 0)
                guard let nameCString = sqlite3_column_text(queryStatement, 1) else { continue }
                guard let barcodeCString = sqlite3_column_text(queryStatement, 2) else { continue }
                let quantity = sqlite3_column_double(queryStatement, 17)
                let isPriority = sqlite3_column_int(queryStatement, 16) != 0 // Assuming 5th column is isPriority

                let name = String(cString: nameCString)
                let barcode = String(cString: barcodeCString)

                let item = ItemFetchPriorityView(id: Int(id), name: name, barcode: barcode, quantity: quantity, isPriority: isPriority)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {

    func deleteItem(_ id: Int) {
        let deleteStatementString = "DELETE FROM Items WHERE id = ?;"

        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted item.")
            } else {
                print("Could not delete item.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
    }
}

extension DatabaseManager {
    func updateSKUs(for itemId: Int, newSKUs: [String]) {
        var currentSKUs = fetchCurrentSKUs(for: itemId)
        let currentQuantity = fetchCurrentQuantity(for: itemId)
        var isNewSKUAdded = false

        for sku in newSKUs {
            if !currentSKUs.contains(sku) {
                currentSKUs.append(sku)
                isNewSKUAdded = true
            }
        }

        let skusString = currentSKUs.joined(separator: ",")
        let newQuantity = isNewSKUAdded ? currentQuantity + 1.0 : currentQuantity
        let updateStatementString = "UPDATE Items SET SKU = ?, Quantity = ? WHERE id = ?;"

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (skusString as NSString).utf8String, -1, nil)
            sqlite3_bind_double(updateStatement, 2, newQuantity)
            sqlite3_bind_int(updateStatement, 3, Int32(itemId))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated SKUs and Quantity.")
            } else {
                print("Could not update SKUs and Quantity. Error: \(String(describing: sqlite3_errmsg(db)))")
            }
        } else {
            print("UPDATE statement could not be prepared. Error: \(String(describing: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(updateStatement)
    }

    private func fetchCurrentQuantity(for itemId: Int) -> Double {
        let queryStatementString = "SELECT Quantity FROM Items WHERE id = \(itemId);"
        var queryStatement: OpaquePointer?
        var quantity: Double = 0.0

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                quantity = sqlite3_column_double(queryStatement, 0)
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)

        return quantity
    }
}

extension DatabaseManager {
    private func fetchCurrentSKUs(for itemId: Int) -> [String] {
        let queryStatementString = "SELECT SKU FROM Items WHERE id = \(itemId);"
        var queryStatement: OpaquePointer?
        var skus = [String]()

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                if let skuCString = sqlite3_column_text(queryStatement, 0) {
                    let skuString = String(cString: skuCString)
                    skus = skuString.components(separatedBy: ",")
                }
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)

        return skus
    }

}

extension DatabaseManager {
    func deleteSKU(for itemId: Int, skuToDelete: String) {
        var currentSKUs = fetchCurrentSKUs(for: itemId)
        
        // Remove the specified SKU
        currentSKUs.removeAll { $0 == skuToDelete }

        // Join the remaining SKUs back into a string
        let updatedSKUsString = currentSKUs.joined(separator: ", ")

        // Prepare the update statement
        let updateStatementString = "UPDATE Items SET SKU = ? WHERE id = ?;"

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (updatedSKUsString as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 2, Int32(itemId))

            if sqlite3_step(updateStatement) != SQLITE_DONE {
                print("Could not update SKU. Error: \(String(describing: sqlite3_errmsg(db)))")
            }
        } else {
            print("UPDATE statement could not be prepared. Error: \(String(describing: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(updateStatement)
    }
}




extension DatabaseManager {
    func fetchItemsForSKU() -> [ItemFetchForSKU] {
        var items: [ItemFetchForSKU] = []
        let queryStatementString = "SELECT id, name, barcode, SKU FROM Items;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let barcode = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let SKUString = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let SKU = SKUString.split(separator: ",").map(String.init) // Assuming SKU is a comma-separated string

                let item = ItemFetchForSKU(id: id, name: name, barcode: barcode, SKU: SKU)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {
    func removeSKUs(for itemId: Int, newSKUs: [String]) {
        let joinedSKUs = newSKUs.joined(separator: ", ")
        let updateStatementString = "UPDATE Items SET SKU = ? WHERE id = ?;"

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, joinedSKUs, -1, nil)
            sqlite3_bind_int(updateStatement, 2, Int32(itemId))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully Deleted SKUs.")
            } else {
                print("Could not update SKUs.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
}

extension DatabaseManager {
    func fetchItemByIDForDelete(_ id: Int) -> ItemFetchForSKUDelete? {
        let queryStatementString = "SELECT id, SKU, quantity FROM Items WHERE id = \(id);" // Update the query
        var queryStatement: OpaquePointer?
        var item: ItemFetchForSKUDelete?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // Assuming SKU is in the 2nd column and quantity in the 3rd column
                let skuString = String(cString: sqlite3_column_text(queryStatement, 1))
                let skus = skuString.components(separatedBy: ",")
                let quantity = sqlite3_column_double(queryStatement, 2) // Fetch quantity

                item = ItemFetchForSKUDelete(id: id, SKU: skus, quantity: quantity) // Set quantity here
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return item
    }
}


extension DatabaseManager {
    func fetchHistoryRecords() -> [HistoryRecord] {
        var historyRecords: [HistoryRecord] = []
        let queryStatementString = "SELECT * FROM History;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let nameString = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let statusString = String(cString: sqlite3_column_text(queryStatement, 3))
                let commentsString = String(cString: sqlite3_column_text(queryStatement, 4))
                let dateString = String(cString: sqlite3_column_text(queryStatement, 5))
                let userString = String(cString: sqlite3_column_text(queryStatement, 6))

                let record = HistoryRecord(
                    id: Int(id),
                    name: nameString.components(separatedBy: ";"),
                    barcode: barcode,
                    status: statusString.components(separatedBy: ";"),
                    comments: commentsString.components(separatedBy: ";"),
                    dates: dateString.components(separatedBy: ";"),
                    users: userString.components(separatedBy: ";")
                )
                historyRecords.append(record)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return historyRecords
    }
}

extension DatabaseManager {
    func fetchItemsByTags() -> [ItemByTags] {
        var items: [ItemByTags] = []
        let queryStatementString = "SELECT * FROM Items;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let quantity = sqlite3_column_double(queryStatement, 17)
                let tagName = String(cString: sqlite3_column_text(queryStatement, 14))
                
                let item = ItemByTags(id: Int(id), name: name, barcode: barcode, quantity: quantity, tagName: tagName)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {
    func fetchItemsByManufacturer() -> [ItemByManufacturer] {
        var items: [ItemByManufacturer] = []
        let queryStatementString = "SELECT * FROM Items;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let quantity = sqlite3_column_double(queryStatement, 17)
                let manufacturer = String(cString: sqlite3_column_text(queryStatement, 5))
                
                let item = ItemByManufacturer(id: Int(id), name: name, barcode: barcode, quantity: quantity, manufacturer: manufacturer)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {
    func fetchItemsByStatus() -> [ItemByStatus] {
        var items: [ItemByStatus] = []
        let queryStatementString = "SELECT * FROM Items;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let quantity = sqlite3_column_double(queryStatement, 17)
                let status = String(cString: sqlite3_column_text(queryStatement, 6))
                
                let item = ItemByStatus(id: Int(id), name: name, barcode: barcode, quantity: quantity, status: status)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {
    func fetchItemsByOrigin() -> [ItemByOrigin] {
        var items: [ItemByOrigin] = []
        let queryStatementString = "SELECT * FROM Items;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let quantity = sqlite3_column_double(queryStatement, 17)
                let origin = String(cString: sqlite3_column_text(queryStatement, 7))
                
                let item = ItemByOrigin(id: Int(id), name: name, barcode: barcode, quantity: quantity, origin: origin)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}


extension DatabaseManager {
    func fetchItemsByClient() -> [ItemByClient] {
        var items: [ItemByClient] = []
        let queryStatementString = "SELECT * FROM Items;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let quantity = sqlite3_column_double(queryStatement, 17)
                let client = String(cString: sqlite3_column_text(queryStatement, 8))
                
                let item = ItemByClient(id: Int(id), name: name, barcode: barcode, quantity: quantity, client: client)
                items.append(item)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return items
    }
}

extension DatabaseManager {
    func fetchItemByBarcode(barcode: String) -> ItemScan? {
        var item: ItemScan?
        let queryStatementString = "SELECT * FROM Items WHERE barcode = ?;"

        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (barcode as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // Assuming that all the columns are correctly indexed and the data types are as expected.
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let sku = String(cString: sqlite3_column_text(queryStatement, 3))
                let description = String(cString: sqlite3_column_text(queryStatement, 4))
                let manufacturer = String(cString: sqlite3_column_text(queryStatement, 5))
                let status = String(cString: sqlite3_column_text(queryStatement, 6))
                let origin = String(cString: sqlite3_column_text(queryStatement, 7))
                let client = String(cString: sqlite3_column_text(queryStatement, 8))
                let material = String(cString: sqlite3_column_text(queryStatement, 9))
                let repairCompanyOne = String(cString: sqlite3_column_text(queryStatement, 10))
                let repairCompanyTwo = String(cString: sqlite3_column_text(queryStatement, 11))
                let historyNumber = Int(sqlite3_column_int(queryStatement, 12))
                let comments = String(cString: sqlite3_column_text(queryStatement, 13))
                let tagName = String(cString: sqlite3_column_text(queryStatement, 14))
                let isFavorite = sqlite3_column_int(queryStatement, 15) != 0
                let isPriority = sqlite3_column_int(queryStatement, 16) != 0
                let quantity = Double(sqlite3_column_double(queryStatement, 17))
                let receiveDate = String(cString: sqlite3_column_text(queryStatement, 18))
                let expectedDate = String(cString: sqlite3_column_text(queryStatement, 19))
                let createdBy = String(cString: sqlite3_column_text(queryStatement, 21))
                let creationDate = String(cString: sqlite3_column_text(queryStatement, 22))

                item = ItemScan(id: id, name: name, barcode: barcode, sku: sku, description: description,
                            manufacturer: manufacturer, status: status, origin: origin, client: client,
                            material: material, repairCompanyOne: repairCompanyOne, repairCompanyTwo: repairCompanyTwo,
                            historyNumber: historyNumber, comments: comments, tagName: tagName,
                            isFavorite: isFavorite, isPriority: isPriority, quantity: quantity,
                            receiveDate: receiveDate, expectedDate: expectedDate, createdBy: createdBy,
                            creationDate: creationDate)
                
            } else {
                print("No item found with barcode: \(barcode)")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("SELECT statement could not be prepared: \(errmsg)")
        }

        sqlite3_finalize(queryStatement)
        return item
    }
}

extension DatabaseManager {
    func fetchItemsPerStatus() -> [String: Int] {
        var itemsPerStatus = [String: Int]()


            let query = "SELECT Status, COUNT(*) FROM Items GROUP BY Status"
            var queryStatement: OpaquePointer? = nil

            if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    if let queryResultCol1 = sqlite3_column_text(queryStatement, 0) {
                        let status = String(cString: queryResultCol1)
                        let count = Int(sqlite3_column_int(queryStatement, 1))
                        itemsPerStatus[status] = count
                    }
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
      
        sqlite3_close(db)

        return itemsPerStatus
    }
}

extension DatabaseManager {
    func fetchItemsCreatedPerDay() -> [String: Int] {
        var itemsCreatedPerDay = [String: Int]()

        let query = "SELECT creationDate, COUNT(*) FROM Items GROUP BY creationDate"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 0) {
                    let creationDateString = String(cString: queryResultCol1)
                    let count = Int(sqlite3_column_int(queryStatement, 1))

                    if let date = parseDate(creationDateString) {
                        let formattedDate = formatDate(date)
                        itemsCreatedPerDay[formattedDate, default: 0] += count
                    }
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return itemsCreatedPerDay
    }

    private func parseDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
        return dateFormatter.date(from: dateString)
    }

    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}


extension DatabaseManager {
    func fetchItemsCreatedPerMonth() -> [String: Int] {
        var itemsCreatedPerMonth = [String: Int]()

        let query = "SELECT creationDate, COUNT(*) FROM Items GROUP BY creationDate"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let queryResultCol1 = sqlite3_column_text(queryStatement, 0) {
                    let creationDateString = String(cString: queryResultCol1)
                    let count = Int(sqlite3_column_int(queryStatement, 1))

                    if let date = parseDateYear(creationDateString) {
                        let monthYear = formatMonthYear(date)
                        itemsCreatedPerMonth[monthYear, default: 0] += count
                    }
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return itemsCreatedPerMonth
    }

    private func parseDateYear(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
        return dateFormatter.date(from: dateString)
    }

    private func formatMonthYear(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: date)
    }
}


extension DatabaseManager {
    func fetchItemsCountByTagName() -> [String: Int] {
        var tagNameCounts: [String: Int] = [:]
        let query = "SELECT tagName, COUNT(*) FROM Items GROUP BY tagName"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let tagNameCString = sqlite3_column_text(queryStatement, 0) {
                    let tagName = String(cString: tagNameCString)
                    let count = Int(sqlite3_column_int(queryStatement, 1))
                    tagNameCounts[tagName] = count
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return tagNameCounts
    }
}

extension DatabaseManager {
    func fetchItemsCountByManufacturer() -> [String: Int] {
        var manufacturerCounts: [String: Int] = [:]
        let query = "SELECT Manufacturer, COUNT(*) FROM Items GROUP BY Manufacturer"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let manufacturerCString = sqlite3_column_text(queryStatement, 0) {
                    let manufacturer = String(cString: manufacturerCString)
                    let count = Int(sqlite3_column_int(queryStatement, 1))
                    manufacturerCounts[manufacturer] = count
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return manufacturerCounts
    }
}

extension DatabaseManager {
    func fetchItemsCountByOrigin() -> [String: Int] {
        var originCounts: [String: Int] = [:]
        let query = "SELECT Origin, COUNT(*) FROM Items GROUP BY Origin"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let originCString = sqlite3_column_text(queryStatement, 0) {
                    let origin = String(cString: originCString)
                    let count = Int(sqlite3_column_int(queryStatement, 1))
                    originCounts[origin] = count
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return originCounts
    }
}

extension DatabaseManager {
    func fetchItemsCountByClient() -> [String: Int] {
        var clientCounts: [String: Int] = [:]
        let query = "SELECT Client, COUNT(*) FROM Items GROUP BY Client"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                if let clientCString = sqlite3_column_text(queryStatement, 0) {
                    let client = String(cString: clientCString)
                    let count = Int(sqlite3_column_int(queryStatement, 1))
                    clientCounts[client] = count
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        return clientCounts
    }
}

extension DatabaseManager {
    func fetchProductCategoriesCount() -> [String: Int] {
        var categoryCounts: [String: Int] = ["Favorite": 0, "Priority": 0, "Both": 0, "Neither": 0]

        let queryFavorite = "SELECT COUNT(*) FROM Items WHERE isFavorite = 1 AND isPriority = 0"
        let queryPriority = "SELECT COUNT(*) FROM Items WHERE isPriority = 1 AND isFavorite = 0"
        let queryBoth = "SELECT COUNT(*) FROM Items WHERE isFavorite = 1 AND isPriority = 1"
        let queryNeither = "SELECT COUNT(*) FROM Items WHERE isFavorite = 0 AND isPriority = 0"

        // Execute each query and populate the categoryCounts dictionary
        categoryCounts["Favorite"] = executeCountQuery(queryFavorite)
        categoryCounts["Priority"] = executeCountQuery(queryPriority)
        categoryCounts["Both"] = executeCountQuery(queryBoth)
        categoryCounts["Neither"] = executeCountQuery(queryNeither)

        return categoryCounts
    }

    private func executeCountQuery(_ query: String) -> Int {
        var queryStatement: OpaquePointer? = nil
               var count = 0

               if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
                   if sqlite3_step(queryStatement) == SQLITE_ROW {
                       count = Int(sqlite3_column_int(queryStatement, 0))
                   }
               } else {
                   print("SELECT statement could not be prepared")
               }
               sqlite3_finalize(queryStatement)

               return count
           }
       }

struct Order {
    let id: UUID = UUID()
    let amount: Int
    let day: Int
    let user: String
}

extension DatabaseManager {
    func fetchProductCreationByUserForLast30Days() -> [Order] {
        var orders: [Order] = []
        let query = """
        SELECT creationDate, createdBy FROM Items
        """
        var queryStatement: OpaquePointer? = nil

        var rawOrders: [(String, String)] = []

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let dateCString = sqlite3_column_text(queryStatement, 0)
                let userCString = sqlite3_column_text(queryStatement, 1)
                if let dateCString = dateCString, let userCString = userCString {
                    let dateString = String(cString: dateCString)
                    let user = String(cString: userCString)
                    rawOrders.append((dateString, user))
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)

        // Process the raw data
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!

        var userDailyCounts: [String: [Int: Int]] = [:]

        for (dateString, user) in rawOrders {
            if let date = dateFormatter.date(from: dateString), date >= thirtyDaysAgo {
                let day = Calendar.current.component(.day, from: date)

                userDailyCounts[user, default: [:]][day, default: 0] += 1
            }
        }

        // Convert the grouped data into Order objects
        for (user, dailyCounts) in userDailyCounts {
            for (day, count) in dailyCounts {
                orders.append(Order(amount: count, day: day, user: user))
            }
        }

        // Sort the orders by day in ascending order
        orders.sort { $0.day < $1.day }

        return orders
    }
}

extension DatabaseManager {
    func fetchTotalItemCount() -> Int {
        let query = "SELECT COUNT(*) FROM Items"
        var queryStatement: OpaquePointer? = nil
        var itemCount = 0

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                itemCount = Int(sqlite3_column_int(queryStatement, 0))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return itemCount
    }
}

extension DatabaseManager {
    func fetchTotalUserCount() -> Int {
        let query = "SELECT COUNT(*) FROM Users"
        var queryStatement: OpaquePointer? = nil
        var userCount = 0

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                userCount = Int(sqlite3_column_int(queryStatement, 0))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return userCount
    }
    
    func fetchTotalCount(tableName: String) -> Int {
            let query = "SELECT COUNT(*) FROM \(tableName)"
            var queryStatement: OpaquePointer? = nil
            var count = 0

            if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
                if sqlite3_step(queryStatement) == SQLITE_ROW {
                    count = Int(sqlite3_column_int(queryStatement, 0))
                }
            } else {
                print("SELECT statement could not be prepared for table \(tableName)")
            }
            sqlite3_finalize(queryStatement)
            
            return count
        }
    
    func fetchTotalItemQuantity() -> Double {
           let query = "SELECT SUM(Quantity) FROM Items"
           var queryStatement: OpaquePointer? = nil
           var totalQuantity: Double = 0.0

           if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
               if sqlite3_step(queryStatement) == SQLITE_ROW {
                   totalQuantity = sqlite3_column_double(queryStatement, 0)
               }
           } else {
               print("SELECT statement could not be prepared for summing quantity")
           }
           sqlite3_finalize(queryStatement)
           
           return totalQuantity
       }
   }

extension DatabaseManager {

    func updateItemQuantity(for itemId: Int, newQuantity: Double) {
        let updateQuery = "UPDATE Items SET quantity = ? WHERE id = ?"
        var updateStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_double(updateStatement, 1, newQuantity)
            sqlite3_bind_int(updateStatement, 2, Int32(itemId))

            if sqlite3_step(updateStatement) != SQLITE_DONE {
                print("Error updating quantity.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
}

extension DatabaseManager {
    func deleteHistoryForBarcode(_ barcode: String) {
        let deleteStatementString = "DELETE FROM History WHERE barcode = ?;"

        var deleteStatement: OpaquePointer?
        // Prepare the DELETE statement
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            // Bind the barcode to the statement
            sqlite3_bind_text(deleteStatement, 1, (barcode as NSString).utf8String, -1, nil)

            // Execute the statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted history records for barcode: \(barcode)")
            } else {
                print("Could not delete history records. Error: \(String(describing: sqlite3_errmsg(db)))")
            }
        } else {
            print("DELETE statement could not be prepared. Error: \(String(describing: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(deleteStatement)
    }
}

extension DatabaseManager {
    func updateSpecificHistoryRecord(recordId: Int, newRecordData: HistoryRecord) {
        let newStatus = newRecordData.status.joined(separator: ";")
        let newComments = newRecordData.comments.joined(separator: ";")
        let newUsers = newRecordData.users.joined(separator: ";")
        let newDates = newRecordData.dates.joined(separator: ";")

        let updateStatementString = """
        UPDATE History SET status = ?, comments = ?, user = ?, date = ?
        WHERE id = ?;
        """

        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (newStatus as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (newComments as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (newUsers as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (newDates as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 5, Int32(recordId))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated history record.")
            } else {
                print("Could not update history record. Error: \(String(describing: sqlite3_errmsg(db)))")
            }
        } else {
            print("UPDATE statement could not be prepared. Error: \(String(describing: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(updateStatement)
    }
}

extension DatabaseManager {
    func fetchSpecificHistoryRecord(recordId: Int) -> HistoryRecord {
        let queryStatementString = "SELECT * FROM History WHERE id = \(recordId);"
        var queryStatement: OpaquePointer?
        var record: HistoryRecord?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let nameString = String(cString: sqlite3_column_text(queryStatement, 1))
                let barcode = String(cString: sqlite3_column_text(queryStatement, 2))
                let statusString = String(cString: sqlite3_column_text(queryStatement, 3))
                let commentsString = String(cString: sqlite3_column_text(queryStatement, 4))
                let usersString = String(cString: sqlite3_column_text(queryStatement, 5))
                let datesString = String(cString: sqlite3_column_text(queryStatement, 6))

                // Assuming data is separated by semicolons
                let name = nameString.components(separatedBy: ";")
                let status = statusString.components(separatedBy: ";")
                let comments = commentsString.components(separatedBy: ";")
                let users = usersString.components(separatedBy: ";")
                let dates = datesString.components(separatedBy: ";")

                record = HistoryRecord(id: id, name: name, barcode: barcode, status: status, comments: comments, dates: dates, users: users)
            }
        } else {
            print("SELECT statement could not be prepared")
        }

        sqlite3_finalize(queryStatement)
        return record ?? HistoryRecord(id: -1, name: [], barcode: "", status: [], comments: [], dates: [], users: [])
    }
}

extension DatabaseManager {
    func updateQuantityBasedOnSKUs() {
        let fetchStatementString = "SELECT id, SKU FROM Items;"
        var fetchStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                let itemId = sqlite3_column_int(fetchStatement, 0)
                if let skuCString = sqlite3_column_text(fetchStatement, 1) {
                    let skuString = String(cString: skuCString)
                    let skuCount = Double(skuString.split(separator: ",").count)
                    updateQuantity(for: Int(itemId), quantity: skuCount)
                }
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(fetchStatement)
    }

    private func updateQuantity(for itemId: Int, quantity: Double) {
        let updateStatementString = "UPDATE Items SET Quantity = ? WHERE id = ?;"
        var updateStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_double(updateStatement, 1, quantity)
            sqlite3_bind_int(updateStatement, 2, Int32(itemId))

            if sqlite3_step(updateStatement) != SQLITE_DONE {
                print("Error updating quantity: \(String(describing: sqlite3_errmsg(db)))")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
}

extension DatabaseManager {
    func fetchAllUsers() -> [UserSettings] {
        var users = [UserSettings]()
        let query = "SELECT id, name, email FROM users"
        
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_int(statement, 0)
                let name = String(cString: sqlite3_column_text(statement, 1))
                let email = String(cString: sqlite3_column_text(statement, 2))
                let user = UserSettings(id: Int(id), name: name, email: email)
                users.append(user)
            }
        }
        sqlite3_finalize(statement)
        
        return users
    }
}

extension DatabaseManager {
    func deleteUser(withID id: Int) {
        let deleteQuery = "DELETE FROM users WHERE id = ?;" // Use placeholder for prepared statement

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id)) // Bind the id to the query

            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error executing delete statement.")
            }
        } else {
            print("Error preparing delete statement.")
        }

        sqlite3_finalize(statement) // Clean up
    }
}






















