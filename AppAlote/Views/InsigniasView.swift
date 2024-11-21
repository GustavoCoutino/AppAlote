//
//  InsigniasView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct InsigniasView: View {
    
    @State private var badges: [Insignias] = []
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(badges) { badge in
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.2))
                                .frame(width: 80, height: 80)
                            AsyncImage(url: URL(string: badge.imagen)) { image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .grayscale(badge.obtenido ? 0 : 1) 
                                    .opacity(badge.obtenido ? 1 : 0.5)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Text(badge.nombre_recompensa)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                badges = await userManager.fetchInsignias()
            }
        }
    }
}
