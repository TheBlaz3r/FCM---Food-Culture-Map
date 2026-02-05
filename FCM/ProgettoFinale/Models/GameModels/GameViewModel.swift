import CoreLocation
import Foundation

@Observable
class GameViewModel {
    var userGuess: CLLocationCoordinate2D? = nil
    var currentClueIndex: Int = 0

    // Timer
    var timeRemaining: Int = 60
    var timer: Timer? = nil
    var timerActive: Bool = false

    func startTimer() {
        timeRemaining = 60
        timerActive = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            [weak self] t in
            guard let self = self else {
                t.invalidate()
                return
            }
            if self.timerActive && self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        timerActive = false
        timer?.invalidate()
        timer = nil
    }

    func calculateScore() -> Int {
        guard let guess = userGuess else { return 0 }
        guard let countryLocation = countryLocations[selectedDish!.country]
        else { return 0 }
        let distance = haversine(
            lat1: countryLocation.latitude,
            lon1: countryLocation.longitude,
            lat2: guess.latitude,
            lon2: guess.longitude
        )
        var score = max(0, 1000 - Int(distance * 2))
        score -= currentClueIndex * 50  // penalità clue
        score += timeRemaining * 5  // bonus tempo fermo
        return max(score, 0)
    }

    func nextDish() {
        selectRandomFood()
        userGuess = nil
        currentClueIndex = 0
        startTimer()
    }

    private func haversine(
        lat1: Double,
        lon1: Double,
        lat2: Double,
        lon2: Double
    ) -> Double {
        let R = 6371.0
        let dLat = (lat2 - lat1) * .pi / 180
        let dLon = (lon2 - lon1) * .pi / 180
        let a =
            sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * .pi / 180)
            * cos(lat2 * .pi / 180) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        return R * c
    }
}
