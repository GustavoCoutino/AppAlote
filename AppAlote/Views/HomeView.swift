//
//  Diego_Reto
//
//  Created by Alumno on 23/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var sortedZones: [Int] = []
    @State var isZoneSelected: Bool = false
    @State var showNotifications: Bool = false
    @State var selectedZone: String?
    @State var showSignOutAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        BannerView()
                       
                        Image("ZONAS PARA TI")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .padding(.vertical, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(sortedZones, id: \.self) { zona in
                                    let (imageName, label, color) = getZonaDetails(for: zona)
                                    ZonaCardView(imageName: imageName, label: label, labelColor: color)
                                        .onTapGesture {
                                            isZoneSelected = true
                                            selectedZone = label.uppercased()
                                            if selectedZone == "PEQUEÑOS"{
                                                selectedZone = "PEQUEÑOS 1"
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        Image("Exhibiciones")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .padding(.top,16)
                        
                        VStack(spacing: 0){
                            Image("people")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                        .frame(width: 400,height: 260)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .onTapGesture {
                            isZoneSelected = true
                            selectedZone = "EXPOSICIONES TEMPORALES"
                        }
                    }
                    .padding(.bottom, 200)
                }
                .padding(.top, 100)
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showNotifications = true
                        }) {
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
                        Image("papalote")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                        Spacer()
                        Spacer()
                        
                        Button{
                            // userManager.signOut()
                            showSignOutAlert = true
                        } label: {
                            Image("signout")
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
                    .padding(.top, 42)
                }
                .frame(width: UIScreen.main.bounds.size.width)
                .padding(.vertical, 20)
                .background(Color(red: 210/255, green: 223/255, blue: 73/255))
                .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .top)
                .ignoresSafeArea()
            }
            .onAppear{
                Task {
                    await userManager.loadData()
                }
                
                loadSortedZones()
                
            }
            .navigationDestination(isPresented: $isZoneSelected){
                if let name = selectedZone {
                    ZoneView(name: name)
                }
            }
            .sheet(isPresented: $showNotifications){
                NotificationsView()
            }
            .alert(isPresented: $showSignOutAlert) {
                Alert(
                    title: Text("Cerrar sesión"),
                    message: Text("¿Estás seguro? Al cerrar sesión tendrás que iniciar sesión e ingresar el código de acceso nuevamente."),
                    primaryButton: .default(Text("Cerrar sesión")) {
                        userManager.signOut()
                    },
                    secondaryButton: .cancel()
                )
            }

        }
    }
    private func loadSortedZones() {
        if let savedZones = UserDefaults.standard.array(forKey: "sortedZones") as? [Int] {
            sortedZones = savedZones
        }
    }
    
    private func getZonaDetails(for zona: Int) -> (imageName: String, label: String, labelColor: Color) {
            switch zona {
            case 1:
                return ("Expreso", "Expreso", .orange)
            case 2:
                return ("Pertenezco", "Pertenezco", .green)
            case 3:
                return ("Comunico", "Comunico", .blue)
            case 4:
                return ("Comprendo", "Comprendo", .purple)
            case 5:
                return ("Pequeños", "Pequeños", Color(red: 173/255, green: 216/255, blue: 230/255))
            case 6:
                return ("Soy", "Soy", .red)
            default:
                return ("", "Unknown", .gray)
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
