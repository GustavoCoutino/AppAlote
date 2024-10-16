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
                
                // BACKGROUND
                Path { path in
                    let width: CGFloat = 1000
                    let height: CGFloat = 1000
                    path.move(to: CGPoint(x: 0, y: 0.07822*height))
                    path.addLine(to: CGPoint(x: 0, y: 0.37779*height))
                    path.addLine(to: CGPoint(x: 0.03722*width, y: 0.37752*height))
                    path.addLine(to: CGPoint(x: 0.03722*width, y: 0.38767*height))
                    path.addLine(to: CGPoint(x: 0.05034*width, y: 0.38741*height))
                    path.addLine(to: CGPoint(x: 0.05025*width, y: 0.37707*height))
                    path.addLine(to: CGPoint(x: 0.09445*width, y: 0.37707*height))
                    path.addLine(to: CGPoint(x: 0.09463*width, y: 0.38678*height))
                    path.addLine(to: CGPoint(x: 0.10298*width, y: 0.3866*height))
                    path.addLine(to: CGPoint(x: 0.10298*width, y: 0.37707*height))
                    path.addLine(to: CGPoint(x: 0.13907*width, y: 0.37689*height))
                    path.addLine(to: CGPoint(x: 0.13907*width, y: 0.38013*height))
                    path.addLine(to: CGPoint(x: 0.1474*width, y: 0.37987*height))
                    path.addLine(to: CGPoint(x: 0.14734*width, y: 0.37689*height))
                    path.addLine(to: CGPoint(x: 0.1602*width, y: 0.37689*height))
                    path.addLine(to: CGPoint(x: 0.56024*width, y: 0.93621*height))
                    path.addCurve(to: CGPoint(x: 0.58241*width, y: 0.94896*height), control1: CGPoint(x: 0.5638*width, y: 0.94173*height), control2: CGPoint(x: 0.57519*width, y: 0.94757*height))
                    path.addLine(to: CGPoint(x: 0.74682*width, y: 0.94896*height))
                    path.addCurve(to: CGPoint(x: 0.76504*width, y: 0.94146*height), control1: CGPoint(x: 0.75257*width, y: 0.94777*height), control2: CGPoint(x: 0.76182*width, y: 0.94484*height))
                    path.addCurve(to: CGPoint(x: 0.7725*width, y: 0.9335*height), control1: CGPoint(x: 0.76712*width, y: 0.9396*height), control2: CGPoint(x: 0.77085*width, y: 0.93561*height))
                    path.addLine(to: CGPoint(x: 0.86637*width, y: 0.74373*height))
                    path.addLine(to: CGPoint(x: 0.97266*width, y: 0.68535*height))
                    path.addLine(to: CGPoint(x: 0.98311*width, y: 0.67425*height))
                    path.addCurve(to: CGPoint(x: 0.98833*width, y: 0.65314*height), control1: CGPoint(x: 0.98595*width, y: 0.66919*height), control2: CGPoint(x: 0.98903*width, y: 0.65891*height))
                    path.addLine(to: CGPoint(x: 0.96182*width, y: 0.48075*height))
                    path.addCurve(to: CGPoint(x: 0.94512*width, y: 0.46509*height), control1: CGPoint(x: 0.9585*width, y: 0.47504*height), control2: CGPoint(x: 0.95098*width, y: 0.46658*height))
                    path.addLine(to: CGPoint(x: 0.60466*width, y: 0.39729*height))
                    path.addLine(to: CGPoint(x: 0.60486*width, y: 0.10918*height))
                    path.addLine(to: CGPoint(x: 0.55083*width, y: 0.10918*height))
                    path.addLine(to: CGPoint(x: 0.55083*width, y: 0.14039*height))
                    path.addCurve(to: CGPoint(x: 0.54616*width, y: 0.14579*height), control1: CGPoint(x: 0.55062*width, y: 0.14271*height), control2: CGPoint(x: 0.54814*width, y: 0.14524*height))
                    path.addLine(to: CGPoint(x: 0.32501*width, y: 0.22969*height))
                    path.addLine(to: CGPoint(x: 0.21686*width, y: 0.07822*height))
                    path.addLine(to: CGPoint(x: 0.14734*width, y: 0.07822*height))
                    path.addLine(to: CGPoint(x: 0.14734*width, y: 0.07508*height))
                    path.addLine(to: CGPoint(x: 0.13907*width, y: 0.07508*height))
                    path.addLine(to: CGPoint(x: 0.13907*width, y: 0.07782*height))
                    path.addLine(to: CGPoint(x: 0.10298*width, y: 0.07822*height))
                    path.addLine(to: CGPoint(x: 0.10298*width, y: 0.06868*height))
                    path.addLine(to: CGPoint(x: 0.09445*width, y: 0.06868*height))
                    path.addLine(to: CGPoint(x: 0.09445*width, y: 0.07812*height))
                    path.addLine(to: CGPoint(x: 0.05034*width, y: 0.07751*height))
                    path.addLine(to: CGPoint(x: 0.05025*width, y: 0.06777*height))
                    path.addLine(to: CGPoint(x: 0.03722*width, y: 0.06777*height))
                    path.addLine(to: CGPoint(x: 0.03722*width, y: 0.07782*height))
                    path.addLine(to: CGPoint(x: 0, y: 0.07822*height))
                            
                }
                .fill(Color.gray)
                .onTapGesture {
                    tappedPathName = "Path 1"
                }
                
                // IMAX
                Path { path in
                    let width: CGFloat = 1000
                    let height: CGFloat = 1000
                    path.move(to: CGPoint(x: 0.00579*width, y: 0.08299*height))
                    path.addLine(to: CGPoint(x: 0.21474*width, y: 0.08299*height))
                    path.addLine(to: CGPoint(x: 0.34668*width, y: 0.2682*height))
                    path.addLine(to: CGPoint(x: 0.2147*width, y: 0.31849*height))
                    path.addCurve(to: CGPoint(x: 0.20183*width, y: 0.34455*height), control1: CGPoint(x: 0.20944*width, y: 0.32324*height), control2: CGPoint(x: 0.20314*width, y: 0.33638*height))
                    path.addLine(to: CGPoint(x: 0.20183*width, y: 0.37217*height))
                    path.addLine(to: CGPoint(x: 0.00579*width, y: 0.37238*height))
                    path.addLine(to: CGPoint(x: 0.00579*width, y: 0.08299*height))
                            
                           
                }
                .fill(Color.black)
                .onTapGesture {
                    tappedPathName = "IMAX"
                }
                
                
                // COMPRENDO
                Path { path in
                    let width: CGFloat = 1000
                    let height: CGFloat = 1000
                    path.move(to: CGPoint(x: 0.3757*width, y: 0.30048*height))
                    path.addLine(to: CGPoint(x: 0.55743*width, y: 0.23124*height))
                    path.addLine(to: CGPoint(x: 0.56563*width, y: 0.22304*height))
                    path.addLine(to: CGPoint(x: 0.56446*width, y: 0.18514*height))
                    path.addLine(to: CGPoint(x: 0.59993*width, y: 0.18424*height))
                    path.addLine(to: CGPoint(x: 0.59819*width, y: 0.42482*height))
                    path.addLine(to: CGPoint(x: 0.61567*width, y: 0.44206*height))
                    path.addLine(to: CGPoint(x: 0.66361*width, y: 0.45159*height))
                    path.addLine(to: CGPoint(x: 0.6664*width, y: 0.53268*height))
                    path.addLine(to: CGPoint(x: 0.59047*width, y: 0.55461*height))
                    path.addLine(to: CGPoint(x: 0.55357*width, y: 0.55201*height))
                    path.addLine(to: CGPoint(x: 0.3757*width, y: 0.30048*height))
                }
                .fill(Color.purple)
                .onTapGesture {
                    tappedPathName = "Comprendo"
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
        }
    }
}


#Preview {
    Map()
        .frame(width: 1000, height: 1000)
}
