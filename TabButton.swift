import SwiftUI

struct TabButton: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(isSelected ? Color(hex: "#D1F63D") : Color.clear)
                .cornerRadius(8)
                .foregroundColor(isSelected ? .black : .gray)
            
            if isSelected {
                Rectangle()
                    .fill(Color(hex: "#D1F63D"))
                    .frame(height: 4)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 4)
            }
        }
        .animation(.easeInOut, value: isSelected)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
