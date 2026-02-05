import SwiftUI
import CoreLocation

struct TitleSearchView: View {
    @Binding var searchText: String
    @StateObject private var speech = SpeechRecognizer()
    var onSearch: (String) -> Void
    @FocusState private var isEditing: Bool
    @State private var searchHistory: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // 🔹 Titolo
            Text("Explore")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.leading)

            // 🔹 Search bar
            TextField("Search countries...", text: $searchText)
                .padding(10)
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .focused($isEditing)
                .onSubmit {
                    saveToHistory(searchText)
                    onSearch(searchText)
                    isEditing = false
                }
                .onChange(of: speech.transcript) { _, newValue in
                    searchText = newValue
                }
                .overlay(
                    HStack {
                        Spacer()

                        // ❌ Clear
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 6)
                        }

                        // 🎙 Microfono
                        Button {
                            if speech.isRecording {
                                speech.stopRecording()
                            } else {
                                speech.startRecording()
                                isEditing = false
                            }
                        } label: {
                            Image(systemName: speech.isRecording ? "mic.fill" : "mic")
                                .foregroundColor(speech.isRecording ? .red : .gray)
                        }
                        .padding(.trailing, 10)
                    }
                )
                .padding(.horizontal)

            // 🔹 CRONOLOGIA (SOLO se tocchi la search bar e non stai scrivendo)
            if isEditing && searchText.isEmpty && !searchHistory.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(searchHistory, id: \.self) { item in
                        Button {
                            searchText = item
                            isEditing = false
                        } label: {
                            Text(item)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                        }
                    }
                }
            }
        }
        .padding(.top, 20)
    }

    // MARK: - History
    private func saveToHistory(_ text: String) {
        guard !text.isEmpty else { return }

        if !searchHistory.contains(text) {
            searchHistory.insert(text, at: 0)
        }

        if searchHistory.count > 5 {
            searchHistory.removeLast()
        }
    }
}

