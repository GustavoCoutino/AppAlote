//
//  QuizData.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//

struct Question {
    let id: Int
    let titulo: String
    let respuestas: [String]
}

struct QuizData {
    static let questions: [Question] = [
        Question(id: 1, titulo: "¿Cuál color es el que más te gusta?", respuestas: ["Celeste", "Verde", "Azul", "Morado", "Naranja", "Rojo"]),
        Question(id: 2, titulo: "¿Qué género de película disfrutas más?", respuestas: ["Animadas", "Cualquier género está bien", "Comedia", "Ciencia ficción", "Fantasía", "Acción"]),
        Question(id: 3, titulo: "¿Qué le dirás a tu niño interior?", respuestas: ["Gracias por esta aventura, ahora me toca vivir una nueva", "La flor que florece en la adversidad es la más rara y hermosa de todas.", "Tienes una voz única, y el mundo necesita escucharla", "Comprenderte a ti mismo es el primer paso para comprender a los demás", "Sabes que en caso de no tener música de fondo, tú puedes crear la tuya", "No todas las decisiones tienen que ser perfectas, a veces lo que importa es intentarlo"]),
        Question(id: 4, titulo: "¿Con qué frase te identificas más?", respuestas: ["Todas las personas mayores fueron al principio niños, aunque pocas lo recuerdan (Antoine de Saint-Exupéry", "Mira profundamente en la naturaleza y entonces comprenderás todo mejor (Albert Einstein)",  "Cuando cambiamos la forma en que nos comunicamos, cambiamos la sociedad (Clay Shirky)", "Lo que conocemos es una gota, lo que no conocemos es un océano (Isaac Newton)", "La vida es un lienzo en blanco, y debes lanzar sobre él toda la pintura que puedas (Danny Kaye)", "Eres lo que haces, no lo que dices que harás (Carl Jung)"]),
        Question(id: 5, titulo: "¿Qué pasatiempo prefieres?", respuestas: ["Convivir en familia.", "Disfrutar de la naturaleza.", "Ver redes sociales", "Experimentar cosas nuevas", "Escuchar música", "Ir de compras"]),
        Question(id: 6, titulo: "¿Cuál es tu género musical favorito?", respuestas: ["Pop", "Regional mexicano", "Electrónica", "Clásica", "Disfruto de todos los géneros", "Rock"]),
        Question(id: 7, titulo: "¿Cuál tema te gusta más?", respuestas: ["Educación física", "Biología", "Español", "Química", "Arte", "Matemáticas"])
    ]
}
