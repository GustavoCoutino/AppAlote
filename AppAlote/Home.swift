//
//  Home.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 23/10/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack{
            
            HStack{
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
                
                Spacer()
                Image("location")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                            .frame(width: 75, height: 75)
                    )
                Spacer()
                Image("qr-code")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                            .frame(width: 75, height: 75)
                    )
                
                Spacer()
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
            }
            .padding(.top, 45)
            .padding(.bottom, 45)
            .background(Color.purple)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    Home()
}
