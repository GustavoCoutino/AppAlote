//
//  ActivityView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/10/24.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        if let name = userManager.currentDeepLink{
            Text(name)
        }
        Button{
            userManager.currentDeepLink = nil
        } label: {
            Text("Finish")
        }
    }
}

#Preview {
    ActivityView().environmentObject(UserManager())
}
