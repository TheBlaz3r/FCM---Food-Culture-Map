//
//  MapView.swift
//  MOF
//
//  Created by Foundation 53 on 29/01/26.
//

//
//  MapView.swift
//  MapofFood
//
//  Created by Foundation 53 on 29/01/26.
//

import MapKit
import SwiftUI

struct MapView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D?
    @Binding var selectedLocation: MapLocation?

    @State private var locationManager = LocationManager()

    var body: some View {
        ZStack {
            MapViewRepresentable(
                centerCoordinate: $centerCoordinate,
                selectedLocation: $selectedLocation,
            )
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // 🔹 Bottone in basso a destra
                    Button(action: {
                        locationManager.requestLocation()
                        Task {
                            viewModel.fetchRecords()
                            try? await Task.sleep(for: .seconds(1.2))
                            //HARD-CODED DA MODIFICARE IN FUTURO
                            selectedLocation = MapLocation(
                                name: "Italy",
                                coordinate: CLLocationCoordinate2D(
                                    latitude: 41.9028,
                                    longitude: 12.4964
                                ),
                                country: "Italy 🇮🇹"
                            )
                            filterByCountry(
                                foodData: viewModel,
                                countryName: selectedLocation!.country
                            )
                            setCountryHabit(
                                habits: countryHabitsViewModel,
                                countryName: selectedLocation!.country
                            )
                        }
                    }) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
                }
            }
        }
        .onReceive(locationManager.$userLocation) { loc in
            if let loc = loc {
                centerCoordinate = loc
            }
        }
    }
}

#Preview {
    MapView(
        centerCoordinate: .constant(nil),
        selectedLocation: .constant(nil),
    )
}
