//
//  ContentView.swift
//  ARFeatureOutdoorRace
//
//  Created by Luca Bulles on 11/05/2023.
//

import SwiftUI
import RealityKit
import Dispatch

struct ContentView: View {
    @State private var showMessage = true
    
    var body: some View {
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Image("Avatar")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                    
                    Spacer()
                    
                    Image("Track")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
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
        }
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
