
import SwiftUI
import PhotosUI

struct ProfileView: View {
        enum Tab {
            case logros, insignias, tarjetas, perfil
        }
        @EnvironmentObject var userManager: UserManager
        @State var name : String = ""
        @State var lastName : String = ""
        @State private var selectedTab: Tab = .perfil
        @State private var selectedCardImage: String = ""
        @State var profilePicture : String = ""
    
        @State private var showingImagePicker = false
        @State private var selectedItem: PhotosPickerItem?
    
        var body: some View {
            VStack {
                VStack {
                    
                    ZStack {
                        
                        if userManager.uploadingBanner {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 285)
                                .ignoresSafeArea()
                        } else {
                            if userManager.banner.isEmpty{
                                Rectangle()
                                    .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                                    .frame(height: 285)
                                    .ignoresSafeArea()
                                    
                            } else {
                                AsyncImage(url: URL(string: userManager.banner)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .containerRelativeFrame(.horizontal)
                                        .frame(height: 285)
                                        .clipped()
                                        .edgesIgnoringSafeArea(.all)
                                } placeholder: {
                                    Image("")
                                }
                            }
                        }
                        
                    
                        VStack{
                            if userManager.uploadingPhoto {
                                ZStack{
                                    Circle()
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(Color(red: 210/255, green: 223/255, blue: 73/255))
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                }
                                
                            } else {
                                if let url = URL(string: !userManager.profilePicture.isEmpty ? userManager.profilePicture :  "profilepicture22") {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ZStack{
                                                Circle()
                                                    .frame(width: 100, height: 100)
                                                    .foregroundStyle(Color(red: 210/255, green: 223/255, blue: 73/255))
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(Circle())
                                            }
                                            
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
                                    .onTapGesture {
                                        showingImagePicker = true
                                    }
                                }
                            }
                                                        
                            Text(userManager.name+" "+userManager.lastName)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(
                                    Color(red: 210/255, green: 223/255, blue: 73/255)
                                )
                                .clipShape(.rect(cornerRadius: 15))
                            
                            
                        }
                    }
                    .frame(height: 220)
                    
                    
                    
                    
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
                    TarjetasView()
                } else if selectedTab == .perfil {
                    PerfilView()
                }
            }
            .onAppear {
                Task {
                    await userManager.loadData()
                }
                userManager.banner = UserDefaults.standard.string(forKey: "tarjeta") ?? ""
            }
            .photosPicker(isPresented: $showingImagePicker,
                                 selection: $selectedItem,
                                 matching: .images)
            .onChange(of: selectedItem) { newItem in
                userManager.uploadingPhoto = true
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        userManager.uploadProfilePhoto(imageData: data)
                    }

                }
            }
            .background(Color.white)
        }
        
}

#Preview {
    ProfileView()
        .environmentObject(UserManager())
}
