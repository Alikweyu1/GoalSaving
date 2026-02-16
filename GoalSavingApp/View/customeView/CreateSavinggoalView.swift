//
//  CreateSavinggoalView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI
struct CreateSavinggoalView: some View {
    @Environment(\.dismiss) var dismiss
    @State private var goalName = ""
    @State private var category = "Travelling"
    @State private var targetAmount = ""
    @State private var targetDate = Date()
    
    let categories = ["Travelling", "Family", "Education", "Health", "Investment"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Please let's have the following:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 15) {
                    // Goal Name
                    Text("Goal Name").font(.caption).bold()
                    CustomizeTextField(text: $goalName, placeholder: "e.g. Dubai Trip")
                    
                    // Category Picker
                    Text("Goal Category").font(.caption).bold()
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    // Target Amount
                    Text("Target Amount").font(.caption).bold()
                    HStack {
                        Text("KES").font(.subheadline).foregroundColor(.secondary)
                        Divider().frame(height: 20)
                        TextField("0.00", text: $targetAmount)
                            .keyboardType(.decimalPad)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    // Date Picker
                    CustomTextFieldInputDate(title: "Savings Target Date", placeholder: "Enter Saving terget date", text: $targetDate,   rightIcon: "calender", showDoneButton: true)
                }
                
                Spacer()
                
                Button(action: {
                    // Integration: Call your success handler here
                    let message = "Goal '\(goalName)' created successfully!"
                    // completion(message, true, payload) //
                    dismiss()
                }) {
                    Text("Create a Goal")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#82C952"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .navigationTitle("Create a Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}
