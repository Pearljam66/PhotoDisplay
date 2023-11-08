//
//  ContentView.swift
//  PhotoDisplay
//
//  Created by Sarah Clark on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    private let images: [String] = [
        "one", "two", "three", "four",
        "five", "six", "seven", "eight",
        "nine", "ten", "eleven", "twelve",
        "thirteen", "fourteen", "fifteen", "sixteen"
    ]

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 300))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(images.indices) { i in
                    Image(images[i])
                        .resizable()
                        .frame(width: 200, height: 300)
                        .border(.black)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
