//
//  Record.swift
//  Airtable
//
//  Created by Giusy Di Paola on 02/01/25.
//

//MARK: AIRTABLE DOCUMENTATION: https://airtable.com/developers/web/api/introduction

import Foundation  // Importing Foundation, which provides essential data types and functionalities for our app.

// Struct to decode the JSON response from Airtable.
struct AirtableResponse: Decodable {
    let records: [Record]  // `records` represents an array of `Record` objects retrieved from Airtable.
}

// A single record in Airtable, which conforms to both `Identifiable` and `Decodable`.
struct Record: Identifiable, Decodable, Hashable {
    var id: String  // Each record has a unique `id` provided by Airtable.
    var fields: Fields  // The `fields` property contains the data (e.g., Name and Surname) stored in the record.
    
    static func == (lhs: Record, rhs: Record) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// The structure that represents the data fields within an Airtable record.
struct Fields: Decodable {
    var FoodName: String?  // The Name field in Airtable, which is optional because it might not always exist.
    var Image: [AirtableAttachment]?
    var Country: String?  // The Surname field in Airtable, also optional.
    var City: String?  // The Surname field in Airtable, also optional.
    var Description: String?  // The Surname field in Airtable, also optional.
    var DishType: String?  // The Surname field in Airtable, also optional.
    var Clues: String?
    var Allergens: String?
    var Recipe: String?
}

// MARK: Key Learning Points:
/**

 AirtableResponse: This struct is used to decode the overall response from Airtable, which typically contains a list of records.

 Record: Each record corresponds to a row in your Airtable base.
 It conforms to Identifiable, making it easier to use in SwiftUI lists (like in a ForEach loop).
 It also conforms to Decodable, which allows us to parse JSON data into this structure.

 Fields: Represents the actual data fields of a record. The properties (Name and Surname) are optional to avoid runtime errors if the data is incomplete in Airtable.

 Connecting to Airtable:
 This model mirrors the structure of the Airtable JSON response, making it easy to fetch and decode data into Swift structures.
 Once this model is defined, you can use it to fetch data from Airtable's API and display it in your app.

 */
