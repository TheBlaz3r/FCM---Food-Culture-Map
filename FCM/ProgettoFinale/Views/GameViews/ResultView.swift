import CoreHaptics
import SwiftUI

struct ResultView: View {
    var gameViewModel: GameViewModel
    @Binding var showNextGame: Bool
    @Environment(\.dismiss) var dismiss
    public var leaderboard = LeaderboardManager()
    @State private var engine: CHHapticEngine?

    var body: some View {
        VStack(spacing: 20) {
            Text("Result")
                .font(.largeTitle.bold())

            Text("Dish: \(String(describing: selectedDish!.name))")
            Text("Country: \(String(describing: selectedDish!.country))")
            Text("Score: \(gameViewModel.calculateScore())")
                .font(.title2)
                .foregroundColor(.green)

            Button("Next Dish") {
                gameViewModel.stopTimer()  // ferma timer
                let finalScore = gameViewModel.calculateScore()
                leaderboard.addScore(finalScore)
                gameViewModel.nextDish()
                showNextGame = false
                playHapticSuccess()
                dismiss()
            }
            .buttonStyle(.borderedProminent)

            LeaderboardView(scores: leaderboard.scores)
        }
        .padding()
        .onAppear {
            prepareHaptics()
        }
    }

    // MARK: Haptics
    func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptics not supported")
        }
    }

    func playHapticSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: 1
        )
        let sharpness = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: 1
        )
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: 0
        )
        events.append(event)
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic")
        }
    }
}
