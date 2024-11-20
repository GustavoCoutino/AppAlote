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
    var body: some View {
        ScrollView{
            ForEach(notifications){ notification in
                NotificationView(notification: notification)
                
            }
        }
        .padding(.top, 15)
        .onAppear{
            Task {
                notifications = await userManager.fetchNotifications()
                print(notifications)
            }
        }
    }
}

#Preview {
    NotificationsView().environmentObject(UserManager())
}
