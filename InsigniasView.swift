import SwiftUI


struct InsigniasView: View {
    
    struct Achievement: Identifiable {
        let id = UUID()
        let title: String
        let level: String
        let currentProgress: Int
        let totalProgress: Int
        let imageName: String
        let color: Color
    }
    
    let achievements: [Achievement] = [
        Achievement(title: "Explorador", level: "Nivel 1", currentProgress: 10, totalProgress: 10, imageName: "thumbsup", color: Color.blue),
        Achievement(title: "Explorador", level: "Nivel 2", currentProgress: 5, totalProgress: 10, imageName: "magnifyingglass", color: Color.orange),
        Achievement(title: "Explorador", level: "Nivel 1", currentProgress: 8, totalProgress: 10, imageName: "trophy", color: Color.purple),
        
    ]
    
    var body: some View {
        // Grid de Insignias
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(badges, id: \.self) { badge in
                                VStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color.green.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                        Image(systemName: badge.icon)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    Text(badge.title)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }

        // Modelo para las insignias
        struct Badge: Hashable {
            var icon: String
            var title: String
        }

        // Datos de ejemplo para las insignias
        let badges = [
            Badge(icon: "hand.thumbsup.fill", title: "Explorador I"),
            Badge(icon: "person.2.wave.2.fill", title: "Explorador II"),
            Badge(icon: "trophy.fill", title: "Explorador I"),
            Badge(icon: "megaphone.fill", title: "Explorador II"),
            Badge(icon: "person.3.fill", title: "Explorador I"),
            Badge(icon: "book.fill", title: "Explorador II")
        ]

#Preview {
   ContentView()
}
