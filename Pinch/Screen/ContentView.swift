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

