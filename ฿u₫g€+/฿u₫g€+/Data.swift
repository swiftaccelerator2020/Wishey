//
//  Data.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 30/11/20.
//

import Foundation

// Structs
struct projectedIncome {
    var incomeName: String
    var incomeMoney: Int
}
struct projectedExpenses {
    var expenseName: String
    var expenseMoney: Int
}

struct expenseStruct {
    var name: String
    var projectedSpending: Int
    var actualSpending: Int
}

struct spendingStruct {
    var value: Double
    var name: String
}

struct WishlistItem {
    var name: String
    var category: String
    var price: Int
    var months: Int
    var url: String?
}

// Arrays
var projectedIncomeArray = [
    projectedIncome(incomeName: "Salary", incomeMoney: 5000),
    projectedIncome(incomeName: "Other", incomeMoney: 6*7*20),
    projectedIncome(incomeName: "Savings", incomeMoney: 0)
]

var projectedExpensesArray = [
    projectedExpenses(expenseName: "Healthcare", expenseMoney: 100),
    projectedExpenses(expenseName: "Transport", expenseMoney: 900),
    projectedExpenses(expenseName: "Food",expenseMoney: 800),
    projectedExpenses(expenseName: "Gaming", expenseMoney: 700),
    projectedExpenses(expenseName: "Entertainment", expenseMoney: 600),
    projectedExpenses(expenseName: "Others", expenseMoney: 500)
]
var expenses = [expenseStruct(name: "Food", projectedSpending: 100, actualSpending: 65),
                expenseStruct(name: "Entertainment", projectedSpending: 50, actualSpending: 30),
                expenseStruct(name: "Tuition", projectedSpending: 300, actualSpending: 250)
]

var wishlist: [WishlistItem] = [
    WishlistItem(name: "Watch", category: "Luxury", price: 300, months: 3),
    WishlistItem(name: "Gaming Chair", category: "Entertainment", price: 440, months: 11),
    WishlistItem(name: "Running Shoes", category: "Sports", price: 100, months: 20),
    WishlistItem(name: "New Television", category: "Electronics", price: 1500, months: 3),
    WishlistItem(name: "Couch", category: "Furniture", price: 245, months: 6),
    WishlistItem(name: "Printer", category: "Office", price: 218, months: 3)
]

var data: [spendingStruct] = [
    spendingStruct(value: 600.00, name: "Healthcare"),
    spendingStruct(value: 500.00, name: "Transport"),
    spendingStruct(value: 400.00, name: "Food"),
    spendingStruct(value: 300.00, name: "Gaming"),
    spendingStruct(value: 200.00, name: "Entertainment"),
    spendingStruct(value: 100.00, name: "Others")
]

// Global Variables
var savings = projectedIncomeArray[projectedIncomeArray.count-1].incomeMoney

func updateSavings() {
    setupIncome()
    var spendings = Int()
    for i in 0..<projectedExpensesArray.count {
       spendings += projectedExpensesArray[i].expenseMoney
    }
    projectedIncomeArray[projectedIncomeArray.count-1].incomeMoney = income - spendings
    updateGlobalSavings()
}

func updateGlobalSavings() {
    savings = projectedIncomeArray[projectedIncomeArray.count-1].incomeMoney
}

var income = Int()

func setupIncome() {
    income = 0
    for i in 0..<projectedIncomeArray.count-1 {
        income += projectedIncomeArray[i].incomeMoney
    }
}
