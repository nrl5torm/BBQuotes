//
//  DataFetcher.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 08/09/2026.
//

import Foundation

class Fetcher {
    private enum FetchError: Int, Error {
        case badResponse = 99
    }
    
    private let baseApiURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    private var useQuoteApi = false
    
    private func fetchApiQuote(from show: String) async throws -> Quote {
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
    
    private func fetchLocalBBQuote() async throws -> Quote {
        //TODO store results (also for images and characters!)
        let quotesData = try! Data(contentsOf: Bundle.main.url(
            forResource: "bbquotes", withExtension: "json")!)
        let quotes = try JSONDecoder().decode([Quote].self, from: quotesData)
        
        return quotes.randomElement()!
    }
    
    public func fetchQuote(from show: String) async throws -> Quote {
        if show == Constants.breakingBad {
            useQuoteApi.toggle()
        } else {
            useQuoteApi = true
        }
        
        if useQuoteApi {
            return try await fetchApiQuote(from: show)
        }
        return try await fetchLocalBBQuote()
    }
    
    public func fetchCharacter(_ name: String) async throws -> Character? {
        let characterURL = baseApiURL.appending(path: "characters")
            .appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: characterURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            if let unwrapped = response as? HTTPURLResponse {
                if unwrapped.statusCode == 404 {
                    return nil
                }
            }
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
    
    public func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeURL = baseApiURL.appending(path: "episodes")
            .appending(queryItems: [URLQueryItem(name: "production", value: show)])

        let (data, response) = try await URLSession.shared.data(from: episodeURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let episodes = try decoder.decode([Episode].self, from: data)
        
        guard !episodes.isEmpty else {
            throw FetchError.badResponse
        }
        return episodes.randomElement()
    }
}
