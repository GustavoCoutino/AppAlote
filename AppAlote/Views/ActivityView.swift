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
    
    var body: some View {
        VStack {
            ProgressView(value: Double(currentPage + 1), total: Double(pages.count + 1))
                .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
                .scaleEffect(x: 1, y: 3, anchor: .center)
                .padding()
            
            if currentPage == pages.count {
                FinalPageView(rating: $rating, feedback: $feedback)
            } else {
                PageView(page: pages[currentPage])
            }
            
            HStack {
                if currentPage > 0 {
                    Button("Retroceder") {
                        currentPage -= 1
                    }
                    .buttonStyle(NavigationButtonStyle())
                }
                
                Spacer()
                
                Button("Siguiente") {
                    if currentPage < 2 {
                        if currentPage == pages.count {
                            userManager.currentDeepLink = nil
                        }

                        currentPage += 1
                    }
                }
                .buttonStyle(NavigationButtonStyle())
            }
            .padding()
        }
        .padding()
        .onAppear{
            Task {
                if let name = userManager.currentDeepLink {
                    pages = await userManager.fetchExhibitionActivity(exhibition: name)
                }
            }
        }
    }
}

#Preview {
    ActivityView().environmentObject(UserManager())
}
