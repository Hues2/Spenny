//
//  ListOfTransactionTypes.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation


struct ListOfTransactionTypes{
    static let transactionTypes: [TransactionType] = [
        TransactionType(iconName: "house.fill", typeTitle: "Rent", hexColor: "#75D5FF"),
        TransactionType(iconName: "car.fill", typeTitle: "Car", hexColor: "#FFD478"),
        TransactionType(iconName: "iphone", typeTitle: "Phone", hexColor: "#FF7D78"),
        TransactionType(iconName: "music.note", typeTitle: "Music", hexColor: "#00C17C"),
        TransactionType(iconName: "heart.fill", typeTitle: "Gym", hexColor: "#D783FF"),
        TransactionType(iconName: "fork.knife", typeTitle: "Food", hexColor: "#00B498"),
        TransactionType(iconName: "person.fill", typeTitle: "Friend", hexColor: "#FF3A6F"),
        TransactionType(iconName: "tshirt.fill", typeTitle: "Clothes", hexColor: "#8CB2D3"),
        TransactionType(iconName: "theatermasks.fill", typeTitle: "Entertainment", hexColor: "#A347EC"),
        TransactionType(iconName: "doc.text.image.fill", typeTitle: "Insurance", hexColor: "#7980FF"),
        TransactionType(iconName: "creditcard.fill", typeTitle: "Credit", hexColor: "#FF9F5D"),
        TransactionType(iconName: "fuelpump.fill", typeTitle: "Fuel", hexColor: "#5A6119"),
        TransactionType(iconName: "questionmark.circle.fill", typeTitle: "Other", hexColor: "#424242")
    ]
    
//    static let listofFakeTransactions: [TransactionEntity] = [
//        TransactionEntity(title: "Aldi Shop", amount: 255.00, date: "31/05/22", transactionType: TransactionType(iconName: "car.fill", title: "Car", colorHex: "#FFD478"), isDirectDebit: true),
//        TransactionEntity(title: "Paid Georgia", amount: 4.99, date: "31/05/22", transactionType: TransactionType(iconName: "house.fill", title: "Rent", colorHex: "#75D5FF"), isDirectDebit: false),
//        TransactionEntity(title: "Greggs", amount: 25.09, date: "31/05/22", transactionType: TransactionType(iconName: "fork.knife", title: "Food", colorHex: "#00B498"), isDirectDebit: false),
//        TransactionEntity(title: " ", amount: 567.18, date: "31/05/22", transactionType: TransactionType(iconName: "questionmark.circle.fill", title: "Other", colorHex: "#424242"), isDirectDebit: true),
//        TransactionEntity(title: "Amazon Mechanical Keyboard", amount: 25.0, date: "31/05/22", transactionType: TransactionType(iconName: "tshirt.fill", title: "Clothes", colorHex: "#8CB2D3"), isDirectDebit: false),
//        TransactionEntity(title: "Tesco", amount: 25.0, date: "31/05/22", transactionType: TransactionType(iconName: "creditcard.fill", title: "Credit", colorHex: "#FF9F5D"), isDirectDebit: true)
//    ]
}
