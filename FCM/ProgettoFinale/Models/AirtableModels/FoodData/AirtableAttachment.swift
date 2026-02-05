//
//  AirtableAttachment.swift
//  FoodGlobe
//
//  Created by You on 2026-01-30.
//

import Foundation

struct AirtableAttachment: Codable, Identifiable {
    
    // MARK: - Properties
    let id: String
    let url: String
    let filename: String
    let size: Int?
    let type: String?
    let thumbnails: Thumbnails?
    
    // MARK: - Thumbnails
    struct Thumbnails: Codable {
        let small: Thumbnail?
        let large: Thumbnail?
        let full: Thumbnail?
    }
    
    struct Thumbnail: Codable {
        let url: String
        let width: Int
        let height: Int
    }
}
