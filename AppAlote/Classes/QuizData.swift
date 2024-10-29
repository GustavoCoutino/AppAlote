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
        Question(id: 1, titulo: "¿Cuál color es el que más te gusta?", respuestas: ["Celeste", "Morado", "Naranja", "Rojo", "Verde", "Azul"]),
        Question(id: 2, titulo: "¿Qué género de película disfrutas más?", respuestas: ["Ciencia ficción", "Fantasía", "Acción", "Comedia", "Animadas", "Cualquier género esta bien"]),
        Question(id: 3, titulo: "¿Qué le dirás a tu niño interior?", respuestas: ["Comprenderte a ti mismo es el primer paso para comprender a los demás", "Gracias por esta aventura, ahora me toca vivir una nueva", "La flor que florece en la adversidad es la más rara y hermosa de todas.", "Sabes que en caso de no tener música de fondo, tú puedes crear la tuya", "Tienes una voz única, y el mundo necesita escucharla", "No todas las decisiones tienen que ser perfectas, a veces lo que importa es intentarlo"]),
        Question(id: 4, titulo: "¿Con qué frase te identificas más?", respuestas: ["Lo que conocemos es una gota, lo que no conocemos es un océano (Isaac Newton)", "La vida es un lienzo en blanco, y debes lanzar sobre él toda la pintura que puedas (Danny Kaye)", "Eres lo que haces, no lo que dices que harás (Carl Jung)", "Cuando cambiamos la forma en que nos comunicamos, cambiamos la sociedad (Clay Shirky)", "Todas las personas mayores fueron al principio niños, aunque pocas lo recuerdan (Antoine de Saint-Exupéry", "Mira profundamente en la naturaleza y entonces comprenderás todo mejor (Albert Einstein)"]),
        Question(id: 5, titulo: "¿Qué pasatiempo prefieres?", respuestas: ["Experimentar cosas nuevas", "Convivir en familia.", "Disfrutar de la naturaleza.", "Escuchar música", "Ver redes sociales", "Ir de compras"]),
        Question(id: 6, titulo: "¿Cuál es tu género musical favorito?", respuestas: ["Rock", "Pop", "Clásica", "Regional mexicano", "Disfruto todos los géneros", "Electrónica"]),
        Question(id: 7, titulo: "¿Cuál tema te gusta más?", respuestas: ["Educación física", "Biología", "Español", "Química", "Arte", "Matemáticas"])
    ]
}
