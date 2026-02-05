//
//  TopGradientView.swift
//  MOF
//
//  Created by Foundation 53 on 29/01/26.
//

import SwiftUI
import MapKit
struct TopGradientView: View {
    var body: some View {
        LinearGradient(
            colors: [Color.black.opacity(0.6), Color.black.opacity(0)],
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 150)
        .ignoresSafeArea(edges: .top)
    }
}
