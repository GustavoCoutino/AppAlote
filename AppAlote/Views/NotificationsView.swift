//
//  NotificationsView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/20/24.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var userManager: UserManager
    @State var notifications : [Announcement] = []
    @State var isLoading = true
    var body: some View {
        ScrollView{
            if isLoading {
                ProgressView()
                    .padding(.top, 20)
            } else {
                ForEach(notifications){ notification in
                    NotificationView(notification: notification)
                    
                }
            }
            
        }
        .padding(.top, 15)
        .onAppear{
            Task {
                notifications = await userManager.fetchNotifications()
                isLoading = false
            }
        }
    }
}

#Preview {
    NotificationsView().environmentObject(UserManager())
}
