//
//  Utils.swift
//  ProgettoFinale
//
//  Created by Foundation 2 on 03/02/26.
//

func filterByCountry(foodData: RecordsViewModel, countryName: String) {
    foodItemData.removeAll()
    foodFields.removeAll()
    for category in foodsCategory.keys {
        foodsCategory[category]? = []
//        foodsFieldCategory[category]? = []
    }
    foodData.fetchRecords()
    for record in foodData.records {
        if record.fields.Country == countryName {
            let food = record.fields
            if let attachment = record.fields.Image?.first {
                let foodImage = AirtableImageView(attachment: attachment)

                foodItemData.append(
                    FoodItem(
                        name: food.FoodName ?? "Unknown",
                        image: foodImage
                    )
                )
                foodFields.append(record.fields)
            }
        }
    }
    sortByCategory(foodData: foodFields, foodItems: foodItemData)
}

func setCountryHabit(habits: RecordsViewModel2, countryName: String) {
    for record in habits.records {
        if record.fields.CountryName == countryName {
            countryHabit = record.fields.Habit!
        }
    }
}

func sortByCategory(foodData: [Fields], foodItems: [FoodItem]) {

    for (index, food) in foodData.enumerated() {
        let foodItem: FoodItem = foodItems[index]
        foodsCategory[food.DishType!]?.append(foodItem)
//        foodsFieldCategory[food.DishType!]?.append(food)
    }
}

var foodItemData: [FoodItem] = []
var foodFields: [Fields] = []
var countryHabit: String = ""
//var foodsFieldCategory: [String: [Fields]] = [
//    "First": [],
//    "Second": [],
//    "Side": [],
//    "Appetizer": [],
//    "Dessert": [],
//]
var foodsCategory: [String: [FoodItem]] = [
    "Traditional": [],
    "Main courses": [],
    "Second dishes": [],
    "Side": [],
    "Appetizer": [],
    "Dessert": [],
]
var viewModel: RecordsViewModel = RecordsViewModel()
var countryHabitsViewModel: RecordsViewModel2 = RecordsViewModel2()
var manager: FavoritesManager = FavoritesManager()
