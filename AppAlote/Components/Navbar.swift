//
//  Navbar.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 28/10/24.
//

import SwiftUI

struct Navbar: View {
    @Binding var selectedView : String
    var body: some View {
        VStack {
            HStack {
                Button(action: { selectedView = "Home" }) {
                    Image("home")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                .frame(width: 75, height: 75)
                        )
                        .padding(.leading, 35)
                    .offset(x: 0, y: selectedView == "Home" ? -15 : 0)
                }
                
                
                Spacer()
                Button(action: { selectedView = "Map" }) {
                    Image("location")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                .frame(width: 75, height: 75)
                        )
                        .offset(x: 0, y: selectedView == "Map" ? -15 : 0)
                }
                
                Spacer()
                Button(action: { selectedView = "Code" }) {
                    Image("qr-code")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                .frame(width: 75, height: 75)
                        )
                        .offset(x: 0, y: selectedView == "Code" ? -15 : 0)
                }
                
                Spacer()
                Button(action: { selectedView = "Profile" }) {
                    Image("profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                .frame(width: 75, height: 75)
                        )
                        .padding(.trailing, 35)
                    .offset(x: 0, y: selectedView == "Profile" ? -15 : 0)
                }
            }
            .frame(width: UIScreen.main.bounds.size.width)
            .padding(.vertical, 50)
            .background(Color.purple)
            .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .bottom)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    Navbar(selectedView: .constant("Home"))
}
