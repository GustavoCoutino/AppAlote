//
//  ProfileHeaderView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 21/11/24.


import SwiftUI

struct ProfileHeaderView: View {
    let profilePicture: String
    let name: String
    let tarjeta: String
    let nombreExhibicion: String?
    
    @State private var isExhibitionSelected: Bool = false
    
    var body: some View {
        NavigationStack {
            HStack {
                if let url = URL(string: profilePicture) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        default:
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.black)
                        }
                    }
                }
                
                Text("\(name)")
                    .font(.headline)
                    .padding(.leading, 10)
                
                if let exhibitionName = nombreExhibicion {
                    Button(action: {
                        isExhibitionSelected = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 197/255, green: 216/255, blue: 109/255))
                                .frame(width: 24, height: 24)
                            
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.white)
                        }
                    }
                    .navigationDestination(isPresented: $isExhibitionSelected) {
                        ExhibitionView(name: exhibitionName)
                    }
                }
                
                Spacer()
                
            }
            .frame(height: 80)
            .padding(.horizontal, 10)
        }
        
    }
}


