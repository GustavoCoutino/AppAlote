//
//  MapView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 23/10/24.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            Map(focused: nil)
            VStack {
                HStack {
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
                .frame(width: UIScreen.main.bounds.size.width)
                .padding(.vertical, 45)
                .background(Color.purple)
                .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .bottom)
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    MapView()
}
