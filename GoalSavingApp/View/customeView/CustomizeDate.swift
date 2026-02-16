//
//  CustomizeDate.swift
//  GoalSavingApp
//
//  Created by Ali Kweyu on 16/02/2026.
//

import Foundation
import SwiftUI

struct CustomTextFieldInputDate: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    var rightIcon:String? = nil
    let showDoneButton: Bool
    
    init(
        title: String,
        placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        rightIcon:String? = nil,
        showDoneButton: Bool = true
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.rightIcon = rightIcon
        self.showDoneButton = showDoneButton
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                
                .foregroundColor(.black)
            
            HStack{
                if(rightIcon != nil){
                    Image(systemName: rightIcon ?? "")
                        .resizable()
                        .frame(width: 15,height: 15)
                        .scaledToFit()
                        .foregroundColor(Color("#587a3b"))
                }
                TextField(placeholder, text: $text)
                    
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("#587a3b").opacity(0.3), lineWidth: 1)
                            .background(Color.white)
                    )
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .toolbar {
                        if showDoneButton && needsDoneButton {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    hideKeyboard()
                                }
                                .foregroundColor(Color("#587a3b"))
                                
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // Only show done button for keyboards that don't have one
    private var needsDoneButton: Bool {
        switch keyboardType {
        case .numberPad, .phonePad, .decimalPad:
            return true
        default:
            return false
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

