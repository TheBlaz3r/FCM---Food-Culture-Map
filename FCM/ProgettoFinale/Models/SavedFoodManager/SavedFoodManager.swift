import SwiftUI
import Foundation

@Observable
class FavoritesManager {
    var savedFoods: [Record] = []
    
    // Aggiungi o rimuovi
    func toggleFavorite(food: Record) {
        if let index = savedFoods.firstIndex(where: { $0.id == food.id }) {
            savedFoods.remove(at: index)
        } else {
            savedFoods.append(food)
        }
    }
    
    // Controlla se esiste
    func isFavorite(_ food: Record) -> Bool {
        savedFoods.contains(where: { $0.id == food.id })
    }
}
