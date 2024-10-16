//
//  Map.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 16/10/24.
//

import SwiftUI


struct Map: View {
    @State private var tappedPathName: String = ""
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            ZStack {
                Path { path in
                    let width: CGFloat = 600
                    let height: CGFloat = 600
                    
                    path.move(to: CGPoint(x: 0.50498*width, y: 0.30279*height))
                            path.addCurve(to: CGPoint(x: 0.39542*width, y: 0.27689*height), control1: CGPoint(x: 0.47288*width, y: 0.29744*height), control2: CGPoint(x: 0.42961*width, y: 0.26374*height))
                            path.addCurve(to: CGPoint(x: 0.31574*width, y: 0.56175*height), control1: CGPoint(x: 0.33649*width, y: 0.29956*height), control2: CGPoint(x: 0.23855*width, y: 0.52867*height))
                            path.addCurve(to: CGPoint(x: 0.58865*width, y: 0.53187*height), control1: CGPoint(x: 0.41179*width, y: 0.60292*height), control2: CGPoint(x: 0.49753*width, y: 0.57092*height))
                            path.addCurve(to: CGPoint(x: 0.64243*width, y: 0.41833*height), control1: CGPoint(x: 0.61783*width, y: 0.51937*height), control2: CGPoint(x: 0.66585*width, y: 0.45346*height))
                            path.addCurve(to: CGPoint(x: 0.50697*width, y: 0.30279*height), control1: CGPoint(x: 0.61622*width, y: 0.37901*height), control2: CGPoint(x: 0.54694*width, y: 0.33276*height))
                            
                }
                .fill(Color.blue)
                .onTapGesture {
                    tappedPathName = "Path 1"
                }
                Text("Hola")
                    .offset(y: 40)

                
                Path { path in
                    let width: CGFloat = 600
                    let height: CGFloat = 600
                    
                    path.move(to: CGPoint(x: 0.46514*width, y: 0.41633*height))
                            path.addCurve(to: CGPoint(x: 0.40139*width, y: 0.43626*height), control1: CGPoint(x: 0.45669*width, y: 0.37408*height), control2: CGPoint(x: 0.39804*width, y: 0.39271*height))
                            path.addCurve(to: CGPoint(x: 0.46315*width, y: 0.41833*height), control1: CGPoint(x: 0.40701*width, y: 0.50924*height), control2: CGPoint(x: 0.46315*width, y: 0.50253*height))
                            
                            
                }
                .fill(Color.green)
                .onTapGesture {
                    tappedPathName = "Path 2"
                }

                
            }
            .offset(offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        self.offset = CGSize(
                            width: self.lastOffset.width + value.translation.width,
                            height: self.lastOffset.height + value.translation.height
                        )
                    }
                    .onEnded { _ in
                        self.lastOffset = self.offset
                    }
            )
            
            Text("Tapped Path: \(tappedPathName)")
                .font(.headline)
                .padding()
            
 
            Text("Offset: (x: \(String(format: "%.2f", offset.width)), y: \(String(format: "%.2f", offset.height)))")
                .font(.subheadline)
        }
    }
}


#Preview {
    Map()
        .frame(width: 600, height: 600)
}
