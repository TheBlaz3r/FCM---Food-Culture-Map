//
//  FoodSaved.swift
//  MFC - Map Food Culture
//
//  Created by Foundation 3 on 02/02/26.
//
import SwiftUI

struct FoodSavedView: View {
    @Environment(FavoritesManager.self) var favoritesManager

    var body: some View {
        if favoritesManager.savedFoods.isEmpty {
            ContentUnavailableView(
                "No Favorites Yet",
                systemImage: "heart.slash",
                description: Text("Save your favorite foods to see them here.")
            )
        } else {
            List {
                ForEach(favoritesManager.savedFoods) { food in
                    NavigationLink {
                        FoodDetailView(
                            food: food.fields,
                            foodRecord: food
                        )
                        .environment(favoritesManager)  // passiamo lo stesso manager
                    } label: {
                        HStack {
                            if let attachment = food.fields.Image?.first {
                                SavedFoodImageView(attachment: attachment)
                            }

                            Text(food.fields.FoodName ?? "Unknown")
                                .fontWeight(.medium)
                        }
                    }
                }
            }
        }
    }
}
