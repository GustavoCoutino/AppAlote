//
//  ActivityView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/10/24.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var userManager: UserManager
    @State var currentPage = 0
    @State var rating: Int = 0
    @State var feedback: String = ""
    @State var pages : [Page] = []
    @State var loading : Bool = true
    
    var body: some View {
        VStack {
            if loading {
                LoadingView()
            } else {
                ProgressView(value: Double(currentPage + 1), total: Double(pages.count + 1))
                    .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
                    .scaleEffect(x: 1, y: 3, anchor: .center)
                    .padding()
                if currentPage == pages.count {
                    FinalPageView(rating: $rating, feedback: $feedback)
                } else {
                    PageView(page: pages[currentPage]).id(currentPage)
                }
                
                HStack {
                    if currentPage == pages.count {
                        Button("Saltar") {
                            withAnimation {
                                userManager.currentDeepLink = nil
                            }
                        }
                        .buttonStyle(NavigationButtonStyle())
                        
                        Spacer()
                        
                        Button("Enviar") {
                            withAnimation {
                                userManager.currentDeepLink = nil
                            }
                        }
                        .buttonStyle(NavigationButtonStyle())
                    } else {
                        if currentPage > 0 {
                            Button("Retroceder") {
                                withAnimation {
                                    currentPage -= 1
                                }
                            }
                            .buttonStyle(NavigationButtonStyle())
                        }
                        
                        Spacer()
                        
                        Button("Siguiente") {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                        .buttonStyle(NavigationButtonStyle())
                    }
                    
                }
                .padding()
            }
        }
        .padding()
        .onAppear{
            Task {
                if let name = userManager.currentDeepLink {
                    pages = await userManager.fetchExhibitionActivity(exhibition: name)
                }
                loading = false
            }
        }
    }
}

#Preview {
    ActivityView().environmentObject(UserManager())
}
