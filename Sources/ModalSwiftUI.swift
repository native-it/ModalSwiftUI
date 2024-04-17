
import SwiftUI

fileprivate struct BoolItem: Identifiable {
    var id: Bool = true
}

extension View {
    
    fileprivate func convertBinding(isPresented: Binding<Bool>) -> Binding<BoolItem?> {
        return Binding {
            if isPresented.wrappedValue {
                return BoolItem()
            } else {
                return nil
            }
        } set: { item in
            if item == nil {
                isPresented.wrappedValue = false
            } else {
                isPresented.wrappedValue = true
            }
        }
    }
    
    
    public func modal<Content>(isPresented: Binding<Bool>,
                               animated: Bool = true,
                               transitionStyle: UIModalTransitionStyle = .coverVertical,
                               presentationStyle: UIModalPresentationStyle = .automatic,
                               backgroundColor: Color = Color(UIColor.systemBackground),
                               onDismiss: (() -> Void)? = nil,
                               @ViewBuilder content: @escaping () -> Content)
    -> some View where Content : View {
        
        self.background {
            ModalController_Item_Representable(item: convertBinding(isPresented: isPresented),
                                               animated: animated,
                                               transitionStyle: transitionStyle,
                                               presentationStyle: presentationStyle,
                                               backgroundColor: backgroundColor,
                                               onDismiss: onDismiss) { item in
                content()
            }
        }
    }
    
    
    public func modal<Item, Content>(item: Binding<Item?>,
                                     animated: Bool = true,
                                     transitionStyle: UIModalTransitionStyle = .coverVertical,
                                     presentationStyle: UIModalPresentationStyle = .automatic,
                                     backgroundColor: Color = Color(UIColor.systemBackground),
                                     onDismiss: (() -> Void)? = nil,
                                     @ViewBuilder content: @escaping (Item) -> Content)
    -> some View where Item : Identifiable, Content : View {
        self.background {
            ModalController_Item_Representable(item: item,
                                               animated: animated,
                                               transitionStyle: transitionStyle,
                                               presentationStyle: presentationStyle,
                                               backgroundColor: backgroundColor,
                                               onDismiss: onDismiss,
                                               contentView: content)
        }
    }

}
