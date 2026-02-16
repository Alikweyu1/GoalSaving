//
//  SuccessAlertView.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import SwiftUI

import SwiftUI

struct SuccessAlertView: View {
    let title: String
    let message: String
    let buttonText: String
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
           
            VStack(spacing: 20) {
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .shadow(color: .black.opacity(0.1), radius: 10)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(hexString: "#82C952"))
                }
                .padding(.top, -40) 
                
                VStack(spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color(hexString: "#82C952"))
                        .multilineTextAlignment(.center)
                    
                    Text("Created Successfully")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                // Action Button
                Button(action: {
                    onDismiss()
                }) {
                    Text(buttonText)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hexString: "#82C952"))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

//#Preview {
//    SuccessAlertView()
//}
