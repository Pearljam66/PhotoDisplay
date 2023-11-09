//
//  EnhancedView.swift
//  PhotoDisplay
//
//  Created by Sarah Clark on 11/8/23.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher( for: UIDevice.orientationDidChangeNotification)) {_ in
            action(UIDevice.current.orientation)
        }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct EnhancedView: View {
    @Binding var imageFile: String
    @Binding var imageName: String
    @Binding var imageDate: String
    @Binding var imageDescription: String

    @State private var orientation = UIDeviceOrientation.unknown

    let screenSize: CGRect = UIScreen.main.bounds

    var body: some View {
        Group {
            if (orientation.isLandscape) {
                LazyHStack {
                    VStack {
                        Image(imageFile)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: screenSize.width * 0.5)

                    VStack {
                        Text(imageName)
                            .fontWeight(.bold)
                        Text(imageDate)

                        Text(imageDescription)
                    }
                    .frame(width: screenSize.width * 0.5)
                }
            } else {
                LazyVStack {
                    VStack {
                        Image(imageFile)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: screenSize.height * 0.5)

                    VStack {
                        Text(imageName)
                            .fontWeight( .bold )
                        Text(imageDate)

                        Text(imageDescription)
                    }
                    .frame(height: screenSize.height * 0.5)
                }
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }

}
#Preview {
    EnhancedView(imageFile: .constant("One"), imageName: .constant("One"), imageDate: .constant("09/11/2023"), imageDescription:.constant("Blah blah blah"))
}
