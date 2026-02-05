//
//  FilteredListView.swift
//  MOF
//
//  Created by Foundation 53 on 29/01/26.
//
import SwiftUI
import MapKit

struct FilteredListView: View {
    let countries: [String]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(countries, id: \.self) { country in
                    Text(country)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.top, 150) // sotto la search bar
    }
}
