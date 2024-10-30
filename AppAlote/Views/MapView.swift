//
//  MapView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 23/10/24.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        Map(focused: "Planta baja")
    }
}

#Preview {
    MapView().environmentObject(UserManager())
}
