//
//  ContentView.swift
//  ModalSwiftUI-Demo
//
//  Created by Ivo Leko on 12.04.2024..
//

import SwiftUI
import ModalSwiftUI

struct ContentView: View {
    @State var isPresentedView = false
    @State var isPresentedNav = false
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
                self.isPresentedView = true
            }

            
            Button("Show Modal Nav") {
                self.isPresentedNav = true
            }
        }
        .padding()
        .onAppear {
            print("View Appeared.")
        }
        .onDisappear(perform: {
            print("View Disppeared.")
        })
        .modal(isPresented: $isPresentedView,
               animated: animated,
               transitionStyle: transitionStyle,
               presentationStyle: presentationStyle,
               backgroundColor: .yellow.opacity(0.5)) {
            print("Dismissed.")
        } content: {
            ModalView(isPresented: $isPresentedView)
        }
        .modal(isPresented: $isPresentedNav,
               animated: animated,
               transitionStyle: transitionStyle,
               presentationStyle: presentationStyle) {
            print("Dismissed.")
        } content: {
            NavigationStack {
                ModalView(isPresented: $isPresentedNav)
                    .navigationTitle("Modal View")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("Cancel") {
                            isPresentedNav = false
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
