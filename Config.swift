//
//  Config.swift
//  Navigation
//
//  Created by TIS Developer on 16.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}

extension Int {
    func convert() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        guard let word = formatter.string(from: NSNumber(value: self)) else {return ""}
        let string = (word.first?.uppercased())! + word.dropFirst()
        return string
    }
}
