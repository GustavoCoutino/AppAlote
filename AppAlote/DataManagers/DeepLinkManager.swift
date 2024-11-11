//
//  DeepLinkManager.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/10/24.
//

import Foundation

class DeepLinkManager: ObservableObject {
    @Published var currentDeepLink: String?
    
    func handleURL(_ url: URL) {
        guard url.scheme == "AppAlote" else { return }
        let name = url.host
        if let name = name {
            currentDeepLink = name
        }
    }
}
