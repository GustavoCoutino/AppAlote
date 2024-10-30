//
//  ViewController.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 28/10/24.
//

import SwiftUI

struct ViewController: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedView: String = "Home"
    @State var selectedAuthView : String = "LogIn"
    
    var body: some View {
        NavigationStack{
            if userManager.isAuthenticated {
                if userManager.hasRecentAccessCode {
                    if userManager.hasAnsweredQuiz {
                        ZStack {
                            switch selectedView {
                                case "Home":
                                    HomeView()
                                case "Map":
                                    MapView()
                                case "Code":
                                    CodeView()
                                case "Social":
                                    SocialView()
                                default:
                                    HomeView()
                            }
                            Navbar(selectedView: $selectedView)
                        }
                    } else {
                        QuizView()
                    }
                    
                } else {
                    AccessCodeView()
                }
                
            } else {
                switch selectedAuthView {
                    case "LogIn":
                        LogIn(selectedView: $selectedAuthView)
                    case "SignIn":
                        SignIn(selectedView: $selectedAuthView)
                    default:
                        LogIn(selectedView: $selectedAuthView)
                }
            }
        }
    }
}

#Preview {
    ViewController().environmentObject(UserManager())
}
