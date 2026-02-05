//
//  MapViewRepresentable.swift
//  MOF
//
//  Created by Foundation 53 on 29/01/26.
//

//
//  MapViewRepresentable.swift
//  MapofFood
//
//  Created by Foundation 53 on 29/01/26.
//
import MapKit
import SwiftUI

// Custom annotation class to work with MKMapView
class LocationAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let location: MapLocation

    init(location: MapLocation) {
        self.location = location
        self.coordinate = location.coordinate
        self.title = location.name
        self.subtitle = location.country
        super.init()
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D?
    @Binding var selectedLocation: MapLocation?

    var locations: [MapLocation] = MapLocationsData.all
    var onAnnotationTapped: ((MapLocation) -> Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.mapType = .hybridFlyover
        mapView.delegate = context.coordinator

        let camera = MKMapCamera()
        camera.centerCoordinate = CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        )
        camera.altitude = 80_000_000
        camera.pitch = 60
        camera.heading = 0
        mapView.setCamera(camera, animated: false)

        // Add annotations for all locations
        let annotations = locations.map { LocationAnnotation(location: $0) }
        mapView.addAnnotations(annotations)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        guard let coordinate = centerCoordinate else { return }

        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )

        uiView.setRegion(region, animated: true)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable

        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)
            -> MKAnnotationView?
        {
            guard let locationAnnotation = annotation as? LocationAnnotation
            else { return nil }

            let identifier = "LocationPin"
            var annotationView =
                mapView.dequeueReusableAnnotationView(
                    withIdentifier: identifier
                ) as? MKMarkerAnnotationView

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(
                    annotation: locationAnnotation,
                    reuseIdentifier: identifier
                )
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(
                    type: .detailDisclosure
                )
            } else {
                annotationView?.annotation = locationAnnotation
            }

            annotationView?.markerTintColor = .red
            annotationView?.glyphImage = UIImage(systemName: "fork.knife")

            return annotationView
        }

        func mapView(
            _ mapView: MKMapView,
            annotationView view: MKAnnotationView,
            calloutAccessoryControlTapped control: UIControl
        ) {
            guard
                let locationAnnotation = view.annotation as? LocationAnnotation
            else { return }
            parent.onAnnotationTapped?(locationAnnotation.location)
        }

        // Navigate when pin is tapped directly
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let locationAnnotation = annotation as? LocationAnnotation
            else { return }
            parent.onAnnotationTapped?(locationAnnotation.location)
            parent.selectedLocation = locationAnnotation.location
            filterByCountry(
                foodData: viewModel,
                countryName: locationAnnotation.location.country
            )
            setCountryHabit(
                habits: countryHabitsViewModel,
                countryName: locationAnnotation.location.country
            )
            mapView.deselectAnnotation(annotation, animated: false)
        }
    }
}
