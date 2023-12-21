import SwiftUI
import Charts

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


struct OverviewView: View {
    
    @State private var statusData: [StatusData] = []
    @State private var dailyCreationData: [DailyCreationData] = []
    @State private var monthlyCreationData: [MonthlyCreationData] = []
    @State private var tagNameData: [String: Int] = [:]
    @State private var manufacturerData: [String: Int] = [:]
    @State private var originData: [String: Int] = [:]
    @State private var clientData: [String: Int] = [:]
    
    @State private var categoryData: [CategoryData] = []
    
    private let barColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .brown, .cyan]
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                GroupBox("Product Count Per Status") {
                    Chart {
                        ForEach(statusData) { data in
                            SectorMark(
                                angle: .value(
                                    "Status",
                                    Double(data.count)
                                ),
                                innerRadius: .ratio(0.6),
                                angularInset: 10
                            )
                            .cornerRadius(10.0)
                            .foregroundStyle(
                                by: .value(
                                    "Status",
                                    data.status
                                )
                            )
                            .annotation(position: .overlay) {
                                Text("\(data.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: 400, height: 450)
                    .padding(.top, 20)
                    
                    
                }
                Divider()
                
                GroupBox("Product Count Per Favorite & Priority") {
                    Chart {
                        ForEach(categoryData) { category in
                            SectorMark(
                                angle: .value(category.category, category.proportion)
                            )
                            .foregroundStyle(by: .value(category.category, category.category))
                        }
                    }
                    .frame(width: 400, height: 450)
                    .padding(.top, 20)
                    
                }
                
                
                Divider()
                
                GroupBox("Items Created Per Day (Last 7 days)") {
                    Chart(dailyCreationData) { data in
                        BarMark(
                            x: .value("Day", data.day),
                            y: .value("Count", data.count)
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(barColors.randomElement() ?? .black)
                        .annotation(position: .overlay) {
                            Text("\(data.count)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 400, height: 400)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                //.padding()
                
                Divider()
                
                GroupBox("Items Created Per Month (Last 12 months)") {
                    Chart(monthlyCreationData) { data in
                        BarMark(
                            x: .value("Month", data.month),
                            y: .value("Count", data.count)
                        )
                        .cornerRadius(10.0)
                        .foregroundStyle(barColors.randomElement() ?? .black)
                        .annotation(position: .overlay) {
                            Text("\(data.count)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 400, height: 400)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                //.padding()
                
                Divider()
                
                GroupBox("Product Count Per Tag") {
                    Chart {
                        ForEach(tagNameData.keys.sorted(), id: \.self) { tagName in
                            BarMark(
                                x: .value("Tag Name", tagName),
                                y: .value("Count", tagNameData[tagName] ?? 0)
                            )
                            .cornerRadius(10.0)
                            .foregroundStyle(barColors.randomElement() ?? .black)
                            .annotation(position: .overlay) {
                                Text("\(tagNameData[tagName] ?? 0)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(5)
                            }
                        }
                    }
                    .frame(width: 400, height: 400)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                //.padding()
                
                Divider()
                
                
                GroupBox("Items Count Per Manufacturer") {
                    Chart {
                        ForEach(manufacturerData.keys.sorted(), id: \.self) { manufacturer in
                            BarMark(
                                x: .value("Manufacturer", manufacturer),
                                y: .value("Count", manufacturerData[manufacturer] ?? 0)
                            )
                            .cornerRadius(10.0)
                            .foregroundStyle(barColors.randomElement() ?? .black)
                            .annotation(position: .overlay) {
                                Text("\(manufacturerData[manufacturer] ?? 0)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(5)
                            }
                        }
                    }
                    .frame(width: 400, height: 400)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                //.padding()
                
                Divider()
                
                GroupBox("Items Count Per Origin") {
                    Chart {
                        ForEach(originData.keys.sorted(), id: \.self) { origin in
                            BarMark(
                                x: .value("Origin", origin),
                                y: .value("Count", originData[origin] ?? 0)
                            )
                            .cornerRadius(10.0)
                            .foregroundStyle(barColors.randomElement() ?? .black)
                            .annotation(position: .overlay) {
                                Text("\(originData[origin] ?? 0)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(5)
                            }
                        }
                    }
                    .frame(width: 400, height: 400)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                //.padding()
                
                Divider()
                
                GroupBox("Items Created by Client") {
                    Chart {
                        ForEach(clientData.keys.sorted(), id: \.self) { client in
                            BarMark(
                                x: .value("Client", client),
                                y: .value("Count", clientData[client] ?? 0)
                            )
                            .cornerRadius(10.0)
                            .foregroundStyle(barColors.randomElement() ?? .black)
                            .annotation(position: .overlay) {
                                Text("\(clientData[client] ?? 0)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(5)
                            }
                        }
                    }
                    .frame(width: 400, height: 450)
                    .padding(.top, 20)
                }
                .chartYAxis(.hidden)
                //.padding()
            }
            .onAppear {
                loadData()
            }
            .navigationTitle("Statistics Charts")
        }
        .background(Color(UIColor.systemGray6.cgColor))
        .scrollIndicators(.hidden)
    }
    
    private func loadData() {
        let statusFetchedData = DatabaseManager().fetchItemsPerStatus()
        statusData = statusFetchedData.map { StatusData(status: $0.key, count: $0.value) }
        
        let dailyFetchedData = DatabaseManager().fetchItemsCreatedPerDay()
        dailyCreationData = dailyFetchedData.map { DailyCreationData(day: $0.key, count: $0.value) }
        
        let monthlyFetchedData = DatabaseManager().fetchItemsCreatedPerMonth()
        monthlyCreationData = monthlyFetchedData.map { MonthlyCreationData(month: $0.key, count: $0.value) }
        
        tagNameData = DatabaseManager().fetchItemsCountByTagName()
        
        manufacturerData = DatabaseManager().fetchItemsCountByManufacturer()
        
        originData = DatabaseManager().fetchItemsCountByOrigin()
        
        clientData = DatabaseManager().fetchItemsCountByClient()
        
        let counts = DatabaseManager().fetchProductCategoriesCount()
        let total = Double(counts.values.reduce(0, +))
        categoryData = counts.map { CategoryData(category: $0.key, proportion: Double($0.value) / total) }
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "Favorite": return .yellow
        case "Priority": return .red
        case "Both": return .green
        default: return .gray
        }
    }
}




#Preview {
    OverviewView()
}


