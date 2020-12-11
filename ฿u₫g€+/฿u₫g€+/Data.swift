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
    var price: Int
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
    WishlistItem(name: "Watch", category: "Luxury", price: 300, months: 3),
    WishlistItem(name: "Gaming Chair", category: "Entertainment", price: 440, months: 11),
    WishlistItem(name: "Running Shoes", category: "Sports", price: 100, months: 20),
    WishlistItem(name: "New Television", category: "Electronics", price: 1500, months: 3),
    WishlistItem(name: "Couch", category: "Furniture", price: 245, months: 6),
    WishlistItem(name: "Printer", category: "Office", price: 218, months: 3)
]

var expensesArray: [expenseStruct] = [
    expenseStruct(categoryName: "Healthcare", projectedExpenses: 1000, actualExpenses: 600.00),
    expenseStruct(categoryName: "Transport", projectedExpenses: 900, actualExpenses: 500.00),
    expenseStruct(categoryName: "Food", projectedExpenses: 800, actualExpenses: 400.00),
    expenseStruct(categoryName: "Gaming", projectedExpenses: 700, actualExpenses: 300.00),
    expenseStruct(categoryName: "Entertainment", projectedExpenses: 600, actualExpenses: 200.00),
    expenseStruct(categoryName: "Others", projectedExpenses: 500, actualExpenses: 100.00)
]

// Global Variables
var projectedSavings = Int()
var savings = Double()

func updateProjectedSavings() {
    setupIncome()
    var projSpendings = Int()
    for i in 0..<expensesArray.count {
       projSpendings += expensesArray[i].projectedExpenses
    }
    incomeArray[incomeArray.count-1].incomeMoney = income - projSpendings
    projectedSavings = incomeArray[incomeArray.count-1].incomeMoney
}

func updateGlobalSavings() {
    setupIncome()
    var spendings = Double()
    for i in 0..<expensesArray.count {
        spendings += expensesArray[i].actualExpenses
    }
    savings = Double(income) - spendings
}

var income = Int()

func setupIncome() {
    income = 0
    for i in 0..<incomeArray.count-1 {
        income += incomeArray[i].incomeMoney
    }
}
