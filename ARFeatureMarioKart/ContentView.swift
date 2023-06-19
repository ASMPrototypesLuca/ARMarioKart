//
//  ContentView.swift
//  ARFeatureOutdoorRace
//
//  Created by Luca Bulles on 11/05/2023.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
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
