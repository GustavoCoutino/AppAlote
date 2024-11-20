
import SwiftUI

struct ProfileView: View {
        enum Tab {
            case logros, insignias, tarjetas, perfil
        }
        @EnvironmentObject var userManager: UserManager
        @State var name : String = ""
        @State var lastName : String = ""
        @State private var selectedTab: Tab = .perfil
        @State private var selectedCardImage: String = "background1"
        @State var profilePicture : String = ""

        var body: some View {
            VStack {
                VStack {
                    
                    ZStack {
                        
                        Image(selectedCardImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .containerRelativeFrame(.horizontal)
                            .frame(height: 260)
                            .clipped()
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack{
                            if let url = URL(string: profilePicture) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 100, height: 100)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    default:
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.black)
                                
                                    }
                                }
                            }
                            
                            Text(name+" "+lastName)
                                .font(.title)
                                .fontWeight(.bold)
                            
                        }
                    }
                    .frame(height: 200)
                    
                    
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            TabButton(title: "Perfil", isSelected: selectedTab == .perfil)
                                .onTapGesture {
                                    selectedTab = .perfil
                                }
                            TabButton(title: "Logros", isSelected: selectedTab == .logros)
                                .onTapGesture {
                                    selectedTab = .logros
                                }
                            TabButton(title: "Insignias", isSelected: selectedTab == .insignias)
                                .onTapGesture {
                                    selectedTab = .insignias
                                }
                            TabButton(title: "Tarjetas", isSelected: selectedTab == .tarjetas)
                                .onTapGesture {
                                    selectedTab = .tarjetas
                                }
                            
                        }
                        .padding(.top)}
                    Divider()
                }
                
                if selectedTab == .logros {
                    LogrosView()
                } else if selectedTab == .insignias {
                    InsigniasView()
                } else if selectedTab == .tarjetas {
                    TarjetasView(selectedCardImage: $selectedCardImage)
                } else if selectedTab == .perfil {
                    PerfilView()
                }
            }
            .onAppear {
                name = UserDefaults.standard.string(forKey: "nombre") ?? "Invitado"
                lastName = UserDefaults.standard.string(forKey: "apellido") ?? ""
                profilePicture = UserDefaults.standard.string(forKey: "fotoPerfil") ?? "profile_picture"

            }
            .background(Color.white)
        }
        
}

#Preview {
    ProfileView()
        .environmentObject(UserManager())
}
