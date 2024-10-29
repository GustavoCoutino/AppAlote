//
//  MapView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 23/10/24.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            Map(focused: "Planta baja")
            Navbar()
            
            
        }
    }
}

#Preview {
    MapView()
}
