import SwiftUI

struct GameView: View {
    @State private var gameViewModel = GameViewModel()
    @State private var showMap = false
    @State private var showResult = false
    @State private var showNextGame = false
    var leaderboard = LeaderboardManager()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.clear, .black.opacity(0.2)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if showNextGame && !showResult {
                VStack {
                    Spacer()
                    Button("Next Dish") {
                        showNextGame = false
                        selectRandomFood()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                }

            } else {
                VStack {
                    Spacer()
                    selectedDish?.image
                    Spacer()
                    VStack(spacing: 12) {
                        Text("Where is this dish from?")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Time Remaining: \(gameViewModel.timeRemaining)s")
                            .font(.subheadline.bold())
                            .foregroundColor(.red.opacity(0.8))
                            .onAppear {
                                gameViewModel.timerActive = true
                                Timer.scheduledTimer(
                                    withTimeInterval: 1.0,
                                    repeats: true
                                ) { timer in
                                    if gameViewModel.timerActive
                                        && gameViewModel.timeRemaining > 0
                                    {
                                        gameViewModel.timeRemaining -= 1
                                    } else {
                                        timer.invalidate()
                                    }
                                }
                            }

                        Button {
                            showMap.toggle()
                        } label: {
                            Text("Guess on Map")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }

                        //  Clues progressivi
                        if gameViewModel.currentClueIndex
                            < selectedDish!.clues.count
                        {
                            Button {
                                withAnimation(.spring()) {
                                    gameViewModel.currentClueIndex += 1
                                }
                            } label: {
                                Text(
                                    "Show Hint (\(gameViewModel.currentClueIndex + 1)/\(selectedDish!.clues.count))"
                                )
                                .font(.subheadline.bold())
                                .padding(6)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            }
                            .padding(.top, 8)
                        }

                        // Mostra il clue corrente
                        if gameViewModel.currentClueIndex > 0 {
                            Text(
                                selectedDish!.clues[
                                    0..<gameViewModel.currentClueIndex
                                ].joined(separator: " • ")
                            )
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.top, 4)
                            .transition(
                                .opacity.combined(with: .move(edge: .top))
                            )
                        }
                    }

                    .padding()
                }
            }
        }
        .onAppear {
            gameViewModel.nextDish()
        }
        .sheet(isPresented: $showMap) {
            MapGuessView(
                gameViewModel: gameViewModel,
                showResult: $showResult,
                showNextGame: $showNextGame,
                leaderboard: leaderboard
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showResult) {
            ResultView(
                gameViewModel: gameViewModel,
                showNextGame: $showNextGame
            )
            .presentationDetents([.large])
        }
    }
}

#Preview {
    GameView()
        .onAppear {
            viewModel.fetchRecords()
            selectRandomFood()
        }
}
