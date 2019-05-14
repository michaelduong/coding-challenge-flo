//
//  Constants.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

// MARK: - Fonts
/// Instance which conforms to this protocol can be used as the
/// font name.
protocol FontNameConvertible {
    var rawValue: String { get }
}

enum Font {
    enum Gotham: String, FontNameConvertible {
        case bold = "Gotham-Bold"
        case medium = "Gotham-Medium"
    }
}

// MARK: - Jugs
let xJugIdentifier = "X"
let yJugIdentifier = "Y"

