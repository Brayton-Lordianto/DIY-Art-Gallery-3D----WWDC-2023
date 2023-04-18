//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import SwiftUI

struct PaintingsView: View {
    @StateObject private var paintingCollection = PaintingCollection()
    @StateObject private var drawingViewModel = DrawingViewModel()
    var body: some View {
        NavigationView {
            List {
                if paintingCollection.count != 0 {
                    ForEach(paintingCollection.paintingObjects) { painting in
                        Text("\(painting.imageName)")
                    }
                } else {
                    placeholder()
                }
                
                
                Section("add new painting") {
                    newPaintingNavLink()
                }
                .foregroundColor(.blue)
                
                Section("click here to see the gallery") {
                    galleryNavLink()
                }
                .foregroundColor(.blue)
            }
            .listStyle(.sidebar)
            .navigationTitle("Paintings")
        }
    }
    
    private func placeholder() -> some View {
        NavigationLink("NO PAINTINGS YET 🥹") {
            ZStack {
                Color.gray
                Text("Nothing to see here...")
            }
            .ignoresSafeArea()
        }
        .foregroundColor(.red)
    }
    
    private func newPaintingNavLink() -> some View {
        NavigationLink {
            CanvasView(drawingViewModel: drawingViewModel)
                .environmentObject(paintingCollection)
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Draw Painitng")
            }
        }
    }
    
    private func galleryNavLink() -> some View {
        NavigationLink {
            
        } label: {
            Text("3D GALLERY")
        }

    }
}

struct PaintingsView_Previews: PreviewProvider {
    static var previews: some View {
        PaintingsView()
    }
}
