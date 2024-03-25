//
//  EnterButton.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import SwiftUI

struct EnterButton: View {
    let text: String
    var isValid = true
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundStyle(.white)
                .frame(width: 200, height: 50)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .disabled(!isValid)
        .opacity(!isValid ? 0.5 : 1)
    }
}

#Preview {
    EnterButton(text: "Sign In", action: {})
}
