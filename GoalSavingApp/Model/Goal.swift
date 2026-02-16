//
//  Goal.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import Foundation
import SwiftUI

// MARK: - Models
struct Goal: Identifiable, Codable {
    var id = UUID()
    var name: String
    var targetAmount: Double
    var currentAmount: Double
    var deadline: Date
    var category: GoalCategory
    var colorHex: String
    
    var progress: Double {
        guard targetAmount > 0 else { return 0 }
        return min(currentAmount / targetAmount, 1.0)
    }
    
    var remainingAmount: Double {
        max(targetAmount - currentAmount, 0)
    }
    
    var color: Color {
        Color(hex: colorHex) ?? category.defaultColor
    }
}

enum GoalCategory: String, Codable, CaseIterable {
    case vacation = "Vacation"
    case education = "Education"
    case emergency = "Emergency Fund"
    case car = "Car"
    case home = "Home"
    case electronics = "Electronics"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .vacation: return "airplane"
        case .education: return "book.fill"
        case .emergency: return "shield.fill"
        case .car: return "car.fill"
        case .home: return "house.fill"
        case .electronics: return "laptopcomputer"
        case .other: return "star.fill"
        }
    }
    
    var defaultColor: Color {
        switch self {
        case .vacation: return .blue
        case .education: return .purple
        case .emergency: return .red
        case .car: return .orange
        case .home: return .green
        case .electronics: return .cyan
        case .other: return .gray
        }
    }
}

// MARK: - Color Extension
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
    func toHex() -> String? {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        return String(format: "#%02lX%02lX%02lX",
                     lroundf(r * 255),
                     lroundf(g * 255),
                     lroundf(b * 255))
    }
}



// MARK: - Supporting Views
struct SummaryCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct EmptyStateView: View {
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "target")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green.opacity(0.5))
            
            VStack(spacing: 8) {
                Text("Start Saving Towards Your Goals")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Turn your goals into savings")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: action) {
                Text("Create Your First Goal")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity)
        .background(Color.green.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
}


// MARK: - Goal Detail View
struct GoalDetailView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @Environment(\.dismiss) var dismiss
    
    let goal: Goal
    
    @State private var showingAddMoney = false
    @State private var amountToAdd = ""
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image(systemName: goal.category.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(goal.color)
                    
                    Text(goal.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(goal.category.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(goal.color.opacity(0.1))
                .cornerRadius(16)
                
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("KES \(Int(goal.currentAmount))")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("of KES \(Int(goal.targetAmount))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(Int(goal.progress * 100))%")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(goal.color)
                            Text("Complete")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color(.systemGray6))
                                .frame(height: 12)
                                .cornerRadius(6)
                            
                            Rectangle()
                                .fill(goal.color)
                                .frame(width: geometry.size.width * goal.progress, height: 12)
                                .cornerRadius(6)
                        }
                    }
                    .frame(height: 12)
                }
                .padding()
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(16)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    StatCard(
                        title: "Remaining",
                        value: "KES \(Int(goal.remainingAmount))",
                        icon: "chart.line.uptrend.xyaxis",
                        color: .orange
                    )
                    
                    StatCard(
                        title: "Deadline",
                        value: formatDate(goal.deadline),
                        icon: "calendar",
                        color: .blue
                    )
                }
                
                VStack(spacing: 12) {
                    Button(action: { showingAddMoney = true }) {
                        Label("Add Money", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(goal.color)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { showingDeleteAlert = true }) {
                        Label("Delete Goal", systemImage: "trash")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Goal Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddMoney) {
            AddMoneySheet(goal: goal, amountToAdd: $amountToAdd) {
                addMoney()
            }
        }
        .alert("Delete Goal", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteGoal(goal)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this goal? This action cannot be undone.")
        }
    }
    
    private func addMoney() {
        guard let amount = Double(amountToAdd), amount > 0 else { return }
        viewModel.addMoney(to: goal, amount: amount)
        amountToAdd = ""
        showingAddMoney = false
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(12)
    }
}

struct AddMoneySheet: View {
    let goal: Goal
    @Binding var amountToAdd: String
    let onAdd: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(goal.color)
                
                Text("Add Money to")
                    .font(.headline)
                Text(goal.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amount (KES)")
                        .font(.headline)
                    
                    TextField("0", text: $amountToAdd)
                        .keyboardType(.decimalPad)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    onAdd()
                }) {
                    Text("Add Money")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(goal.color)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .disabled(amountToAdd.isEmpty || Double(amountToAdd) ?? 0 <= 0)
            }
            .padding()
            .navigationTitle("Add Money")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
