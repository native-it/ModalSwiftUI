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
    var animated: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        
        if !self.animated {
            //disable pull down to close
            self.isModalInPresentation = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isBeingDismissed && !self.animated {
            UIView.setAnimationsEnabled(false)
        }
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func endAppearanceTransition() {
         if isBeingDismissed{
              dismissBlock?()
         }
         super.endAppearanceTransition()
     }
}
