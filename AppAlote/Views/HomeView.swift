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
    @State var temporaryExhibitions : [TemporaryExhibition] = []
    @State var isExhibitionSelected: Bool = false
    @State var selectedExhibition: String?

    var body: some View {
        NavigationStack {
            ZStack {
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
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.size.width)
                    .padding(.vertical, 20)
                    .background(Color(red: 210/255, green: 223/255, blue: 73/255))
                    
                    
                    ScrollView {
                        BannerView()
                            .padding(.top, 25)
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
                            .padding(.horizontal, 30)
                        }
                        Image("Exhibiciones")
                            .resizable()
                            .frame(width: 250, height: 200)
                            .padding(.top,16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(temporaryExhibitions) { exhibition in
                                    ExhibitionCardView(imageName: exhibition.img, label: exhibition.nombre)
                                        .onTapGesture {
                                            isExhibitionSelected = true
                                            selectedExhibition = exhibition.nombre
                                        }
                                }
                            }
                            .padding(.horizontal, 30)
                        }
                        .padding(.bottom, 150)
                        .navigationDestination(isPresented: $isExhibitionSelected){
                            if let name = selectedExhibition {
                                ExhibitionView(name: name)
                            }
                        }

                    }
                    .ignoresSafeArea()
                    .offset(x: 0, y: -8)

                }
                .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .top)
                
                
            }
            .onAppear{
                Task {
                    await userManager.loadData()
                    temporaryExhibitions = await userManager.fetchTemporaryExhibition()
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
                return ("Pequeños", "Pequeños", Color(red: 68/255, green: 103/255, blue: 196/255))
            case 6:
                return ("Soy", "Soy", .red)
            default:
                return ("", "Unknown", .black)
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

struct ExhibitionCardView: View {
    let imageName: String
    let label: String
    let color = randomColor()
    var body: some View {
        VStack {
            if let url = URL(string: imageName) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .padding(.leading, 20)
                    case .success(let image):
                        ZStack{
                            Circle()
                                .fill(.purple)
                                .frame(width: 140, height: 140)
                                .offset(x: 0, y: -7)
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 145, height: 135)
                                .clipShape(Circle())
                        }
                    default:
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundStyle(.black)
                            .clipShape(Circle())
                    }
                }
            }
            Text(formatText(label))
                .font(.system(size: 20))
                .foregroundStyle(.purple)
                .padding(.top, 4)
        }
        .frame(width: 150, height: 200)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


func randomColor() -> Color {
    let colors: [Color] = [.purple, .red, .orange, .blue]
    return colors.randomElement() ?? .black
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserManager())
    }
}
