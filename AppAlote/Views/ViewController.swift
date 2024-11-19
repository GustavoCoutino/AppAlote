//
//  ViewController.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 28/10/24.
//

import SwiftUI

struct ViewController: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationStack{
            if userManager.isLoading {
                LoadingView()
            } else {
                if userManager.isAuthenticated {
                    if userManager.hasRecentAccessCode {
                        if userManager.currentDeepLink != nil{
                            ActivityView()
                        }
                        else if userManager.hasAnsweredQuiz {
                            ZStack {
                                switch userManager.selectedView {
                                    case "Home":
                                        HomeView()
                                    case "Map":
                                        MapView()
                                    case "Code":
                                        CodeView()
                                    case "Social":
                                        SocialView()
                                    case "Profile":
                                        ProfileView(name: "Reyli")
                                    default:
                                        HomeView()
                                }
                                Navbar(selectedView: $userManager.selectedView)
                            }
                        } else {
                            QuizView(userManager: userManager).environmentObject(userManager)
                        }
                        
                    } else {
                        AccessCodeView()
                    }
                    
                } else {
                    switch userManager.selectedAuthView {
                        case "LogIn":
                        LogIn(selectedView: $userManager.selectedAuthView)
                        case "SignIn":
                        SignIn(selectedView: $userManager.selectedAuthView)
                        default:
                        LogIn(selectedView: $userManager.selectedAuthView)
                    }
                }

            }
            
        }
        .animation(.easeInOut, value: userManager.selectedView)
        .animation(.easeInOut, value: userManager.selectedAuthView)
        .onOpenURL{ url in
            userManager.handleURL(url)
        }
    }
}


#Preview {
    ViewController().environmentObject(UserManager())
}
