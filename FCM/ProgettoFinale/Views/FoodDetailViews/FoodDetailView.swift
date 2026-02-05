//
//  FoodDetailView.swift
//  MFC - Map Food Culture
//
//  Created by Foundation 3 on 29/01/26.
//
import SwiftUI

struct FoodDetailView: View {
    let food: Fields
    let foodRecord: Record

    @Environment(\.dismiss) var dismiss
    @Environment(FavoritesManager.self) var favoritesManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Nome cibo
                Text(food.FoodName ?? "Unknown Food")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 10)

                // Immagine
                if let attachment = food.Image?.first {
                    DetailFoodImageView(attachment: attachment)
                }

                // Paese / città
                HStack {
                    Image(systemName: "globe.europe.africa.fill")
                        .foregroundColor(.blue)
                    Text("\(food.Country ?? "Unknown") \(food.City ?? "")")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Allergeni
                if let allergens = food.Allergens {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("⚠️ Allergens:")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)

                        Text(allergens)
                            .font(.system(.callout, design: .monospaced))
                            .fontWeight(.semibold)
                            .foregroundStyle(.red.opacity(0.8))
                            .padding(10)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                }

                Divider()
                    .padding(.horizontal)

                // Ricetta
                if let recipe = food.Recipe {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recipe")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text(recipe)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(6)
                    }
                    .padding(.horizontal)
                }

                Spacer(minLength: 50)
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()

                    withAnimation(.snappy) {
                        favoritesManager.toggleFavorite(food: foodRecord)
                    }

                    // ⚡ Se abbiamo rimosso dai preferiti, torniamo indietro
                    if !favoritesManager.isFavorite(foodRecord) {
                        dismiss()
                    }

                }) {
                    Image(
                        systemName: favoritesManager.isFavorite(foodRecord)
                            ? "heart.fill" : "heart"
                    )
                    .foregroundStyle(
                        favoritesManager.isFavorite(foodRecord) ? .red : .blue
                    )
                    .font(.title3)
                    .symbolEffect(
                        .bounce,
                        value: favoritesManager.isFavorite(foodRecord)
                    )
                }
            }
        }
    }
}
