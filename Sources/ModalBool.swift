//
//  ModalBool.swift
//  ModalSwiftUI
//
//  Created by Ivo Leko on 11.04.2024..
//

import SwiftUI
import UIKit

internal class ModalController_Bool<Content : View>: UIViewController {
    
    var animated: Bool
    var contentView: (() -> Content)
    var transitionStyle: UIModalTransitionStyle
    var presentationStyle: UIModalPresentationStyle
    var observer: NSKeyValueObservation?
    var onDismiss: (() -> Void)?
    var bindingDismissActive: Bool = false
    var backgroundColor: Color
    
    var isPresented: Binding<Bool> {
        didSet {
            if isPresented.wrappedValue && self.presentedViewController == nil {
                self.showModal()
            }
            else if !isPresented.wrappedValue && self.presentedViewController != nil {
                self.hideModal()
            }
        }
    }

    init(isPresented: Binding<Bool>, animated: Bool, transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle, backgroundColor: Color, onDismiss: (() -> Void)?, contentView: @escaping (() -> Content)) {
        self.isPresented = isPresented
        self.contentView = contentView
        self.animated = animated
        self.transitionStyle = transitionStyle
        self.presentationStyle = presentationStyle
        self.onDismiss = onDismiss
        self.backgroundColor = backgroundColor
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
    }
    
    private func showModal() {
        let host = MyHostingViewController(rootView: contentView())
        host.backgroundColor = UIColor(self.backgroundColor)
        host.modalTransitionStyle = transitionStyle
        host.modalPresentationStyle = presentationStyle
        host.dismissBlock = { [weak self] in
            if self?.bindingDismissActive == false {
                self?.isPresented.wrappedValue = false
            }
            self?.onDismiss?()
        }
        
        self.present(host, animated: animated) {
            if self.isPresented.wrappedValue == false {
                self.hideModal()
            }
        }
    }
    
    private func hideModal() {
        bindingDismissActive = true
        self.dismiss(animated: animated) {
            self.bindingDismissActive = false
            if self.isPresented.wrappedValue == true {
                self.showModal()
            }
        }
    }
}

internal struct ModalController_Bool_Representable <Content : View>: UIViewControllerRepresentable {
    
    @Binding private var isPresented: Bool
    private var animated: Bool
    private var contentView: (() -> Content)
    private var transitionStyle: UIModalTransitionStyle
    private var presentationStyle: UIModalPresentationStyle
    private var backgroundColor: Color
    private var onDismiss: (() -> Void)?
    
    init(isPresented: Binding<Bool>, animated: Bool, transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle, backgroundColor: Color, onDismiss: (() -> Void)?, contentView: @escaping (() -> Content)) {
        self._isPresented = isPresented
        self.contentView = contentView
        self.animated = animated
        self.transitionStyle = transitionStyle
        self.presentationStyle = presentationStyle
        self.onDismiss = onDismiss
        self.backgroundColor = backgroundColor
    }
    
    internal func makeUIViewController(context: Context) -> ModalController_Bool<Content> {
        return ModalController_Bool(isPresented: _isPresented,
                                    animated: animated,
                                    transitionStyle: transitionStyle,
                                    presentationStyle: presentationStyle,
                                    backgroundColor: backgroundColor,
                                    onDismiss: onDismiss,
                                    contentView: contentView
        )
    }
    
    internal func updateUIViewController(_ uiViewController: ModalController_Bool<Content>, context: Context) {
        uiViewController.isPresented = _isPresented
        uiViewController.contentView = contentView
        uiViewController.transitionStyle = transitionStyle
        uiViewController.presentationStyle = presentationStyle
        uiViewController.animated = animated
        uiViewController.onDismiss = onDismiss
        uiViewController.backgroundColor = backgroundColor
    }
}
