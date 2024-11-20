//
//  CodeView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 29/10/24.
//

import SwiftUI
import VisionKit

struct CodeView: View {
    @State var isShowingScanner = true
    @State private var scannedText = ""
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack {
            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                ZStack(alignment: .bottom) {
                    DataScannerRepresentable(
                        shouldStartScanning: $isShowingScanner,
                        scannedText: $scannedText,
                        dataToScanFor: [.barcode(symbologies: [.qr])],
                        userManager: userManager
                    )
                    
                    Text(scannedText)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                }
            } else if !DataScannerViewController.isSupported {
                Text("Tu dispositivo no es compatible")
            } else {
                Text("Tu cámara no está disponible")
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CodeView().environmentObject(UserManager())
}
