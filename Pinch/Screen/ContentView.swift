//
//  ContentView.swift
//  Pinch
//
//  Created by Jared Infantino on 2023-04-21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    
    // MARK: - FUNCTION
    
    // MARK: - CONTENT
    var body: some View {
        NavigationView {
            ZStack {
                // MAK: - Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                // MARK: - 1. TAP GESTURE
                // count 2 refers to the amount of taps
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5 // scale up if default value is 1
                            }
                        } else { // if image is already scaled up go back to default state
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    })
                
            } // End of Zstack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
        } // End of NavView
        .navigationViewStyle(.stack)
    }
}
        // MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

