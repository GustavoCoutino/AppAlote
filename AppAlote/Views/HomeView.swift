//
//  Diego_Reto
//
//  Created by Alumno on 23/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userManager: UserManager
    @State var name : String = ""
    @State var lastName : String = ""
    @State var profilePicture : String = ""
    @State private var sortedZones: [Int] = []
    @State var isZoneSelected: Bool = false
    @State var showNotifications: Bool = false
    @State var selectedZone: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                  
                            if let url = URL(string: profilePicture) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                            .padding(.leading, 20)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                            .padding(.leading, 20)

                                    default:
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .padding(.leading, 20)
                                            .foregroundColor(.black)
                                
                                    }
                                }
                            }

                            Text(name+" "+lastName)
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
                        .onTapGesture {
                            userManager.selectedView = "Profile"
                        }
                        
                       
                        Image("ZONAS PARA TI")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .padding(.vertical, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(sortedZones, id: \.self) { zona in
                                    let (imageName, label, color) = getZonaDetails(for: zona)
                                    ZonaCardView(imageName: imageName, label: label, labelColor: color)
                                        .onTapGesture {
                                            isZoneSelected = true
                                            selectedZone = label.uppercased()
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        /*
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
                         */
                    }
                    .padding(.bottom, 150)
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
                            userManager.signOut()
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
                loadSortedZones()
                name = UserDefaults.standard.string(forKey: "nombre") ?? "Invitado"
                lastName = UserDefaults.standard.string(forKey: "apellido") ?? ""
                profilePicture = UserDefaults.standard.string(forKey: "fotoPerfil") ?? "profile_picture"
            }
            .navigationDestination(isPresented: $isZoneSelected){
                if let name = selectedZone {
                    ZoneView(name: name)
                }
            }
            .sheet(isPresented: $showNotifications){
                NotificationsView()
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
