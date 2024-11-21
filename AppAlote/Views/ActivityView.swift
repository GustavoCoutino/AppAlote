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
    @State var id : Int?
    
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
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Button("Enviar") {
                            withAnimation {
                                if let id = id {
                                    Task {
                                        await userManager.submitOpinion(stars: rating, comment: feedback, exhibitionID: id)
                                    }
                                    userManager.currentDeepLink = nil
                                }
                            }
                        }
                        .disabled(rating == 0)
                        .frame(minWidth: 100)
                        .padding()
                        .background(rating == 0 ? Color.gray : Color.green )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    } else {
                        if currentPage > 0 {
                            Button("Retroceder") {
                                withAnimation {
                                    currentPage -= 1
                                }
                            }
                            .frame(minWidth: 100)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button("Siguiente") {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
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
                    if let exhibition = await userManager.fetchExhibitionData(exhibition: name){
                        id = exhibition.id
                    }
                }
                loading = false
            }
        }
    }
}

#Preview {
    ActivityView().environmentObject(UserManager())
}
