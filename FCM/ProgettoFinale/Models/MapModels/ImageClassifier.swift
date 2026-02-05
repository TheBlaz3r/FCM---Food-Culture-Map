import CoreML
import SwiftUI
import Vision

class ImageClassifier {
    let model: ResNetFood41_Fixed  // Usa il nuovo modello

    init() {
        if let mlModel = try? ResNetFood41_Fixed(
            configuration: MLModelConfiguration()
        ) {
            model = mlModel
        } else {
            fatalError("Impossibile caricare il modello CoreML")
        }
    }

    func classify(uiImage: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = uiImage.cgImage else {
            completion("Immagine non valida")
            return
        }

        do {
            let vnModel = try VNCoreMLModel(for: model.model)
            let request = VNCoreMLRequest(model: vnModel) { request, error in
                if let error = error {
                    completion("Errore: \(error.localizedDescription)")
                    return
                }

                guard
                    let results = request.results
                        as? [VNClassificationObservation],
                    let first = results.first
                else {
                    completion("Nessun risultato")
                    return
                }

                let confidencePercent = first.confidence * 100
                
                //Retry se confidence < 25%
                if confidencePercent < 25 {
                    completion("Retry")
                    return
                }
                
                // Mostra anche top-3 per debug
                let top3 = results.prefix(3)
                let topResults = top3.map {
                    "\($0.identifier): \(Int($0.confidence * 100))%"
                }
                print(topResults.joined(separator: "\n"))
                completion(
                    "Top results:\n\(topResults.joined(separator: "\n"))"
                )
            }

            // IMPORTANTE: Assicurati che l'immagine sia ridimensionata a 224x224
            request.imageCropAndScaleOption = .centerCrop

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try handler.perform([request])

        } catch {
            completion("Errore CoreML: \(error.localizedDescription)")
        }
    }
}
