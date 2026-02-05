//
//  LocationManager.swift
//  MOF
//
//  Created by Foundation 53 on 29/01/26.
//


import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    // Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else { return }
        userLocation = loc.coordinate
        manager.stopUpdatingLocation() // basta una volta
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errore localizzazione:", error.localizedDescription)
    }
}
