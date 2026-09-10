//
//  Death.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 07/09/2026.
//
import Foundation

struct Death: Decodable {
    let character: String
    
    let image: URL
    let details: String
    let lastWords: String
}
