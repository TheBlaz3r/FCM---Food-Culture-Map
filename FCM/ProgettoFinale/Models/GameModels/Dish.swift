import Foundation
import CoreLocation


struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let image: GameFoodImageView
    let clues: [String]
}



