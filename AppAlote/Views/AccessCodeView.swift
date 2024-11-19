import SwiftUI

struct AccessCodeView: View {
    @State private var codigo: String = ""
    @State private var showAlert = false
    @EnvironmentObject var userManager: UserManager
    @State var loading = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 150, height: 150)
                    .offset(x: -110, y: -300)
                
                Triangle()
                    .stroke(Color.red, lineWidth: 4)
                    .frame(width: 100, height: 100)
                    .offset(x: -40, y: 350)
                    .rotationEffect(.degrees(10), anchor: .center)
                
                Triangle()
                    .stroke(Color.yellow, lineWidth: 4)
                    .frame(width: 100, height: 100)
                    .offset(x: 0, y: 230)
                    .rotationEffect(.degrees(165), anchor: .center)

                Circle()
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, dash: [8]))
                    .frame(width: 100, height: 100)
                    .offset(x: 160, y: 180)
                
                VStack {
                    Image("LogoOficial")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, 50)
                    
                    VStack(alignment: .leading) {
                        Text("Código de acceso")
                            .foregroundColor(Color(red: 84/255, green: 18/255, blue: 137/255)).bold()
                        
                        TextField("", text: $codigo)
                            .textInputAutocapitalization(.never)
                            .padding(.horizontal).bold()
                            .frame(height: 35)
                            .background(Color(red:243/255, green: 246/255, blue: 205/255))
                            .cornerRadius(20).shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal).padding(.top, 20)
                    
                    
                    HStack {
                        Button(action: {
                            loading = true
                            Task {
                                await userManager.enterAccessCode(codigo)
                                loading = false
                                if userManager.errorMessage != nil {
                                    showAlert = true
                                }
                            }
                        }) {
                            if loading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            } else {
                                Text("Acceder")
                                    .foregroundStyle(.black)
                            }
                        }
                        .frame(width: 175, height: 55)
                        .background(Color(red: 210/255, green: 223/255, blue: 73/255))
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                        .disabled(loading)
                    }
                    .padding(.top, 50)
                    
            
                }
                .padding()
                .alert(isPresented: $showAlert)
                {
                    Alert(
                        title: Text("Error"),
                        message: Text(userManager.errorMessage ?? "Error desconocido"),
                        dismissButton: .default(Text("OK"), action: {
                            userManager.clearError()
                        })
                    )
                }
            }
        }
    }
}

#Preview {
    AccessCodeView().environmentObject(UserManager())
}
