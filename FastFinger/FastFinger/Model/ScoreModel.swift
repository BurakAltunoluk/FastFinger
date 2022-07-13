//
//  Model.swift
//  FastFinger
//
//  Created by Burak Altunoluk on 10/07/2022.
//

import Foundation

struct ScoreModel {
    var bestScore: Int
    init() {
        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
    }
}
