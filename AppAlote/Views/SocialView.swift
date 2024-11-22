//
//  SocialView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 29/10/24.
//
import SwiftUI

struct SocialView: View {
    @State private var posts: [Post] = []
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Image("papalote-extendido")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .padding(.leading, 16)
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                                     startPoint: .top, endPoint: .bottom))
                                .frame(width: 50, height: 50)
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 42)
            }
            .frame(width: UIScreen.main.bounds.size.width)
            .padding(.vertical, 20)
            .background(Color(red: 210/255, green: 223/255, blue: 73/255))
            .ignoresSafeArea()

            ScrollView {
                ForEach(posts) { post in
                    PostView(
                        post: post
                    )
                    .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            Task {
                posts = await userManager.getAllPosts()
            }
        }
    }

   
}

