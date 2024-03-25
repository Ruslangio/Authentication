//
//  InputView.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    var isSecureField = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Group {
            if isSecureField {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
        }
        .padding(10)
        .background(.primary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .autocorrectionDisabled()
        .focused($isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Login")
}
