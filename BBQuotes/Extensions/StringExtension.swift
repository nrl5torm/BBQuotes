//
//  StringExtension.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 17/09/2026.
//

import Foundation

extension String {
    func withoutSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }

    func withoutCaseOrSpaces() -> String {
        self.lowercased().withoutSpaces()
    }
}
