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
                            .font(.title)
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
                            .font(.largeTitle)
                            .fontWeight(.bold )
                            .padding(5)
                        Text(imageDate)
                            .padding(10)
                            .font(.title)

                        Text(imageDescription)
                            .padding(.horizontal, 20)
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
    EnhancedView(imageFile: .constant("Five"), imageName: .constant("Orko the puppito"), imageDate: .constant("10/10/2023"), imageDescription:.constant("Meet Orko, the lively and lovable pup with a heart full of joy! With his fluffy fur and playful demeanor, Orko brings boundless energy to every moment. Whether murdering his favorite squeaky toy or doing the potty dance, this furry friend is a constant source of happiness. His wagging tail and floppy ears are a testament to the pure delight he finds in the simple pleasures of life. Join Orko on his adventures, and let his infectious enthusiasm brighten your day with warmth and companionship."))
}
