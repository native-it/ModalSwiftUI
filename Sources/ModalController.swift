//
//  File.swift
//  
//
//  Created by Ivo Leko on 16.04.2024..
//

import SwiftUI
import UIKit

internal class ModalController_Item<Content : View, Item: Identifiable>: UIViewController {
    
    private enum ModalState {
        case presenting(Item)
        case presented(Item)
        case dismissing(Item)
        case idle
    }
    
    var animated: Bool
    var contentView: ((Item) -> Content)
    var transitionStyle: UIModalTransitionStyle
    var presentationStyle: UIModalPresentationStyle
    var observer: NSKeyValueObservation?
    var onDismiss: (() -> Void)?
    var backgroundColor: Color
    
    private var modalState: ModalState = .idle
    
    var item: Binding<Item?> {
        didSet {
            self.updateModal()
        }
    }

    init(item: Binding<Item?>, animated: Bool, transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle, backgroundColor: Color, onDismiss: (() -> Void)?, contentView: @escaping ((Item) -> Content)) {
        self.item = item
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
    
    private func checkStateForDismissing() {
        switch modalState {
        case .presented(let item):
            if self.presentedViewController == nil {
                self.modalState = .dismissing(item)
            }
        default:
            break
        }
    }
    
    private func updateModal() {
        self.checkStateForDismissing()
        if let item = self.item.wrappedValue {
            switch modalState {
            case .idle:
                let host = MyHostingViewController(rootView: contentView(item))
                host.backgroundColor = UIColor(self.backgroundColor)
                host.modalTransitionStyle = transitionStyle
                host.modalPresentationStyle = presentationStyle
                host.dismissBlock = { [weak self] in
                    self?.modalState = .idle
                    self?.onDismiss?()
                    if self?.item.wrappedValue?.id == item.id { //check if new item arrived while dismissing
                        self?.item.wrappedValue = nil
                    }
                    self?.updateModal()
                }
                
                self.modalState = .presenting(item)
                self.present(host, animated: animated) {
                    self.modalState = .presented(item)
                    self.updateModal()
                }
            case .presented(let itemPresented):
                if itemPresented.id != item.id { //if new item, dismiss old
                    self.dismiss(animated: animated)
                }
            default:
                break
            }
            
        } else {
            switch modalState {
            case .presented(let item):
                self.modalState = .dismissing(item)
                self.dismiss(animated: animated)
            default:
                break
            }
        }
    }
}



internal struct ModalController_Item_Representable <Content : View, Item: Identifiable>: UIViewControllerRepresentable {
    
    @Binding private var item: Item?
    private var animated: Bool
    private var contentView: ((Item) -> Content)
    private var transitionStyle: UIModalTransitionStyle
    private var presentationStyle: UIModalPresentationStyle
    private var backgroundColor: Color
    private var onDismiss: (() -> Void)?
    
    init(item: Binding<Item?>, animated: Bool, transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle, backgroundColor: Color, onDismiss: (() -> Void)?, contentView: @escaping ((Item) -> Content)) {
        self._item = item
        self.contentView = contentView
        self.animated = animated
        self.transitionStyle = transitionStyle
        self.presentationStyle = presentationStyle
        self.onDismiss = onDismiss
        self.backgroundColor = backgroundColor
    }
    
    internal func makeUIViewController(context: Context) -> ModalController_Item<Content, Item> {
        return ModalController_Item(item: _item,
                                    animated: animated,
                                    transitionStyle: transitionStyle,
                                    presentationStyle: presentationStyle,
                                    backgroundColor: backgroundColor,
                                    onDismiss: onDismiss,
                                    contentView: contentView
        )
    }
    
    internal func updateUIViewController(_ uiViewController: ModalController_Item<Content, Item>, context: Context) {
        uiViewController.item = _item
        uiViewController.contentView = contentView
        uiViewController.transitionStyle = transitionStyle
        uiViewController.presentationStyle = presentationStyle
        uiViewController.animated = animated
        uiViewController.onDismiss = onDismiss
        uiViewController.backgroundColor = backgroundColor
    }
}
