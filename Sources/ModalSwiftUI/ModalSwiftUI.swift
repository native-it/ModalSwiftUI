
import SwiftUI

extension View {
    
    public func modal<Content>(isPresented: Binding<Bool>,
                               animated: Bool = true,
                               transitionStyle: UIModalTransitionStyle = .coverVertical,
                               presentationStyle: UIModalPresentationStyle = .automatic,
                               backgroundColor: Color = Color(UIColor.systemBackground),
                               onDismiss: (() -> Void)? = nil,
                               @ViewBuilder content: @escaping () -> Content)
    -> some View where Content : View {
        
        self.background {
            ModalController_Bool_Representable(isPresented: isPresented,
                                               animated: animated,
                                               transitionStyle: transitionStyle,
                                               presentationStyle: presentationStyle,
                                               backgroundColor: backgroundColor,
                                               onDismiss: onDismiss,
                                               contentView: content)
        }
    }
}
