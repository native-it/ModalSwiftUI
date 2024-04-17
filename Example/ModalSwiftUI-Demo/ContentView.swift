//
//  ContentView.swift
//  ModalSwiftUI-Demo
//
//  Created by Ivo Leko on 12.04.2024..
//

import SwiftUI
import ModalSwiftUI

struct ContentView: View {
    
    enum PresentType: Identifiable {
        var id: Self {
            return self
        }
        
        case regular
        case withNavigation
    }
    
    var isPresented: Binding<Bool> {
        Binding {
            self.presentedItem != nil
        } set: { bool in
            if !bool {
                self.presentedItem = nil
            }
        }
    }
    
    @State var presentedItem: PresentType? = nil
    @State var animated: Bool = true
    @State var presentationStyle: UIModalPresentationStyle = .fullScreen
    @State var transitionStyle: UIModalTransitionStyle = .coverVertical
    
    var body: some View {
        VStack(spacing: 30) {
            
            Picker("Animation", selection: $animated) {
                            Text("Animated").tag(true)
                            Text("Without Animation").tag(false)
            }
            .pickerStyle(.segmented)
            
            Picker("Presentation Style", selection: $presentationStyle) {
                Text("Fullscreen").tag(UIModalPresentationStyle.fullScreen)
                Text("Over Fullscreen").tag(UIModalPresentationStyle.overFullScreen)
                Text("Page Sheet").tag(UIModalPresentationStyle.pageSheet)
            }
            .pickerStyle(.segmented)
            
            Picker("Transition Style", selection: $transitionStyle) {
                Text("Cover vertical").tag(UIModalTransitionStyle.coverVertical)
                Text("Cross Dissolve").tag(UIModalTransitionStyle.crossDissolve)
                Text("Flip Horizontal").tag(UIModalTransitionStyle.flipHorizontal)
            }
            .pickerStyle(.segmented)
            
            Button("Show Modal View") {
                self.presentedItem = .regular
            }
            
            Button("Show Modal Nav") {
                self.presentedItem = .withNavigation
            }
        }
        .padding()
        .onAppear {
            print("View Appeared.")
        }
        .onDisappear(perform: {
            print("View Disppeared.")
        })
        .modal(item: $presentedItem,
               animated: animated,
               transitionStyle: transitionStyle,
               presentationStyle: presentationStyle,
               backgroundColor: .yellow.opacity(0.5)) {
            print("Dismissed.")
        } content: { item in
            switch item {
            case .regular:
                ModalView(isPresented: isPresented)
            case .withNavigation:
                NavigationStack {
                    ModalView(isPresented: isPresented)
                        .navigationTitle("Modal View")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            Button("Cancel") {
                                self.isPresented.wrappedValue = false
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
