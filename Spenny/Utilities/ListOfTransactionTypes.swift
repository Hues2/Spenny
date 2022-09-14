//
//  ListOfTransactionTypes.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation


struct ListOfTransactionTypes{
    static let transactionTypes: [TransactionType] = [
        TransactionType(iconName: "house.fill", title: "Rent", colorHex: "#75D5FF"),
        TransactionType(iconName: "car.fill", title: "Car", colorHex: "#FFD478"),
        TransactionType(iconName: "iphone", title: "Phone", colorHex: "#FF7D78"),
        TransactionType(iconName: "music.note", title: "Music", colorHex: "#00C17C"),
        TransactionType(iconName: "heart.fill", title: "Gym", colorHex: "#D783FF"),
        TransactionType(iconName: "fork.knife", title: "Food", colorHex: "#00B498"),
        TransactionType(iconName: "person.fill", title: "Friend", colorHex: "#FF3A6F"),
        TransactionType(iconName: "tshirt.fill", title: "Clothes", colorHex: "#8CB2D3"),
        TransactionType(iconName: "theatermasks.fill", title: "Entertainment", colorHex: "#A347EC"),
        TransactionType(iconName: "doc.text.image.fill", title: "Insurance", colorHex: "#7980FF"),
        TransactionType(iconName: "creditcard.fill", title: "Credit", colorHex: "#FF9F5D"),
        TransactionType(iconName: "fuelpump.fill", title: "Fuel", colorHex: "#5A6119"),
        TransactionType(iconName: "questionmark.circle.fill", title: "Other", colorHex: "#424242")
    ]
    
    static let listofFakeTransactions: [Transaction] = [
        Transaction(title: "Aldi", amount: 25.0, date: "31/05/2022", transactionType: TransactionType(iconName: "house.fill", title: "Test", colorHex: "#75D5FF")),
        Transaction(title: "Aldi", amount: 25.0, date: "31/05/2022", transactionType: TransactionType(iconName: "house.fill", title: "Test", colorHex: "#75D5FF")),
        Transaction(title: "Aldi", amount: 25.0, date: "31/05/2022", transactionType: TransactionType(iconName: "house.fill", title: "Test", colorHex: "#75D5FF")),
        Transaction(title: "Aldi", amount: 25.0, date: "31/05/2022", transactionType: TransactionType(iconName: "house.fill", title: "Test", colorHex: "#75D5FF")),
        Transaction(title: "Aldi", amount: 25.0, date: "31/05/2022", transactionType: TransactionType(iconName: "house.fill", title: "Test", colorHex: "#75D5FF")),
        Transaction(title: "Aldi", amount: 25.0, date: "31/05/2022", transactionType: TransactionType(iconName: "house.fill", title: "Test", colorHex: "#75D5FF"))
    ]
}
