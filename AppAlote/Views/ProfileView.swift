
import SwiftUI

struct ProfileView: View {
        enum Tab {
            case logros, insignias, tarjetas, perfil
        }
        @EnvironmentObject var userManager: UserManager
        @State var name : String
        @State private var selectedTab: Tab = .perfil
        @State private var selectedCardImage: String = "background1"
        
        var body: some View {
            VStack {
                VStack {
                    Image(selectedCardImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.blue)
                                Text(name)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                        )
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
            .background(userManager.isDarkMode ? Color.black : Color.white)
        }
        
}

#Preview {
    ProfileView(name: "Reyli")
        .environmentObject(UserManager())
}
