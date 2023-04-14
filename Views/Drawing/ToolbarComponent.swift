//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 4/14/23.
//

import SwiftUI

struct ToolbarComponent: View {
    @StateObject var drawingViewModel = DrawingViewModel()
    var body: some View {
        VStack {
            ColorPicker("Color", selection: $drawingViewModel.drawingModel.color)

            // markup section
            HStack {
                tool(image: "pencil", tool: .pencil, label: "Pencil")
                tool(image: "highlighter", tool: .marker, label: "Marker")
                tool(image: "paintbrush", tool: .pen, label: "Pen")
            }

            // eraser section
            VStack {
                eraserTool(image: "circle", tool: .bitmap, label: "Bitmap Eraser")
                eraserTool(image: "eraser", tool: .vector, label: "Vector Eraser")
            }

            // clear section
            clearButton()
        }
    }
}
