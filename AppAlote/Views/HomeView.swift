//
//  Diego_Reto
//
//  Created by Alumno on 23/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userManager: UserManager
    @State var showProfile = false
    @State var name : String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Image("profile_picture")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .padding(.leading,10)
                            Text(name)
                                .font(.headline)
                                .padding(.leading,10)
                            Spacer()
                        }
                        .frame(height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue.opacity(0.6))
                                .shadow(radius: 5)
                        )
                        .padding(.top, 40)
                        .padding(.horizontal, 10)
                        
                       
                        Image("ZONAS PARA TI")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .padding(.vertical, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ZonaCardView(imageName: "Expreso", label: "Expreso", labelColor: .orange)
                                ZonaCardView(imageName: "Pertenezco", label: "Pertenezco", labelColor: .green)
                                ZonaCardView(imageName: "Comprendo", label: "Comprendo", labelColor: .purple)
                            }
                            .padding(.horizontal)
                        }
                        Image("Exhibiciones")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .padding(.top,16)
                        VStack(spacing: 0){
                            Image("Dino")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 400, height: 230)
                                .clipped()
                            Text("Exhibición temporal")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: 100)
                                .background(Color(red:230/255, green: 245/255, blue: 221/255))
                        }
                        .frame(width: 400,height: 260)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    }
                    .padding(.bottom, 150)
                }
                .padding(.top, 100)
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {print("notificiation")}) {
                            Image("notification-2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                        .frame(width: 75, height: 75)
                                )
                            
                        }
                        
                            
                        Spacer()
                        Spacer()
                        Image("Logo")
                            .padding(.leading, 10)
                        Spacer()
                        Spacer()
                        
                        Button{
                            showProfile = true
                        } label: {
                            Image("menu 1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                        .frame(width: 75, height: 75)
                                )
                        }
                        Spacer()
                        
                    }
                    .padding(.top, 40)
                }
                .frame(width: UIScreen.main.bounds.size.width)
                .padding(.vertical, 20)
                .background(Color(red: 210/255, green: 223/255, blue: 73/255))
                .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .top)
                .ignoresSafeArea()
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(name: name)
            }
            .onAppear{
                Task{
                    name = await userManager.fetchUsername()
                }
        }
        }
    }
}

struct ZonaCardView: View {
    let imageName: String
    let label: String
    let labelColor: Color
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
            
            Text(label)
                .font(.system(size: 20))
                .foregroundColor(labelColor)
                .padding(.top, 4)
        }
        .frame(width: 150, height: 200)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserManager())
    }
}
