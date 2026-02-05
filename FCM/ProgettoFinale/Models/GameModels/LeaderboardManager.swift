import Foundation

@Observable class LeaderboardManager {
    public var scores: [Int] = UserDefaults.standard.array(forKey: "scores") as? [Int] ?? []

    func addScore(_ score: Int) {
        scores.append(score)
        scores.sort(by: >) // ordina dal più alto
        if scores.count > 10 { scores.removeLast() }
        UserDefaults.standard.set(scores, forKey: "scores")
    }

    func reset() {
        scores = []
        UserDefaults.standard.removeObject(forKey: "scores")
    }
}

