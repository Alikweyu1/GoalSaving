//
//  TransactionView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI

enum TransactionType {
    case withdraw
    case deposit
    
    var title: String {
        switch self {
        case .withdraw: return "Withdraw"
        case .deposit: return "Deposit"
        }
    }
}

enum AccountType: String, CaseIterable {
    case coopAccount = "Coop-Account"
    case mpesa = "M-PESA"
    
    var icon: String {
        switch self {
        case .coopAccount: return "building.columns.fill"
        case .mpesa: return "phone.fill"
        }
    }
}

struct TransactionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: GoalViewModel
    
    let transactionType: TransactionType
    let goal: Goal?
    
    @State private var selectedTrip = "Outbot Trip"
    @State private var selectedFromAccount: AccountType = .coopAccount
    @State private var selectedToAccount: AccountType = .mpesa
    @State private var amount = ""
    @State private var showingSuccess = false
    
    // Mock account data
    let availableBalance = 100103.0
    let creditAccountBalance = 87040206.0
    let accountNumber = "0197012A2622"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Transaction Type Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding(8)
                        }
                        
                        Spacer()
                        
                        Text(transactionType.title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Placeholder for symmetry
                        Color.clear
                            .frame(width: 32, height: 32)
                    }
                    .padding()
                    .background(Color.green.gradient)
                    
                    VStack(spacing: 20) {
                        // Goal/Trip Selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Goal Name")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Menu {
                                Button(selectedTrip) { }
                                if let goal = goal {
                                    Button(goal.name) {
                                        selectedTrip = goal.name
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedTrip)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                        
                        // Available Balance
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Available balance: \(Int(availableBalance)) KES")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text("Withdraw from")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        // From Account Selection
                        HStack(spacing: 16) {
                            AccountButton(
                                account: .coopAccount,
                                isSelected: selectedFromAccount == .coopAccount
                            ) {
                                selectedFromAccount = .coopAccount
                            }
                            
                            AccountButton(
                                account: .mpesa,
                                isSelected: selectedFromAccount == .mpesa
                            ) {
                                selectedFromAccount = .mpesa
                            }
                        }
                        
                        // Credit Account Details
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Credit Account")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Menu {
                                Button("200m Account - \(accountNumber)") { }
                            } label: {
                                HStack {
                                    Image(systemName: "creditcard.fill")
                                        .foregroundColor(.green)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("200m Account")
                                            .font(.subheadline)
                                        Text(accountNumber)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                            
                            Text("Available balance: \(Int(creditAccountBalance)) KES")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        // To Account Selection (for Deposit)
                        if transactionType == .deposit {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Deposit to")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                HStack(spacing: 16) {
                                    AccountButton(
                                        account: .coopAccount,
                                        isSelected: selectedToAccount == .coopAccount
                                    ) {
                                        selectedToAccount = .coopAccount
                                    }
                                    
                                    AccountButton(
                                        account: .mpesa,
                                        isSelected: selectedToAccount == .mpesa
                                    ) {
                                        selectedToAccount = .mpesa
                                    }
                                }
                            }
                        }
                        
                        // Amount Input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Amount to \(transactionType == .withdraw ? "withdraw" : "deposit")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Text("KES")
                                    .foregroundColor(.secondary)
                                
                                TextField("100.00", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .font(.headline)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                    // Action Button
                    Button(action: processTransaction) {
                        Text(transactionType.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFormValid ? Color.green : Color.gray)
                            .cornerRadius(8)
                    }
                    .disabled(!isFormValid)
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showingSuccess) {
                TransactionSuccessView(
                    amount: Double(amount) ?? 0,
                    transactionType: transactionType
                ) {
                    if let goal = goal, transactionType == .deposit {
                        if let amountValue = Double(amount) {
                            viewModel.addMoney(to: goal, amount: amountValue)
                        }
                    }
                    dismiss()
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !amount.isEmpty && Double(amount) ?? 0 > 0
    }
    
    private func processTransaction() {
        // Simulate transaction processing
        showingSuccess = true
    }
}

struct AccountButton: View {
    let account: AccountType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: account.icon)
                    .foregroundColor(isSelected ? .green : .secondary)
                
                Text(account.rawValue)
                    .font(.subheadline)
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.green.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.green : Color.clear, lineWidth: 2)
            )
        }
    }
}

#Preview {
    TransactionView()
}
