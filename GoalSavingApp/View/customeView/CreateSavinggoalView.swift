//
//  CreateSavinggoalView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI

struct CreateSavinggoalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var goalName = ""
    @State private var category = "Travelling"
    @State private var targetAmount = ""
    @State private var targetdate = ""
    
    @State private var showSuccessAlert = false
    
    let categories = ["Travelling", "Family", "Education", "Health", "Investment"]
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Please let's have the following:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 15) {
                        // Goal Name
                        Text("Goal Name").font(.caption).bold()
                        TextField("Goal Name", text: $goalName)
                            .textFieldStyle(.roundedBorder)
                        
                        
                        Text("Goal Category").font(.caption).bold()
                        Picker("Category", selection: $category) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
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
                        
                        // Date Picker (Using your custom component)
                        CustomTextFieldInputDate(
                            title: "Savings Target Date",
                            placeholder: "Enter Saving target date",
                            text: $targetdate,
                            rightIcon: "calendar",
                            showDoneButton: true
                        )
                    }
                    
                    Spacer()
                    
                    // Create Goal Button
                    Button(action: {
                        // Trigger Success UI
                        showSuccessAlert = true
                    }) {
                        Text("Create a Goal")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hexString: "#82C952"))
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
                                .foregroundColor(.primary)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            
            // Reusable Success Alert Overlay
            if showSuccessAlert {
                SuccessAlertView(
                    title: "\(goalName) Goal",
                    message: "You are one step closer to reaching your target",
                    buttonText: "Go to My Goals"
                ) {
                    // Logic from your saved instructions:
                    // completion(payload.message, true, payload)
                    showSuccessAlert = false
                    dismiss()
                }
            }
        }
    }
}
