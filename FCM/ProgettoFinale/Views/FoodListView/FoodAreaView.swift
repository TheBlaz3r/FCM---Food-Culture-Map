//
//  FoodAreaView.swift
//  FCM - Food Culture Map
//
//  Created by Foundation 2 on 29/01/26.
//

import SwiftUI

//var viewModel: RecordsViewModel = RecordsViewModel()

struct FoodAreaView: View {
    @State private var selectedFood: Record?

    let countryName: String
    let description: String
    //        "In Italy, people usually start with first dishes (like pasta) and then move on to second dishes (meat, fish)."

    // Food categories: array of (categoryName, foods)
    //    var foodsFieldCategory: [String: [Fields]]
    var foodsCategory: [String: [FoodItem]]
    var categoryOrder: [String] = [
        "Traditional", "Appetizer", "Main courses", "Second dishes", "Side", "Dessert",
    ]

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    // Country name
                    Text(countryName)
                        .font(.largeTitle)
                        .bold()

                    // Eating description
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)

                    Divider()

                    ForEach(categoryOrder, id: \.self) { categoryName in
                        if (foodsCategory[categoryName]?.isEmpty) == false {
                            FoodCategoryRow(
                                categoryName: categoryName,
                                foods: foodsCategory[categoryName]!,
                                selectedFood: $selectedFood
                                    //                                foodFields: foodsFieldCategory[categoryName]!
                            )
                        }
                    }

                }
                .padding()
            }
            .navigationDestination(item: $selectedFood) { food in
                FoodDetailView(food: food.fields, foodRecord: food)
                    .environment(manager)
            }
        }
    }
}

// MARK: - Food Category Row
struct FoodCategoryRow: View {
    let categoryName: String
    let foods: [FoodItem]
    @Binding var selectedFood: Record?

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title2)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(foods) { food in
                        VStack {
                            food.image

                            Text(food.name)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 120)
                        .onTapGesture {
                            if let match = viewModel.records.first(where: {
                                $0.fields.FoodName == food.name
                            }) {
                                selectedFood = match
                            }
                        }

                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

// MARK: - FoodItem Model
