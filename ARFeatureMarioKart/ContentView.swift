//
//  ContentView.swift
//  ARFeatureOutdoorRace
//
//  Created by Luca Bulles on 11/05/2023.
//@State private var showInfoOverlay = false

import SwiftUI
import RealityKit
import Dispatch

struct ContentView: View {
    @State private var showMessage = true
    @State private var showInfoOverlay = false
    
    var body: some View {
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .top) { // Set alignment to .top
                    Image("Avatar")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.top, 50) // Add top padding
                        .padding(.leading, 16) // Add leading padding
                        .alignmentGuide(.top) { _ in 0 } // Align to top
                    
                    Spacer()
                    
                    Image("Track")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.top, 50) // Add top padding
                        .padding(.trailing, 16) // Add trailing padding
                        .alignmentGuide(.top) { _ in 0 } // Align to top
                }
                Spacer()
            }
            
            if showMessage {
                Text("Move your phone to scan the room, placement of objects can take a moment.")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                showMessage = false
                            }
                        }
                    }
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    showInfoOverlay.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(
            Group {
                if showInfoOverlay {
                    Color.black.opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                Text("About the app")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 20)
                                
                                Text("AR object placement:\n")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .bold()
                                
                                Text("The AR objects are placed as a parkour, collect as much as possible objects and reach the finish line!\n")
                                    .font(.body)
                                    .foregroundColor(.white)
                                
                                Text(" To optimize object loading speed, consider the following factors:\n")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .bold()
                                
                                Text("-Use an open space without nearby real world objects \n\n -Move your camera around and keep it still for a few times.")
                                    .font(.body)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    showInfoOverlay = false
                                }) {
                                    Text("Close")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                            }
                            .padding()
                        )
                }
            }
        )
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let boxAnchor = try! Experience.loadBox()
        arView.scene.anchors.append(boxAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

