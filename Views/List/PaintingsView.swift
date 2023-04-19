//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/18/23.
//

import SwiftUI

struct PaintingsView: View {
    @ObservedObject private var paintingCollection = PaintingCollection()
    @State private var galleryView: GalleryARViewRepresentable? = nil
    var body: some View {
        NavigationView {
            List {
                if paintingCollection.count != 0 {
                    ForEach(paintingCollection.paintingObjects) { painting in
                        paintingDisplay(painting: painting)
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
        .onAppear {
            galleryView = GalleryARViewRepresentable(paintingCollection: paintingCollection)
        }
    }
    
    private func paintingDisplay(painting: PaintingModel) -> some View {
        NavigationLink("\(painting.title)") {
            SinglePaintingView(painting: painting)
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
            CanvasView()
                .environmentObject(paintingCollection)
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Draw Painting")
            }
        }
    }
    
    private func galleryNavLink() -> some View {
        NavigationLink {
            galleryView
                .onAppear {
                    galleryView?.appeared()
                }
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
