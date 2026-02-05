//
//  SearchHistory.swift
//  ProgettoFinale
//
//  Created by Foundation 53 on 30/01/26.
//

import SwiftUI
import Foundation
import Combine
class SearchHistory: ObservableObject {
    @Published var history: [String] = []
    
    private let key = "searchHistory"
    
    init() {
        // Carica dal device
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            history = saved
        }
    }
    
    func add(_ term: String) {
        guard !term.isEmpty else { return }
        // Evita duplicati
        if let index = history.firstIndex(of: term) {
            history.remove(at: index)
        }
        history.insert(term, at: 0) // più recenti in cima
        // Limita a 10
        if history.count > 10 { history.removeLast() }
        UserDefaults.standard.set(history, forKey: key)
    }
    
    func clear() {
        history.removeAll()
        UserDefaults.standard.removeObject(forKey: key)
    }
}
