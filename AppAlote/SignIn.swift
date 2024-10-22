import SwiftUI

struct SignIn: View {
    @State private var nombre: String = ""
    @State private var correo: String = ""
    @State private var codigo: String = ""
    @State private var fechaNacimiento = Date() // Date state for the DatePicker
    
    var body: some View {
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
                    Text("Nombre completo")
                        .foregroundColor(Color(red: 84/255, green: 18/255, blue: 137/255)).bold()
                    
                    TextField("", text: $nombre)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color(red:243/255, green: 246/255, blue: 205/255))
                        .cornerRadius(20).shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal).padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Correo electrónico")
                        .foregroundColor(Color(red: 84/255, green: 18/255, blue: 137/255)).bold()
                    
                    TextField("", text: $correo)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color(red:243/255, green: 246/255, blue: 205/255))
                        .cornerRadius(20).shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal).padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Fecha de nacimiento")
                        .foregroundColor(Color(red: 84/255, green: 18/255, blue: 137/255)).bold()
                    
                    
                    DatePicker("", selection: $fechaNacimiento, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle()) 
                        .frame(height: 35)
                        .background(Color(red:243/255, green: 246/255, blue: 205/255))
                        .cornerRadius(20)
                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                }
                .padding(.horizontal).padding(.top, 20)

                VStack(alignment: .leading) {
                    Text("Código de acceso")
                        .foregroundColor(Color(red: 84/255, green: 18/255, blue: 137/255)).bold()
                    
                    TextField("", text: $codigo)
                        .padding(.horizontal).bold()
                        .frame(height: 35)
                        .background(Color(red:243/255, green: 246/255, blue: 205/255))
                        .cornerRadius(20).shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal).padding(.top, 20)
                
                Button(action: { print("Acceder button tapped") }) {
                    Text("Acceder")
                        .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255))
                        .frame(width: 100)
                        .padding()
                        .background(Color(red: 210/255, green: 223/255, blue: 73/255))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    SignIn()
}
