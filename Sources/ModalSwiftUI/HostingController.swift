//
//  HostingController.swift
//  ModalSwiftUI
//
//  Created by Ivo Leko on 11.04.2024..
//

import SwiftUI
import UIKit

internal class MyHostingViewController<Content>: UIHostingController<Content> where Content : View {
    var dismissBlock: (() -> Void)?
    var backgroundColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
    }
    
    override func endAppearanceTransition() {
         if isBeingDismissed{
              dismissBlock?()
         }
         super.endAppearanceTransition()
     }
}
