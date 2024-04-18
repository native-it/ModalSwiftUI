# ModalSwiftUI

Small library that enables _UIKit-like_ modal transition and presentation of SwiftUI views.


## What do you mean?

Currently, SwiftUI has the ability to display a custom modal view using the `.sheet` and `.fullScreenCover` modifiers, but with limited customization options. Several key shortcomings exist in SwiftUI's modal approach:

❌ It's not possible to change the transition appearance (animation)

❌ There's no elegant way to disable animation

❌ Achieving a transparent background to reveal the parent view underneath is not feasible

❌ A true fullscreen mode that causes the parent view to disappear doesn't exist

## How does this work?

By using UIViewControllerRepresentable and UIHostingController, it's possible to achieve UIKit behavior within SwiftUI views. 

<img src="https://github.com/native-it/ModalSwiftUI/blob/main/demo.gif" width="400">

## How to use it?

The functions for presenting a modal view are similar to the current `.sheet` and `.fullScreenCover` functions, just with additional parameters that enable customization.

```swift
//SwiftUI way
.fullScreenCover(isPresented: $showingModal) {
  ModalView()
}

//ModalSwiftUI way
.modal(isPresented: $showingModal,
        animated: true,
        transitionStyle: .crossDissolve,
        presentationStyle: .overFullScreen,
        backgroundColor: .clear) {
  ModalView()
}
```

You can find more examples in Demo project.

## Installation

### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add https://github.com/native-it/ModalSwiftUI
- Select "Up to Next Major" with "1.0.0"

## License
ModalSwiftUI is released under the MIT license.





