/*

import SwiftUI
import MapKit

struct MapBackgroundView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43, longitude: 12),
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: MapLocationsData.all) { location in
            MapAnnotation(coordinate: location.coordinate) {
                NavigationLink {
                    Text("Hello World").foregroundStyle(Color.white)
                } label: {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
        }
        .ignoresSafeArea()
    }
}
*/
