import MapKit
import SwiftUI

struct ContentView: View {

    @State private var searchText = ""
    @State private var centerCoordinate: CLLocationCoordinate2D? = nil
    @State private var selectedLocation: MapLocation? = nil

    var filteredCountries: [String] {
        if searchText.isEmpty { return CountriesData.all }
        return CountriesData.all.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        TabView {
            // Tab 1: Explore
            NavigationStack {
                ZStack(alignment: .top) {
                    Color.black.ignoresSafeArea()
                    MapView(
                        centerCoordinate: $centerCoordinate,
                        selectedLocation: $selectedLocation,
                    )
                    TopGradientView()
                    TitleSearchView(
                        searchText: $searchText,
                        onSearch: { text in
                            geocode(text)
                        }
                    )
                    if !filteredCountries.isEmpty && !searchText.isEmpty {
                        FilteredListView(countries: filteredCountries)
                    }
                }
                .sheet(item: $selectedLocation) { location in
                    FoodAreaView(
                        countryName: location.country,
                        description: countryHabit,
                        foodsCategory: foodsCategory,
                    )
                }.presentationDetents([.medium, .large])
            }
            .tabItem {
                Label("Explore", systemImage: "map.fill")
            }

            // Tab 2: Games
            NavigationStack {
                GameView()
                    //                Text("Games")
                    .navigationTitle("Game")
            }
            .onAppear {
                selectRandomFood()
            }
            .tabItem {
                Label("Game", systemImage: "gamecontroller.fill")
            }

            // Tab 3: Camera Classifier
            NavigationStack {
                CameraView()
                    .navigationTitle("Detect")

            }
            .tabItem {
                Label("Detect", systemImage: "camera.viewfinder")
            }

            // Tab 4: Liked
            NavigationStack {
                FoodSavedView()
                    .environment(manager)
                    .navigationTitle("Liked")
            }
            .tabItem {
                Label("Liked", systemImage: "heart.fill")
            }

        }
        .onAppear {
            viewModel.fetchRecords()
            countryHabitsViewModel.fetchRecords()
        }
    }

    func geocode(_ text: String) {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(text) { placemarks, error in
            guard let coordinate = placemarks?.first?.location?.coordinate
            else {
                print("❌ No results")
                return
            }

            DispatchQueue.main.async {
                centerCoordinate = coordinate
            }
        }
    }
}

#Preview {
    ContentView()
}
