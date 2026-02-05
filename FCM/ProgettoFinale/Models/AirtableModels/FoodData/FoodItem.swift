//
//  FoodItem.swift
//  FCM - Food Culture Map
//
//  Created by Foundation 2 on 02/02/26.
//

import SwiftUI

struct FoodItem: Identifiable, Equatable, Hashable {
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id = UUID()
    var name: String
    var image: AirtableImageView
}

struct FoodIMage {
    let imageURLString: String

}

struct AirtableImageView: View {
    let attachment: AirtableAttachment

    var body: some View {
        let url = URL(
            string: attachment.thumbnails?.large?.url ?? attachment.url
        )

        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 120)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)

            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.gray)

            @unknown default:
                EmptyView()
            }
        }
    }
}

struct GameFoodImageView: View {
    let attachment: AirtableAttachment

    var body: some View {
        let url = URL(
            string: attachment.thumbnails?.large?.url ?? attachment.url
        )

        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 120)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 380, height: 400)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                    )

            case .failure:
                ProgressView().scaledToFit().ignoresSafeArea()
            //                Image(systemName: "photo")
            //                    .resizable()
            //                    .scaledToFit()
            //                    .frame(height: 120)
            //                    .foregroundColor(.gray)

            @unknown default:
                EmptyView()
            }
        }
    }
}

struct DetailFoodImageView: View {
    let attachment: AirtableAttachment

    var body: some View {
        let url = URL(
            string: attachment.thumbnails?.large?.url ?? attachment.url
        )

        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 120)

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)  // Riempie lo spazio
                    .frame(width: 350, height: 250)  // Altezza fissa per l'immagine
                    .clipShape(RoundedRectangle(cornerRadius: 15))  // Angoli arrotondati
                    .shadow(radius: 5)  // Una leggera ombreggiatura per profondità
                    .padding(.horizontal)

            case .failure:
                ProgressView().frame(height: 250)
            //                Image(systemName: "photo")
            //                    .resizable()
            //                    .scaledToFit()
            //                    .frame(height: 120)
            //                    .foregroundColor(.gray)

            @unknown default:
                EmptyView()
            }
        }
    }
}

struct SavedFoodImageView: View {
    let attachment: AirtableAttachment

    var body: some View {
        let url = URL(
            string: attachment.thumbnails?.large?.url ?? attachment.url
        )

        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 120)

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )

            case .failure:
                ProgressView().frame(height: 250)
            //                Image(systemName: "photo")
            //                    .resizable()
            //                    .scaledToFit()
            //                    .frame(height: 120)
            //                    .foregroundColor(.gray)

            @unknown default:
                EmptyView()
            }
        }
    }
}
