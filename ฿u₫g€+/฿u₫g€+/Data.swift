//
//  Data.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//
import Foundation

// Structs

class projectedIncome: Codable {
    var incomeName: String
    var incomeMoney: Int
    init(incomeName: String, incomeMoney: Int) {
        self.incomeName = incomeName
        self.incomeMoney = incomeMoney
    }
    static func getArchiveURL() -> URL {
        let plistName = "income"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(income: [projectedIncome]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedIncome = try? propertyListEncoder.encode(income)
        try? encodedIncome?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [projectedIncome]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedIncomeData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedIncome = try? propertyListDecoder.decode(Array<projectedIncome>.self, from: retrievedIncomeData) else { return nil }
        return decodedIncome
    }
    
    static func loadSampleData() -> [projectedIncome] {
        let incomeArray: [projectedIncome] = [
            projectedIncome(incomeName: "Salary", incomeMoney: 5000),
//            projectedIncome(incomeName: "Other", incomeMoney: 6*7*20),
//            projectedIncome(incomeName: "Projected Savings", incomeMoney: 0)
        ]
        return incomeArray
    }
}

class projectedSavings: Codable {
    var savingsName: String
    var savingsMoney: Int
    init(savingsName: String, savingsMoney: Int) {
        self.savingsName = savingsName
        self.savingsMoney = savingsMoney
    }
    static func getArchiveURL() -> URL {
        let plistName = "savings"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(savings: [projectedSavings]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedIncome = try? propertyListEncoder.encode(savings)
        try? encodedIncome?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [projectedSavings]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedSavingsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedSavings = try? propertyListDecoder.decode(Array<projectedSavings>.self, from: retrievedSavingsData) else { return nil }
        return decodedSavings
    }
    
    static func loadSampleData() -> [projectedSavings] {
        let savingsArray: [projectedSavings] = [
            projectedSavings(savingsName: "Projected Savings", savingsMoney: 0),
            projectedSavings(savingsName: "Savings Target", savingsMoney: 0)
        ]
        return savingsArray
    }
}

class expenseStruct: Codable {
    var categoryName: String
    var projectedExpenses: Int
    var actualExpenses: Double
    init(categoryName: String, projectedExpenses: Int, actualExpenses: Double) {
        self.categoryName = categoryName
        self.projectedExpenses = projectedExpenses
        self.actualExpenses = actualExpenses
    }
    static func getArchiveURL() -> URL {
        let plistName = "expense"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(expense: [expenseStruct]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedExpenses = try? propertyListEncoder.encode(expense)
        try? encodedExpenses?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [expenseStruct]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedExpenseData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedExpenses = try? propertyListDecoder.decode(Array<expenseStruct>.self, from: retrievedExpenseData) else { return nil }
        return decodedExpenses
    }
    
    static func loadSampleData() -> [expenseStruct] {
        let expensesArray: [expenseStruct] = [
//            expenseStruct(categoryName: "Healthcare", projectedExpenses: 1000, actualExpenses: 600.00),
//            expenseStruct(categoryName: "Transport", projectedExpenses: 900, actualExpenses: 500.00),
//            expenseStruct(categoryName: "Food", projectedExpenses: 800, actualExpenses: 400.00),
//            expenseStruct(categoryName: "Gaming", projectedExpenses: 700, actualExpenses: 300.00),
//            expenseStruct(categoryName: "Entertainment", projectedExpenses: 600, actualExpenses: 200.00),
//            expenseStruct(categoryName: "Others", projectedExpenses: 500, actualExpenses: 100.00),
            expenseStruct(categoryName: "Groceries", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Food", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Utilities", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Transport", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Healthcare", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Entertainment", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Others", projectedExpenses: 0, actualExpenses: 0.00),
            expenseStruct(categoryName: "Wishlist Items", projectedExpenses: 0, actualExpenses: 0.00)
        ]
        return expensesArray
    }
}

struct WishlistItem: Codable {
    var name: String
    var category: String
    var price: Double
    var months: Int
    var url: String?
    init(name: String, category: String, price: Double, months: Int, url: String? = nil) {
        self.name = name
        self.category = category
        self.price = price
        self.months = months
        if let url = url {
            self.url = url
        }
    }
    static func getArchiveURL() -> URL {
        let plistName = "wishlist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    static func saveToFile(wishlist: [WishlistItem]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedWishlist = try? propertyListEncoder.encode(wishlist)
        try? encodedWishlist?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [WishlistItem]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedWishlistData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedWishlist = try? propertyListDecoder.decode(Array<WishlistItem>.self, from: retrievedWishlistData) else { return nil }
        return decodedWishlist
    }
    
