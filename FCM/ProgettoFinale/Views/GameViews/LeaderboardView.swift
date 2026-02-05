import SwiftUI

struct LeaderboardView: View {
    var scores: [Int]

    var body: some View {
        VStack(alignment: .leading) {
            Text("History Scores")
                .font(.headline)
                .padding(.bottom, 4)

            ForEach(Array(scores.enumerated()), id: \.offset) { index, score in
                HStack {
                    Text("\(index + 1).")
                        .bold()
                    Text("\(score) pts")
                }
                .padding(4)
                .background(
                    index == 0
                        ? Color.yellow.opacity(0.3) : Color.gray.opacity(0.2)
                )
                .cornerRadius(8)
            }
        }
        .padding(.top)
    }
}
