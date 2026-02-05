//
//  MapLocationsData.swift
//  ProgettoFinale
//
//  Created by Foundation 53 on 30/01/26.
//


import MapKit

enum MapLocationsData {
    static let all: [MapLocation] = [
        MapLocation(
            name: "Italy",
            coordinate: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964),
            country: "Italy 🇮🇹"
        ),
        MapLocation(
            name: "Iran",
            coordinate: CLLocationCoordinate2D(latitude: 35.718712777384525, longitude: 51.33789310324926),
            country: "Iran 🇮🇷"
        ),
        MapLocation(
            name: "Japan",
            coordinate: CLLocationCoordinate2D(latitude: 35.68263334549678,  longitude: 139.757335289239),
            country: "Japan 🇯🇵"
        ),
        MapLocation(
            name: "Mexico",
            coordinate: CLLocationCoordinate2D(latitude: 19.342683130642317,  longitude:  -99.10412712036678),
            country: "Mexico 🇲🇽"
        ),
        MapLocation(
            name: "Bangladesh",
            coordinate: CLLocationCoordinate2D(latitude: 23.800227674709525,   longitude:  90.4074794055365),
            country: "Bangladesh 🇧🇩"
        )
    ]
}



let countryLocations: [String: CLLocationCoordinate2D] = [
    "Italy 🇮🇹": CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964),
    "Iran 🇮🇷": CLLocationCoordinate2D(latitude: 35.718712777384525, longitude: 51.33789310324926),
    "Japan 🇯🇵": CLLocationCoordinate2D(latitude: 35.68263334549678,  longitude: 139.757335289239),
    "Mexico 🇲🇽": CLLocationCoordinate2D(latitude: 19.342683130642317,  longitude:  -99.10412712036678),
    "Bangladesh 🇧🇩": CLLocationCoordinate2D(latitude: 23.800227674709525,   longitude:  90.4074794055365),
]
