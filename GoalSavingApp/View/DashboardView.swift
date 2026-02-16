//
//  DashboardView.swift
//  GoalSavingApp
//
//  Created by Dianna Museve on 16/02/2026.
//

import SwiftUI

import SwiftUI

struct DashboardView: View {
    // Note: Assuming TransactionViewModelDemo and TransactionMockData are defined elsewhere
    @State private var transactions: [TransactionViewModelDemo] = TransactionMockData.TransactionDemo()
    var filterValues: [String] = ["All", "Deposit", "Withdrawal"]
    @State private var selectedFilter = "All"
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Header Section
                        HStack(spacing: 15) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading) {
                                Text("Hello There!")
                                    .font(.headline)
                                Text("It is a Good Day")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        
                        // Goals Header
                        HStack {
                            Text("My Goals")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Button(action: {
                                // Add goal logic
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add a Goal")
                                }
                                .font(.subheadline)
                            }
                        }
                        .padding(.horizontal)

                        CardSection(geometry: geo)
                        Picker("Filter", selection: $selectedFilter) {
                                                        ForEach(filterValues, id: \.self) { value in
                                                            Text(value).tag(value)
                                                        }
                        }
                                                    .pickerStyle(SegmentedPickerStyle())
                                                    .padding(.horizontal)
                                                    .tint(Color(hexString: "#007D32"))
                    
                        TransactionHistoryView(geometry: geo)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    @ViewBuilder
    func CardSection(geometry: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            VStack(spacing: 20) {
                HStack {
                    Button(action: {}) {
                        Text("Dubai Trip")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hexString: "#007D32"))
                            .padding(.horizontal, 16)
                            .frame(height: 34)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hexString: "#007D32"), lineWidth: 1)
                            )
                    }
                    Spacer()
                }
                
                VStack(spacing: 12) {
                    HStack {
                        // Displaying the balance from your transacting account
                        Text("KES 900.00")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "eye.fill")
                            .foregroundColor(.gray)
                    }
                    
                    ProgressView(value: 0.4) // Example progress
                        .tint(Color(hexString: "#007D32"))
                    
                    HStack(spacing: 15) {
                        // Action buttons - Utilizing your cash_transfer logic
                        ActionButton(title: "Deposit")
                        ActionButton(title: "Withdrawal")
                    }
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hexString: "#F5F5DC"))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    func TransactionHistoryView(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Transaction History")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(transactions) { list in
                HStack(spacing: 15) {
                    Image(systemName: list.type == .DEPOSIT ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(list.type == .DEPOSIT ? .green : .red)
                    
                    VStack(alignment: .leading) {
                        Text(list.type == .DEPOSIT ? "DEPOSIT" : "WITHDRAWAL")
                            .font(.system(size: 14, weight: .bold))
                        Text(list.REFNo)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(list.type == .DEPOSIT ? "+" : "-") \(list.Amount)")
                            .font(.system(size: 14, weight: .bold))
                        Text(list.transactionDate)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                Divider().padding(.leading, 65)
            }
        }
    }
}

// Reusable Button Component
struct ActionButton: View {
    var title: String
    var body: some View {
        Button(action: {}) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(hexString: "#007D32"))
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hexString: "#007D32"), lineWidth: 1)
                )
        }
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
