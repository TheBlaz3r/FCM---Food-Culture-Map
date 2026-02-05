import MapKit
import SwiftUI

struct GameMapViewRepresentable: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var userGuess: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        // Gesture recognizer per ottenere tap
        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)

        // Aggiorniamo il pin
        uiView.removeAnnotations(uiView.annotations)
        if let coord = userGuess {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: GameMapViewRepresentable

        init(_ parent: GameMapViewRepresentable) {
            self.parent = parent
        }

        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let mapView = gestureRecognizer.view as! MKMapView
            let point = gestureRecognizer.location(in: mapView)
            let coord = mapView.convert(point, toCoordinateFrom: mapView)

            // Aggiorniamo la bind
            parent.userGuess = coord
        }
    }
}
