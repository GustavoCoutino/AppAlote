//
//  DataScannerRepresentable.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/10/24.
//

import SwiftUI
import VisionKit

struct DataScannerRepresentable: UIViewControllerRepresentable {
    @Binding var shouldStartScanning: Bool
    @Binding var scannedText: String
    var dataToScanFor: Set<DataScannerViewController.RecognizedDataType>
    var userManager: UserManager
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
       var parent: DataScannerRepresentable
       
       init(_ parent: DataScannerRepresentable) {
           self.parent = parent
       }
               
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd items: [RecognizedItem], allItems: [RecognizedItem]) {
            guard let item = items.first else { return }
            
            switch item {
            case .text(let text):
                parent.scannedText = text.transcript
            case .barcode(let barcode):
                if let urlString = barcode.payloadStringValue {
                    parent.scannedText = urlString
                    if let url = URL(string: urlString) {
                        parent.userManager.handleURL(url)
                    }
                } else {
                    parent.scannedText = "Unable to decode the scanned code"
                }
            default:
                print("unexpected item")
            }
        }
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let dataScannerVC = DataScannerViewController(
            recognizedDataTypes: dataToScanFor,
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        
        dataScannerVC.delegate = context.coordinator
       
       return dataScannerVC
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
       if shouldStartScanning {
           try? uiViewController.startScanning()
       } else {
           uiViewController.stopScanning()
       }
    }

    func makeCoordinator() -> Coordinator {
       Coordinator(self)
    }
}
