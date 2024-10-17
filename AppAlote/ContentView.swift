import SwiftUI

struct ContentView: View {
    @State private var nombre: String = ""
    @State private var edad: String = ""
    @State private var codigo: String = ""
    var body: some View {
        ZStack {
            Color(red: 243/255, green: 251/255, blue: 253/255).ignoresSafeArea()
            VStack {
                Image("LogoPapalote")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)
                
                VStack(alignment: .leading) {
                    Text("Nombre")
                        .foregroundColor(Color(red: 14/255, green: 43/255, blue: 51/255)).bold()
                    
                    TextField("Ingresa tu nombre", text: $nombre)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.horizontal).padding(.top, 30)
                
                VStack(alignment: .leading) {
                    Text("Correo electrónico")
                        .foregroundColor(Color(red: 14/255, green: 43/255, blue: 51/255)).bold()
                    
                    TextField("Ingresa tu correo electrónico", text: $edad)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.horizontal).padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Edad")
                        .foregroundColor(Color(red: 14/255, green: 43/255, blue: 51/255)).bold()
                    
                    TextField("Ingresa tu edad", text: $edad)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.horizontal).padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Código de acceso")
                        .foregroundColor(Color(red: 14/255, green: 43/255, blue: 51/255)).bold()
                    
                    TextField("Ingresa el código de acceso", text: $codigo)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.horizontal).padding(.top, 20)
                
                Button(action: { print("Acceder button tapped") }) { Text("Acceder") .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255)) .frame(maxWidth: .infinity) .padding() .background(Color(red: 210/255, green: 223/255, blue: 73/255)) .cornerRadius(8) .padding(.horizontal).shadow(color: .gray, radius: 5, x: 0, y: 5) } .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
