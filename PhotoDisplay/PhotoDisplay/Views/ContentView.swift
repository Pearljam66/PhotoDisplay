//
//  ContentView.swift
//  PhotoDisplay
//
//  Created by Sarah Clark on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    private let images: [String] = [
        "five", "five", "five", "five",
        "five", "five", "five", "five",
        "five", "five", "five", "five"
    ]

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 300))
    ]

    @State private var isClicked: Bool = false
    @State private var imageFile: String = ""
    @State private var imageName: String = ""
    @State private var imageDate: String = ""
    @State private var imageDescription: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(images.indices, id: \.self) { i in
                        NavigationLink(destination: EnhancedView(imageFile: $imageFile, imageName: $imageName, imageDate: $imageDate, imageDescription: $imageDescription), isActive: $isClicked, label: {
                            Image(images[i])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 300)
                                .padding(20)
                                .onTapGesture {
                                    imageFile = images[i]
                                    imageName = "Orko the puppito"
                                    imageDate = "10/10/2023"
                                    imageDescription = "Meet Orko, the lively and lovable pup with a heart full of joy! With his fluffy fur and playful demeanor, Orko brings boundless energy to every moment. Whether murdering his favorite squeaky toy or doing the potty dance, this furry friend is a constant source of happiness. His wagging tail and floppy ears are a testament to the pure delight he finds in the simple pleasures of life. Join Orko on his adventures, and let his infectious enthusiasm brighten your day with warmth and companionship."

                                    isClicked = true
                                }
                        })
                    }
                }
                .padding(10)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
