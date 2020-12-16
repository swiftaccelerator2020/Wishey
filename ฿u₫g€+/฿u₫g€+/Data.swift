//
//  Data.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//
import Foundation

// Structs
struct projectedIncome {
    var incomeName: String
    var incomeMoney: Int
}

struct expenseStruct {
    var categoryName: String
    var projectedExpenses: Int
    var actualExpenses: Double
}

struct WishlistItem {
    var name: String
    var category: String
    var price: Double
    var months: Int
    var url: String?
}

// Arrays
var incomeArray = [
    projectedIncome(incomeName: "Salary", incomeMoney: 5000),
    projectedIncome(incomeName: "Other", incomeMoney: 6*7*20),
    projectedIncome(incomeName: "Savings", incomeMoney: 0)
]

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

var wishlist: [WishlistItem] = [
    WishlistItem(name: "Watch", category: "Luxury", price: 300, months: 3,url: "https://sstinc.org"),
    WishlistItem(name: "Gaming Chair", category: "Entertainment", price: 440.00, months: 11,url: "https://wikipedia.org"),
    WishlistItem(name: "Running Shoes", category: "Sports", price: 100.00, months: 20, url: "https://youtube.com"),
    WishlistItem(name: "New Television", category: "Electronics", price: 1500.00, months: 3),
    WishlistItem(name: "Couch", category: "Furniture", price: 245.00, months: 6),
    WishlistItem(name: "Printer", category: "Office", price: 218.00, months: 3)
]

var expensesArray: [expenseStruct] = [
    expenseStruct(categoryName: "Healthcare", projectedExpenses: 1000, actualExpenses: 600.00),
    expenseStruct(categoryName: "Transport", projectedExpenses: 900, actualExpenses: 500.00),
    expenseStruct(categoryName: "Food", projectedExpenses: 800, actualExpenses: 400.00),
    expenseStruct(categoryName: "Gaming", projectedExpenses: 700, actualExpenses: 300.00),
    expenseStruct(categoryName: "Entertainment", projectedExpenses: 600, actualExpenses: 200.00),
    expenseStruct(categoryName: "Others", projectedExpenses: 500, actualExpenses: 100.00),
]

var categories = ["Automotives","Properties","Electronics","Mobile Devices & Gadgets","Computers & Peripherals","Men's Wear","Men's Shoes","Men's Bags","Women's Apparel","Women's Shoes","Women's Bags","Kids Fashion","Health & Wellness", "Beauty & Personal Care", "Jewellery & Accessories", "Food & Beverage","Luxury","Furniture","Home Appliances","Office","Toys & Games","Entertainment","Sports, Outdoors & Exercise","Stationery","Music","Media","Subscriptions","Lifestyle","Pets", "Travel & Luggage","Kids & Babies", "Dining & Services", "Cameras & Drones", "Miscellaneous/Others"]

// Global Variables
var projectedSavings = Int()
var savings = Double()
var alltimeSavings = Double()
var wishlistSpendings = Double()

func updateProjectedSavings() {
    UserDefaults.standard.set(incomeArray, forKey: "income")
    UserDefaults.standard.set(expensesArray, forKey: "expense")
    if let incomeArrayLoaded = UserDefaults.standard.array(forKey: "income") , let expenseArrayLoaded = UserDefaults.standard.array(forKey: "expense") {
        setupIncome()
        var projSpendings = Int()
        for i in 0..<expenseArrayLoaded.count {
            projSpendings += (expenseArrayLoaded[i] as! expenseStruct).projectedExpenses
        }
        (incomeArrayLoaded[incomeArrayLoaded.count-1] as! projectedIncome).incomeMoney = income - projSpendings
        projectedSavings = (incomeArrayLoaded[incomeArrayLoaded.count-1] as! projectedIncome).incomeMoney
    }
}

func updateGlobalSavings() {
    UserDefaults.standard.set(expensesArray, forKey: "expense")
    UserDefaults.standard.set(wishlist, forKey: "wishlist")
    if let expensesArrayLoaded = UserDefaults.standard.array(forKey: "expense") {
        setupIncome()
        var spendings = Double()
        for i in 0..<expensesArrayLoaded.count {
            spendings += (expensesArrayLoaded[i] as! expenseStruct).actualExpenses
        }
        savings = Double(income) - spendings - wishlistSpendings
    }
}

var income = Int()

func setupIncome() {
    UserDefaults.standard.set(incomeArray, forKey: "income")
    if let incomeArrayLoaded = UserDefaults.standard.array(forKey: "income") {
        income = 0
        for i in 0..<incomeArrayLoaded.count-1 {
            income += (incomeArrayLoaded[i] as! projectedIncome).incomeMoney
        }
    }
}
