//
//  MapLocation.swift
//  ProgettoFinale
//
//  Created by Foundation 53 on 30/01/26.
//


import Foundation
import MapKit
import SwiftUI

struct MapLocation: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let country: String

    static func == (lhs: MapLocation, rhs: MapLocation) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Detail view shown when a pin is tapped
struct LocationDetailView: View {
    let location: MapLocation

    var body: some View {
        VStack {
            Text(location.name)
                .font(.largeTitle)
                .bold()
            Text(location.country)
                .font(.title2)
                .foregroundStyle(.secondary)
        }
        .navigationTitle(location.name)
    }
}

#Preview {
    LocationDetailView(location: MapLocation(
        name: "Roma",
        coordinate: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964),
        country: "Italia"
    ))
}
