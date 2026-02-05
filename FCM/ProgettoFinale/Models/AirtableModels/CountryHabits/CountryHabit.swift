//
//  FoodItem.swift
//  FCM - Food Culture Map
//
//  Created by Foundation 2 on 02/02/26.
//

import SwiftUI

struct AirtableResponse2: Decodable {
    let records: [HabitRecord]  // `records` represents an array of `Record` objects retrieved from Airtable.
}

struct HabitRecord: Identifiable, Decodable {
    var id: String
    var fields: HabitFields
}

struct HabitFields: Decodable {
    var CountryName: String?
    var Habit: String?
}


// A single record in Airtable, which conforms to both `Identifiable` and `Decodable`.
