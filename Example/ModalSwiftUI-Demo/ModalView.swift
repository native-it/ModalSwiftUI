//
//  ModalView.swift
//  ModalSwiftUI-Demo
//
//  Created by Ivo Leko on 12.04.2024..
//

import SwiftUI

struct ModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            Spacer()
            Image(.coffee)
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
            }
            Spacer()
        }
    }
}

#Preview {
    ModalView()
}
