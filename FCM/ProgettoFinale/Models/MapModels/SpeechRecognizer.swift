//
//  SpeechRecognizer.swift
//  ProgettoFinale
//
//  Created by Foundation 53 on 30/01/26.
//


import Foundation
import Speech
import AVFoundation
import Combine
import Speech
import AVFAudio


final class SpeechRecognizer: ObservableObject {

    @Published var transcript = ""
    @Published var isRecording = false

    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "it-IT"))
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func startRecording() {
        guard !isRecording else { return }   // ⛔️ evita doppio start

        AVAudioApplication.requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    self.startSession()
                }
            }
        }
    }

    private func startSession() {
        isRecording = true
        transcript = ""

        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request else { return }

        let inputNode = audioEngine.inputNode

        // 🔴 SICUREZZA: rimuove eventuali tap esistenti
        inputNode.removeTap(onBus: 0)

        request.shouldReportPartialResults = true

        task = recognizer?.recognitionTask(with: request) { result, error in
            if let result {
                self.transcript = result.bestTranscription.formattedString
            }
        }

        let format = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: format
        ) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()
    }

    func stopRecording() {
        guard isRecording else { return }   // ⛔️ evita doppio stop

        isRecording = false

        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)

        request?.endAudio()
        task?.cancel()

        request = nil
        task = nil
    }
}
