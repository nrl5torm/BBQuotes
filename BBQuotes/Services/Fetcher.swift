//
//  DataFetcher.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 08/09/2026.
//

import Foundation

struct Fetcher {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseApiURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    public func fetchQuote(from show: String) async throws -> Quote {
        // build URL
        let quoteURL = baseApiURL.appending(path: "quotes/random")
            .appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: quoteURL)
        
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    public func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseApiURL.appending(path: "characters")
            .appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: characterURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Character].self, from: data)
        
        guard characters.count == 1 else {
            throw FetchError.badResponse
        }
        return characters[0]
    }
    
    public func fetchDeath(for character: String) async throws -> Death? {
        let deathURL = baseApiURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: deathURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil
    }
}
