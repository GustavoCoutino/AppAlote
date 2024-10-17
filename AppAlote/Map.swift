//
//  Map.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 16/10/24.
//

import SwiftUI


struct Map: View {
    @State var floor = 1
    @State var showSheet = false
    @State var tappedPathName: String = ""
    @State var offset: CGSize = .zero
    @State var lastOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            ZStack {
                if floor == 1{
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
                    .fill(Color.white)
                    .onTapGesture {
                        tappedPathName = "IMAX"
                        showSheet = true
                    }
                    
                    
                    // COMPRENDO
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.3757*width, y: 0.30048*height))
                        path.addLine(to: CGPoint(x: 0.55743*width, y: 0.23124*height))
                        path.addCurve(to: CGPoint(x: 0.56563*width, y: 0.22304*height), control1: CGPoint(x: 0.56052*width, y: 0.22979*height), control2: CGPoint(x: 0.56497*width, y: 0.22613*height))
                        path.addLine(to: CGPoint(x: 0.56446*width, y: 0.18514*height))
                        path.addLine(to: CGPoint(x: 0.59993*width, y: 0.18424*height))
                        path.addLine(to: CGPoint(x: 0.59819*width, y: 0.42482*height))
                        path.addCurve(to: CGPoint(x: 0.61567*width, y: 0.44206*height), control1: CGPoint(x: 0.59966*width, y: 0.43194*height), control2: CGPoint(x: 0.60873*width, y: 0.44019*height))
                        path.addLine(to: CGPoint(x: 0.66361*width, y: 0.45159*height))
                        path.addLine(to: CGPoint(x: 0.6664*width, y: 0.53268*height))
                        path.addLine(to: CGPoint(x: 0.59047*width, y: 0.55461*height))
                        path.addLine(to: CGPoint(x: 0.55357*width, y: 0.55201*height))
                        path.addLine(to: CGPoint(x: 0.3757*width, y: 0.30048*height))
                                
                    }
                    .fill(Color.purple)
                    .onTapGesture {
                        tappedPathName = "Comprendo"
                        showSheet = true
                    }
                    
                    // EXPRESO
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.66361*width, y: 0.45159*height))
                        path.addLine(to: CGPoint(x: 0.83257*width, y: 0.48391*height))
                        path.addCurve(to: CGPoint(x: 0.85556*width, y: 0.46952*height), control1: CGPoint(x: 0.83562*width, y: 0.47445*height), control2: CGPoint(x: 0.84732*width, y: 0.46774*height))
                        path.addLine(to: CGPoint(x: 0.93642*width, y: 0.48611*height))
                        path.addCurve(to: CGPoint(x: 0.95089*width, y: 0.50187*height), control1: CGPoint(x: 0.94309*width, y: 0.48767*height), control2: CGPoint(x: 0.94936*width, y: 0.49607*height))
                        path.addLine(to: CGPoint(x: 0.97413*width, y: 0.65314*height))
                        path.addCurve(to: CGPoint(x: 0.9675*width, y: 0.67159*height), control1: CGPoint(x: 0.97519*width, y: 0.6593*height), control2: CGPoint(x: 0.97116*width, y: 0.66792*height))
                        path.addLine(to: CGPoint(x: 0.9649*width, y: 0.67425*height))
                        path.addLine(to: CGPoint(x: 0.89222*width, y: 0.71337*height))
                        path.addLine(to: CGPoint(x: 0.86289*width, y: 0.66215*height))
                        path.addLine(to: CGPoint(x: 0.88266*width, y: 0.65101*height))
                        path.addCurve(to: CGPoint(x: 0.89694*width, y: 0.61519*height), control1: CGPoint(x: 0.88912*width, y: 0.64669*height), control2: CGPoint(x: 0.89699*width, y: 0.63083*height))
                        path.addCurve(to: CGPoint(x: 0.86637*width, y: 0.57521*height), control1: CGPoint(x: 0.89774*width, y: 0.59552*height), control2: CGPoint(x: 0.88375*width, y: 0.57661*height))
                        path.addCurve(to: CGPoint(x: 0.83257*width, y: 0.59999*height), control1: CGPoint(x: 0.85261*width, y: 0.57248*height), control2: CGPoint(x: 0.83893*width, y: 0.58824*height))
                        path.addCurve(to: CGPoint(x: 0.76504*width, y: 0.63337*height), control1: CGPoint(x: 0.8235*width, y: 0.61696*height), control2: CGPoint(x: 0.78899*width, y: 0.6327*height))
                        path.addCurve(to: CGPoint(x: 0.68221*width, y: 0.6164*height), control1: CGPoint(x: 0.74564*width, y: 0.63235*height), control2: CGPoint(x: 0.70461*width, y: 0.6231*height))
                        path.addLine(to: CGPoint(x: 0.65905*width, y: 0.61329*height))
                        path.addLine(to: CGPoint(x: 0.57124*width, y: 0.61564*height))
                        path.addLine(to: CGPoint(x: 0.55357*width, y: 0.55201*height))
                        path.addLine(to: CGPoint(x: 0.59047*width, y: 0.5547*height))
                        path.addLine(to: CGPoint(x: 0.6664*width, y: 0.53268*height))
                        path.addLine(to: CGPoint(x: 0.66361*width, y: 0.45159*height))
                    }
                    .fill(Color.orange)
                    .onTapGesture {
                        tappedPathName = "Expreso"
                        showSheet = true
                    }
                    
                    
                    // PEQUEÑOS
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.76876*width, y: 0.90089*height))
                        path.addLine(to: CGPoint(x: 0.75629*width, y: 0.83365*height))
                        path.addLine(to: CGPoint(x: 0.72458*width, y: 0.77699*height))
                        path.addLine(to: CGPoint(x: 0.70865*width, y: 0.74718*height))
                        path.addLine(to: CGPoint(x: 0.86289*width, y: 0.66215*height))
                        path.addLine(to: CGPoint(x: 0.89222*width, y: 0.71337*height))
                        path.addLine(to: CGPoint(x: 0.83898*width, y: 0.74244*height))
                        path.addCurve(to: CGPoint(x: 0.83257*width, y: 0.75092*height), control1: CGPoint(x: 0.83656*width, y: 0.74409*height), control2: CGPoint(x: 0.83339*width, y: 0.74835*height))
                        path.addLine(to: CGPoint(x: 0.82005*width, y: 0.77699*height))
                        path.addLine(to: CGPoint(x: 0.82268*width, y: 0.79866*height))
                        path.addLine(to: CGPoint(x: 0.77566*width, y: 0.8952*height))
                        path.addCurve(to: CGPoint(x: 0.76876*width, y: 0.90089*height), control1: CGPoint(x: 0.77354*width, y: 0.89792*height), control2: CGPoint(x: 0.77082*width, y: 0.90157*height))
                    }
                    .fill(Color.blue)
                    .onTapGesture {
                        tappedPathName = "Pequeños"
                        showSheet = true
                    }
                    
                    // SOY
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.76876*width, y: 0.90085*height))
                        path.addCurve(to: CGPoint(x: 0.74271*width, y: 0.90948*height), control1: CGPoint(x: 0.76566*width, y: 0.90625*height), control2: CGPoint(x: 0.75299*width, y: 0.9104*height))
                        path.addLine(to: CGPoint(x: 0.57354*width, y: 0.90906*height))
                        path.addCurve(to: CGPoint(x: 0.55309*width, y: 0.90078*height), control1: CGPoint(x: 0.56387*width, y: 0.90917*height), control2: CGPoint(x: 0.55723*width, y: 0.90415*height))
                        path.addLine(to: CGPoint(x: 0.3793*width, y: 0.65741*height))
                        path.addLine(to: CGPoint(x: 0.43287*width, y: 0.55201*height))
                        path.addCurve(to: CGPoint(x: 0.44381*width, y: 0.54195*height), control1: CGPoint(x: 0.4384*width, y: 0.54336*height), control2: CGPoint(x: 0.44242*width, y: 0.54289*height))
                        path.addCurve(to: CGPoint(x: 0.52477*width, y: 0.5608*height), control1: CGPoint(x: 0.4452*width, y: 0.54101*height), control2: CGPoint(x: 0.47234*width, y: 0.54667*height))
                        path.addLine(to: CGPoint(x: 0.54696*width, y: 0.5547*height))
                        path.addLine(to: CGPoint(x: 0.55309*width, y: 0.55201*height))
                        path.addLine(to: CGPoint(x: 0.57124*width, y: 0.61564*height))
                        path.addCurve(to: CGPoint(x: 0.55309*width, y: 0.68309*height), control1: CGPoint(x: 0.5396*width, y: 0.62358*height), control2: CGPoint(x: 0.52727*width, y: 0.65614*height))
                        path.addLine(to: CGPoint(x: 0.64898*width, y: 0.73922*height))
                        path.addCurve(to: CGPoint(x: 0.70865*width, y: 0.74706*height), control1: CGPoint(x: 0.66346*width, y: 0.74462*height), control2: CGPoint(x: 0.69329*width, y: 0.74858*height))
                        path.addLine(to: CGPoint(x: 0.75629*width, y: 0.83354*height))
                        path.addLine(to: CGPoint(x: 0.76876*width, y: 0.90085*height))
                            
                    }
                    .fill(Color.red)
                    .onTapGesture {
                        tappedPathName = "Soy"
                        showSheet = true
                    }
                }
                else {
                    
                    // BACKGROUND
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.12822*width, y: 0.08963*height))
                        path.addLine(to: CGPoint(x: 0.17047*width, y: 0.29118*height))
                        path.addLine(to: CGPoint(x: 0.14969*width, y: 0.33205*height))
                        path.addLine(to: CGPoint(x: 0.14969*width, y: 0.3833*height))
                        path.addLine(to: CGPoint(x: 0.08319*width, y: 0.38329*height))
                        path.addLine(to: CGPoint(x: 0.08228*width, y: 0.58444*height))
                        path.addLine(to: CGPoint(x: 0.31052*width, y: 0.58442*height))
                        path.addLine(to: CGPoint(x: 0.56475*width, y: 0.94072*height))
                        path.addCurve(to: CGPoint(x: 0.58471*width, y: 0.95237*height), control1: CGPoint(x: 0.56852*width, y: 0.94534*height), control2: CGPoint(x: 0.5784*width, y: 0.95128*height))
                        path.addLine(to: CGPoint(x: 0.74939*width, y: 0.95181*height))
                        path.addCurve(to: CGPoint(x: 0.77323*width, y: 0.93629*height), control1: CGPoint(x: 0.75771*width, y: 0.95213*height), control2: CGPoint(x: 0.76922*width, y: 0.94377*height))
                        path.addLine(to: CGPoint(x: 0.86527*width, y: 0.74832*height))
                        path.addLine(to: CGPoint(x: 0.96906*width, y: 0.69102*height))
                        path.addCurve(to: CGPoint(x: 0.98506*width, y: 0.64423*height), control1: CGPoint(x: 0.98226*width, y: 0.68607*height), control2: CGPoint(x: 0.98907*width, y: 0.66095*height))
                        path.addLine(to: CGPoint(x: 0.95993*width, y: 0.48921*height))
                        path.addLine(to: CGPoint(x: 0.9512*width, y: 0.47766*height))
                        path.addLine(to: CGPoint(x: 0.6043*width, y: 0.40601*height))
                        path.addLine(to: CGPoint(x: 0.60365*width, y: 0.08963*height))
                        path.addLine(to: CGPoint(x: 0.12822*width, y: 0.08963*height))
                    }
                    .fill(Color.gray)
                    
                    // PERTENEZCO
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.43279*width, y: 0.38329*height))
                        path.addLine(to: CGPoint(x: 0.56475*width, y: 0.35071*height))
                        path.addLine(to: CGPoint(x: 0.6043*width, y: 0.34909*height))
                        path.addLine(to: CGPoint(x: 0.6043*width, y: 0.40601*height))
                        path.addCurve(to: CGPoint(x: 0.62887*width, y: 0.45068*height), control1: CGPoint(x: 0.60357*width, y: 0.42221*height), control2: CGPoint(x: 0.60749*width, y: 0.44666*height))
                        path.addLine(to: CGPoint(x: 0.83336*width, y: 0.48921*height))
                        path.addLine(to: CGPoint(x: 0.84554*width, y: 0.47766*height))
                        path.addCurve(to: CGPoint(x: 0.86344*width, y: 0.47766*height), control1: CGPoint(x: 0.8499*width, y: 0.47615*height), control2: CGPoint(x: 0.85881*width, y: 0.47595*height))
                        path.addLine(to: CGPoint(x: 0.93574*width, y: 0.49308*height))
                        path.addLine(to: CGPoint(x: 0.94901*width, y: 0.50817*height))
                        path.addLine(to: CGPoint(x: 0.97285*width, y: 0.66087*height))
                        path.addCurve(to: CGPoint(x: 0.96328*width, y: 0.67878*height), control1: CGPoint(x: 0.97432*width, y: 0.6677*height), control2: CGPoint(x: 0.96807*width, y: 0.67518*height))
                        path.addLine(to: CGPoint(x: 0.88636*width, y: 0.72146*height))
                        path.addLine(to: CGPoint(x: 0.87114*width, y: 0.69264*height))
                        path.addLine(to: CGPoint(x: 0.91195*width, y: 0.66981*height))
                        path.addCurve(to: CGPoint(x: 0.92405*width, y: 0.64125*height), control1: CGPoint(x: 0.91895*width, y: 0.66369*height), control2: CGPoint(x: 0.92611*width, y: 0.64995*height))
                        path.addLine(to: CGPoint(x: 0.90897*width, y: 0.54345*height))
                        path.addCurve(to: CGPoint(x: 0.89405*width, y: 0.53234*height), control1: CGPoint(x: 0.90723*width, y: 0.53878*height), control2: CGPoint(x: 0.8997*width, y: 0.5333*height))
                        path.addLine(to: CGPoint(x: 0.84971*width, y: 0.53919*height))
                        path.addCurve(to: CGPoint(x: 0.84158*width, y: 0.54703*height), control1: CGPoint(x: 0.84654*width, y: 0.54001*height), control2: CGPoint(x: 0.84283*width, y: 0.54417*height))
                        path.addLine(to: CGPoint(x: 0.81519*width, y: 0.59306*height))
                        path.addCurve(to: CGPoint(x: 0.73248*width, y: 0.59283*height), control1: CGPoint(x: 0.80018*width, y: 0.6167*height), control2: CGPoint(x: 0.75872*width, y: 0.61612*height))
                        path.addLine(to: CGPoint(x: 0.68754*width, y: 0.56691*height))
                        path.addCurve(to: CGPoint(x: 0.65035*width, y: 0.56364*height), control1: CGPoint(x: 0.67708*width, y: 0.55998*height), control2: CGPoint(x: 0.6596*width, y: 0.56077*height))
                        path.addLine(to: CGPoint(x: 0.50136*width, y: 0.61548*height))
                        path.addCurve(to: CGPoint(x: 0.49003*width, y: 0.62438*height), control1: CGPoint(x: 0.49754*width, y: 0.6173*height), control2: CGPoint(x: 0.49172*width, y: 0.62164*height))
                        path.addLine(to: CGPoint(x: 0.46464*width, y: 0.55329*height))
                        path.addLine(to: CGPoint(x: 0.52379*width, y: 0.53671*height))
                        path.addCurve(to: CGPoint(x: 0.52532*width, y: 0.52252*height), control1: CGPoint(x: 0.52821*width, y: 0.53477*height), control2: CGPoint(x: 0.52991*width, y: 0.52812*height))
                        path.addLine(to: CGPoint(x: 0.43279*width, y: 0.38329*height))
                                
                                
                    }
                    .fill(Color.green)
                    .onTapGesture {
                        tappedPathName = "Pertenezco"
                        showSheet = true
                    }
                    
                    // PEQUEÑOS
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.83297*width, y: 0.75397*height))
                        path.addLine(to: CGPoint(x: 0.74575*width, y: 0.79817*height))
                        path.addCurve(to: CGPoint(x: 0.713*width, y: 0.80972*height), control1: CGPoint(x: 0.74026*width, y: 0.80658*height), control2: CGPoint(x: 0.72371*width, y: 0.81197*height))
                        path.addLine(to: CGPoint(x: 0.65681*width, y: 0.80972*height))
                        path.addLine(to: CGPoint(x: 0.68513*width, y: 0.91604*height))
                        path.addLine(to: CGPoint(x: 0.75419*width, y: 0.91478*height))
                        path.addCurve(to: CGPoint(x: 0.78088*width, y: 0.89218*height), control1: CGPoint(x: 0.76407*width, y: 0.91347*height), control2: CGPoint(x: 0.7778*width, y: 0.90278*height))
                        path.addLine(to: CGPoint(x: 0.8242*width, y: 0.80333*height))
                        path.addLine(to: CGPoint(x: 0.82075*width, y: 0.78293*height))
                        path.addLine(to: CGPoint(x: 0.83297*width, y: 0.75397*height))
                                
                                
                    }
                    .fill(Color.white)
                    .onTapGesture {
                        tappedPathName = "Pequeños"
                        showSheet = true
                    }
                    
                    // COMUNICO
                    Path { path in
                        let width: CGFloat = 1000
                        let height: CGFloat = 1000
                        path.move(to: CGPoint(x: 0.36505*width, y: 0.63968*height))
                        path.addLine(to: CGPoint(x: 0.48337*width, y: 0.63667*height))
                        path.addCurve(to: CGPoint(x: 0.48963*width, y: 0.66499*height), control1: CGPoint(x: 0.48022*width, y: 0.65191*height), control2: CGPoint(x: 0.48568*width, y: 0.66045*height))
                        path.addLine(to: CGPoint(x: 0.61151*width, y: 0.80021*height))
                        path.addCurve(to: CGPoint(x: 0.63276*width, y: 0.80972*height), control1: CGPoint(x: 0.61556*width, y: 0.80538*height), control2: CGPoint(x: 0.62627*width, y: 0.80989*height))
                        path.addLine(to: CGPoint(x: 0.65681*width, y: 0.80972*height))
                        path.addLine(to: CGPoint(x: 0.68513*width, y: 0.91478*height))
                        path.addLine(to: CGPoint(x: 0.57616*width, y: 0.91478*height))
                        path.addCurve(to: CGPoint(x: 0.55113*width, y: 0.90077*height), control1: CGPoint(x: 0.56912*width, y: 0.91514*height), control2: CGPoint(x: 0.55656*width, y: 0.90922*height))
                        path.addLine(to: CGPoint(x: 0.36505*width, y: 0.63968*height))
                                
                                
                                
                    }
                    .fill(Color.blue)
                    .onTapGesture {
                        tappedPathName = "Comunico"
                        showSheet = true
                    }
                    
    
                                        
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
            .sheet(isPresented: $showSheet){
                Text(tappedPathName)
            }
        }
    }
}


#Preview {
    Map(floor: 1)
        .frame(width: 1000, height: 1000)
}
