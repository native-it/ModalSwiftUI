//
//  ModalView.swift
//  ModalSwiftUI-Demo
//
//  Created by Ivo Leko on 12.04.2024..
//

import SwiftUI

struct ModalView: View {
    //@Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            Image(.coffee)
            Spacer()
            Button {
                //dismiss() //this will always be with animation
                isPresented = false
            } label: {
                Text("Dismiss")
            }
            Spacer()
        }
    }
}

#Preview {
    ModalView(isPresented: .constant(true))
}
