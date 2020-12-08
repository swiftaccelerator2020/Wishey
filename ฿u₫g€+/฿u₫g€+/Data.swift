//
//  Data.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 30/11/20.
//

import Foundation

struct projectedIncome {
    var incomeName: String
    var incomeMoney: Int
}
struct projectedExpenses {
    var expenseName: String
    var expenseMoney: Int
}

var projectedIncomeArray = [projectedIncome(incomeName: "Salary",incomeMoney: 3400), projectedIncome(incomeName: "Other",incomeMoney: 6), projectedIncome(incomeName: "Savings",incomeMoney: 3324)]

var projectedExpensesArray = [projectedExpenses(expenseName: "Food",expenseMoney: 30),projectedExpenses(expenseName: "Transport",expenseMoney: 20),projectedExpenses(expenseName: "Healthcare",expenseMoney: 20),projectedExpenses(expenseName: "Entertainment",expenseMoney: 12)]
