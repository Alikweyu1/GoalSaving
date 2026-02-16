//
//  DashboardView.swift
//  GoalSavingApp
//
//  Created by Dianna Museve on 16/02/2026.
//

import SwiftUI


import SwiftUI

struct DashboardView: View {
    // Using your provided Mock Data and View Model
    @State private var transactions: [TransactionViewModelDemo] = TransactionMockData.TransactionDemo()
    @State private var selectedFilter = "All"
    @State private var isAddingGoal = false
    
    var filterValues: [String] = ["All", "Deposit", "Withdrawal"]
    
    // Filtering logic based on your enum types
    var filteredTransactions: [TransactionViewModelDemo] {
        if selectedFilter == "All" {
            return transactions
        } else {
            return transactions.filter {
                selectedFilter == "Deposit" ? $0.type == .DEPOSIT : $0.type == .WITHDRAWAL
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(hexString: "#F8F9FB").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 1. Dark Green Header (Matches Screenshots)
                    headerSection
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 25) {
                            
                            // 2. My Goals Section (Carousel)
                            goalsCarouselSection
                            
                            // 3. Transaction History Section
                            VStack(alignment: .leading, spacing: 15) {
                                historyHeader
                                
                                // Filter Pills (Horizontal Scroll)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(filterValues, id: \.self) { filter in
                                            FilterPill(title: filter, isSelected: selectedFilter == filter)
                                                .onTapGesture { selectedFilter = filter }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                
                                // Transaction List using your ViewModel
                                LazyVStack(spacing: 0) {
                                    ForEach(filteredTransactions) { transaction in
                                        TransactionRow(item: transaction)
                                        Divider().padding(.leading, 70)
                                    }
                                }
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isAddingGoal) {
                CreateSavinggoalView()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var headerSection: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 45, height: 45)
                .foregroundColor(.white)
            
            VStack(alignment: .leading) {
                Text("Hello There!")
                    .font(.system(size: 18, weight: .bold))
                Text("It's a good day to save")
                    .font(.system(size: 14))
                    .opacity(0.8)
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color(hexString: "#063B27"))
    }
    
    private var goalsCarouselSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("My Goals").font(.headline)
                Spacer()
                Button(action: { isAddingGoal = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                        Text("Add a Goal")
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hexString: "#43A047"))
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Card 1: Dubai Trip
                    GoalCard(title: "Dubai Trip", balance: "900.00", target: "10,000.00", progress: 0.09, color: Color(hexString: "#063B27"))
                    // Card 2: Kids Savings
                    GoalCard(title: "Kids Savings", balance: "0.00", target: "120,000.00", progress: 0.0, color: Color(hexString: "#43A047"))
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var historyHeader: some View {
        HStack {
            Text("Transaction History").font(.headline)
            Spacer()
            Text("View all")
                .font(.system(size: 14))
                .foregroundColor(Color(hexString: "#43A047"))
        }
        .padding(.horizontal)
    }
}

// MARK: - Components

struct GoalCard: View {
    var title: String
    var balance: String
    var target: String
    var progress: Double
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title).font(.caption).bold()
                Spacer()
                Image(systemName: "ellipsis.circle.fill")
            }
            
            HStack(alignment: .bottom, spacing: 4) {
                Text(balance).font(.title2).bold()
                Text("KES").font(.caption2).padding(.bottom, 4)
                Image(systemName: "eye.fill").font(.caption2).padding(.bottom, 4)
            }
            
            ProgressView(value: progress)
                .tint(.white)
                .background(Color.white.opacity(0.3))
            
            Text("Target Amount (KES) \(target)").font(.system(size: 10))
            
            HStack(spacing: 10) {
                ActionButton(title: "Deposit", icon: "arrow.up.right")
                ActionButton(title: "Withdraw", icon: "arrow.down.left")
            }
        }
        .padding()
        .frame(width: 280)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(15)
    }
}
struct ActionButton: View {
    var title: String
    var icon: String
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.system(size: 12, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)
        }
    }
}
struct TransactionRow: View {
    let item: TransactionViewModelDemo
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(item.type == .DEPOSIT ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: item.type == .DEPOSIT ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                    .foregroundColor(item.type == .DEPOSIT ? .green : .red)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.type == .DEPOSIT ? "Deposit" : "Withdrawal")
                    .font(.system(size: 14, weight: .bold))
                Text(item.REFNo).font(.caption).foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(item.Amount)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(item.type == .WITHDRAWAL ? .red : .primary)
                Text(item.transactionDate).font(.caption2).foregroundColor(.gray)
            }
        }
        .padding()
    }
}

// Helper for Hex Colors
extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}
#Preview {
    DashboardView()
}
@ViewBuilder
func  navigate() -> some View {
    CreateSavinggoalView()
}
struct FilterPill: View {
    var title: String
    var isSelected: Bool
    var body: some View {
        Text(title)
            .font(.caption).bold()
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.green.opacity(0.1) : Color.clear)
            .foregroundColor(isSelected ? .green : .gray)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.green : Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}