    static func loadSampleData() -> [WishlistItem] {
        let wishlist: [WishlistItem] = [
//            WishlistItem(name: "Watch", category: "Luxury", price: 300, months: 3, url: "https://swiftinsg.org"),
//            WishlistItem(name: "Gaming Chair", category: "Entertainment", price: 440.00, months: 11),
//            WishlistItem(name: "Running Shoes", category: "Sports", price: 100.00, months: 20),
//            WishlistItem(name: "New Television", category: "Electronics", price: 1500.00, months: 3),
//            WishlistItem(name: "Couch", category: "Furniture", price: 245.00, months: 6),
//            WishlistItem(name: "Printer", category: "Office", price: 218.00, months: 3)
        ]
        return wishlist
    }
}

// Arrays
var canBuy: [Bool] = []
var incomeArray = [projectedIncome]()
var savingsArray = [projectedSavings]()
//    = [
//    projectedIncome(incomeName: "Salary", incomeMoney: 5000),
//    projectedIncome(incomeName: "Other", incomeMoney: 6*7*20),
//    projectedIncome(incomeName: "Savings", incomeMoney: 0)
//]

//var projectedExpensesArray = [
//    projectedExpenses(expenseName: "Healthcare", expenseMoney: 100),
//    projectedExpenses(expenseName: "Transport", expenseMoney: 900),
//    projectedExpenses(expenseName: "Food",expenseMoney: 800),
//    projectedExpenses(expenseName: "Gaming", expenseMoney: 700),
//    projectedExpenses(expenseName: "Entertainment", expenseMoney: 600),
//    projectedExpenses(expenseName: "Others", expenseMoney: 500)
//]
//var expenses = [expenseStruct(name: "Food", projectedSpending: 100, actualSpending: 65),
//                expenseStruct(name: "Entertainment", projectedSpending: 50, actualSpending: 30),
//                expenseStruct(name: "Tuition", projectedSpending: 300, actualSpending: 250)
//]

var wishlist = [WishlistItem]()
//    = [
//    WishlistItem(name: "Watch", category: "Luxury", price: 300, months: 3,url: "https://sstinc.org"),
//    WishlistItem(name: "Gaming Chair", category: "Entertainment", price: 440.00, months: 11,url: "https://wikipedia.org"),
//    WishlistItem(name: "Running Shoes", category: "Sports", price: 100.00, months: 20, url: "https://youtube.com"),
//    WishlistItem(name: "New Television", category: "Electronics", price: 1500.00, months: 3),
//    WishlistItem(name: "Couch", category: "Furniture", price: 245.00, months: 6),
//    WishlistItem(name: "Printer", category: "Office", price: 218.00, months: 3)
//]

var expensesArray = [expenseStruct]()
//    = [
//    expenseStruct(categoryName: "Healthcare", projectedExpenses: 1000, actualExpenses: 600.00),
//    expenseStruct(categoryName: "Transport", projectedExpenses: 900, actualExpenses: 500.00),
//    expenseStruct(categoryName: "Food", projectedExpenses: 800, actualExpenses: 400.00),
//    expenseStruct(categoryName: "Gaming", projectedExpenses: 700, actualExpenses: 300.00),
//    expenseStruct(categoryName: "Entertainment", projectedExpenses: 600, actualExpenses: 200.00),
//    expenseStruct(categoryName: "Others", projectedExpenses: 500, actualExpenses: 100.00),
//]

var categories = ["Automotives","Properties","Electronics","Mobile Devices & Gadgets","Computers & Peripherals","Men's Wear","Men's Shoes","Men's Bags","Women's Apparel","Women's Shoes","Women's Bags","Kids Fashion","Health & Wellness", "Beauty & Personal Care", "Jewellery & Accessories", "Food & Beverage","Luxury","Furniture","Home Appliances","Office","Toys & Games","Entertainment","Sports, Outdoors & Exercise","Stationery","Music","Media","Subscriptions","Lifestyle","Pets", "Travel & Luggage","Kids & Babies", "Dining & Services", "Cameras & Drones", "Miscellaneous/Others"]

// Global Variables
var projectedSavingsValue = Int()
var savings = Double()
var totalsavings = Double(0)
var wishlistSpendings = Double(0)
var initialSavings = Double(0)

func updateProjectedSavings() {
//    incomeArray = incomeArrayLoaded
//    expensesArray = expenseArrayLoaded
//    setupIncome()
//    var projSpendings = Int()
//    for i in 0..<expensesArray.count {
//       projSpendings += expensesArray[i].projectedExpenses
//    }
//    incomeArray[incomeArray.count-1].incomeMoney = income - projSpendings
//    projectedSavings = incomeArray[incomeArray.count-1].incomeMoney
//    if UserDefaults.standard.array(forKey: "income") != nil && UserDefaults.standard.array(forKey: "expense") != nil {
//        if let incomeArrayLoaded = UserDefaults.standard.array(forKey: "income")! as? [projectedIncome], let expenseArrayLoaded = UserDefaults.standard.array(forKey: "expense")! as? [expenseStruct] {
    if let loadedExpenses = expenseStruct.loadFromFile(), let loadedIncome = projectedIncome.loadFromFile(), let loadedSavings = projectedSavings.loadFromFile() {
        incomeArray = loadedIncome
        expensesArray = loadedExpenses
        savingsArray = loadedSavings
//        }
    } else {
//        UserDefaults.standard.set(incomeArray, forKey: "income")
//        UserDefaults.standard.set(expensesArray, forKey: "expense")
        incomeArray = projectedIncome.loadSampleData()
        expensesArray = expenseStruct.loadSampleData()
        savingsArray = projectedSavings.loadSampleData()
        projectedIncome.saveToFile(income: incomeArray)
        expenseStruct.saveToFile(expense: expensesArray)
        projectedSavings.saveToFile(savings: savingsArray)
    }
    globalincome = 0
    for i in 0...incomeArray.count-1 {
        globalincome += incomeArray[i].incomeMoney
    }
    var projSpendings = Int()
    for i in 0..<expensesArray.count {
        projSpendings += expensesArray[i].projectedExpenses
    }
    savingsArray[0].savingsMoney = globalincome - projSpendings
    projectedSavingsValue = savingsArray[0].savingsMoney
    projectedIncome.saveToFile(income: incomeArray)
    projectedSavings.saveToFile(savings: savingsArray)
}

func updateGlobalSavings() {
//    setupIncome()
//    var spendings = Double()
//    for i in 0..<expensesArray.count {
//        spendings += expensesArray[i].actualExpenses
//    }
//    savings = Double(income) - spendings - wishlistSpendings
    if let loadedExpenses = expenseStruct.loadFromFile(), let wishlistLoaded = WishlistItem.loadFromFile() {
        
//    if UserDefaults.standard.array(forKey: "expense") != nil && UserDefaults.standard.array(forKey: "wishlist") != nil {
//        if let expenseArrayLoaded = UserDefaults.standard.array(forKey: "expense")! as? [expenseStruct], let wishlistArrayLoaded = UserDefaults.standard.array(forKey: "wishlist") as? [WishlistItem]{
        expensesArray = loadedExpenses
        wishlist = wishlistLoaded
        
//        }
    } else {
//        UserDefaults.standard.set(expensesArray, forKey: "expense")
//        UserDefaults.standard.set(wishlist, forKey: "wishlist")
//        print("stupid thing ran")
        expensesArray = expenseStruct.loadSampleData()
        wishlist = WishlistItem.loadSampleData()
        expenseStruct.saveToFile(expense: expensesArray)
        WishlistItem.saveToFile(wishlist: wishlist)
    }
    var spendings = Double()
    for i in 0..<expensesArray.count {
        spendings += expensesArray[i].actualExpenses
    }
    savings = Double(globalincome) - spendings
}

var globalincome = Int()

//func setupIncome() {
////    income = 0
////    for i in 0..<incomeArray.count-1 {
////        income += incomeArray[i].incomeMoney
////    }
////    if UserDefaults.standard.array(forKey: "income") != nil {
////        if let incomeArrayLoaded = UserDefaults.standard.array(forKey: "income")! as? [projectedIncome] {
//    if let loadedIncome = projectedIncome.loadFromFile() {
//        incomeArray = loadedIncome
//        income = 0
//        for i in 0..<incomeArray.count-1 {
//           income += incomeArray[i].incomeMoney
//        }
////        }
//    } else {
////        UserDefaults.standard.set(incomeArray, forKey: "income")
//        incomeArray = projectedIncome.loadSampleData()
//        projectedIncome.saveToFile(income: incomeArray)
//    }
//}

func updateForCurrentMonth() {
//    let date = Date()
//    let calendar = Calendar.current
////
////    let hour = calendar.component(.hour, from: date)
//    let minutes = calendar.component(.minute, from: date)
//    print(hour)
//    print(minutes)
    //        let seconds = calendar.component(.second, from: date)
//    if UserDefaults.standard.string(forKey: "min") != nil {
//        if String(minutes) != UserDefaults.standard.string(forKey: "min") {
//            UserDefaults.standard.setValue(String(minutes), forKey: "min")
//            if expenseStruct.loadFromFile() != nil {
//                for i in expensesArray {
//                    i.actualExpenses = 0
//                }
//                expenseStruct.saveToFile(expense: expensesArray)
//                totalsavings += savings
//                savings = 0
//                updateGlobalSavings()
//            }
//        }
//    } else {
//        UserDefaults.standard.setValue(String(minutes), forKey: "min")
//    }
    if UserDefaults.standard.string(forKey: "lastRecordedMonth") != nil {

//        if Date().monthAsString() != UserDefaults.standard.string(forKey: "lastRecordedMonth") {
//            if expenseStruct.loadFromFile() != nil {
//                for i in expensesArray {
//                    i.actualExpenses = 0
//                }
//                expenseStruct.saveToFile(expense: expensesArray)
//                alltimeSavings += savings
//                savings = 0
//            }
////            UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
//        }
        if Date().monthAsString() != UserDefaults.standard.string(forKey: "lastRecordedMonth") {
            UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
//            if expenseStruct.loadFromFile() != nil {
                for i in expensesArray {
                    i.actualExpenses = 0
                }
                expenseStruct.saveToFile(expense: expensesArray)
                totalsavings += savings
                UserDefaults.setValue(totalsavings, forKey: "totalSavings")
                updateTotalSavings()
                savings = 0
                updateGlobalSavings()
//            }
        }
    } else {
//        UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
        UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
    }
}

let currencyFormatter = NumberFormatter()
func updateCurrency() {
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
}

func updateInitialSavings() {
    if let iniSavings = UserDefaults.standard.string(forKey: "initialSavings") {
        initialSavings = Double(iniSavings)!
    } else {
        initialSavings = Double(0)
    }
}

func updateTotalSavings() {
    if let ttlSavings = UserDefaults.standard.string(forKey: "totalSavings") {
        totalsavings = Double(ttlSavings)!
    } else {
        totalsavings = Double(0)
    }
}

func updateWishlistTransactions() {
    
    if let wlTransactHist = UserDefaults.standard.string(forKey: "wishlistTransactions") {
        wishlistSpendings = Double(wlTransactHist)!
    } else {
        wishlistSpendings = Double(0)
    }
}
