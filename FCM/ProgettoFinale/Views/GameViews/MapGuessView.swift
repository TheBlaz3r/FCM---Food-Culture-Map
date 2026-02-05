import MapKit
import SwiftUI

struct MapGuessView: View {
    var gameViewModel: GameViewModel
    @Binding var showResult: Bool
    @Binding var showNextGame: Bool
    @Environment(\.dismiss) var dismiss
    var leaderboard: LeaderboardManager

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
    )
    @State private var userPin: CLLocationCoordinate2D?

    var body: some View {
        ZStack {
            GameMapViewRepresentable(region: $region, userGuess: $userPin)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Button {
                    // FERMA IL TIMER PRIMA DI CALCOLARE IL PUNTEGGIO
                    gameViewModel.stopTimer()

                    // assegna la posizione dell’utente
                    gameViewModel.userGuess = userPin

                    // calcola punteggio finale
                    let finalScore = gameViewModel.calculateScore()

                    // aggiorna leaderboard
                    leaderboard.addScore(finalScore)

                    // mostra risultato
                    showResult = true
                    showNextGame = true
                    dismiss()
                } label: {
                    Text("Confirm Guess")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.black)
                        .cornerRadius(14)
                        .padding()
                }

            }
        }
    }
}
