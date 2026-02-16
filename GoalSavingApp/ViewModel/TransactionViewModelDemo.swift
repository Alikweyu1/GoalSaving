//
//  TransactionViewModelDemo.swift
//  GoalSavingApp
//
//  Created by Dianna Museve on 16/02/2026.
//

import Foundation
enum TrazationType{
    case DEPOSIT,WITHDRAWAL
}
struct TransactionViewModelDemo:Identifiable,Hashable{
    let id   = UUID()
    let type:TrazationType
    let  REFNo:String
    let Amount:String
    let  transactionDate:String
    
    static func == (lhs: TransactionViewModelDemo, rhs: TransactionViewModelDemo) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}

struct TransactionMockData {
    static func TransactionDemo()-> [TransactionViewModelDemo]{
        return [
            TransactionViewModelDemo(type: .DEPOSIT, REFNo: "MPESA123345", Amount: "KES 6000", transactionDate: "26 Sep 2025"),
            TransactionViewModelDemo(type: .WITHDRAWAL, REFNo: "MPESA128867", Amount: "KES 2000", transactionDate: "26 Sep 2025"),
            TransactionViewModelDemo(type: .DEPOSIT, REFNo: "MPESA655454", Amount: "KES 6000", transactionDate: "26 Sep 2025")
        ]
    }
    
}
