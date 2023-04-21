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
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
    
    // MARK: - FUNCTION
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
        
    }
    
    // MARK: - CONTENT
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear // this solves the issue of moving the info panel to the top of the ZStack
                // MARK: - Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height) // order matters - drag must come first
                    .scaleEffect(imageScale)
                // MARK: - 1. TAP GESTURE
                // count 2 refers to the amount of taps
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5 // scale up if default value is 1
                            }
                        } else { // if image is already scaled up go back to default state
                            resetImageState()
                        }
                    })
                // MARK: - 2. DRAG GESTURE
                    .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in // we do not care about the transtion value we want it to reset
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                    )
                // MARK: - 3. MAGNIFICATION
                    .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        } // End of onChanged
                        .onEnded { _ in // when gesture finished we are ensuring that we are not exceeding values
                            if imageScale > 5 {
                                imageScale = 5
                            } else if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                    )
                
            } // End of Zstack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            // MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            // MARK: - CONTROLS
            .overlay(
                Group {
                    HStack {
                        // SCALE DOWN
                        Button {
                            withAnimation(.spring()) {
                                // main action
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    // safety action to prevent glitches
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // RESET
                        Button {
                           resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button {
                            withAnimation(.spring()) {
                                // main action
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    // safety action to prevent scale going larger than 5
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                    } // End of Controls
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30), alignment: .bottom
            
            )
            // MARK: - DRAWER
            .overlay(
                HStack(spacing: 12) {
                    // MARK: - DRAWER HANDLE
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        })
                    
                    // MARK: - THUMBNAILS
                    Spacer()
                    
                    
                    
                }// End of Drawer
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12) // will grab the device screen size which varies
                    .offset(x: isDrawerOpen ? 20 : 215)
                , alignment: .topTrailing
            )
            
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

