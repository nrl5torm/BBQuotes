//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Olivier Sbg on 08/09/2026.
//

import Foundation

@Observable
@MainActor
public class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case quoteFetched
        case episodeFetched
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    private let fetcher = Fetcher()
    
    var quote: Quote
    var character: Character
    var episode: Episode
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(
            forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(
                forResource: "samplecharacter", withExtension: "json")!)
        
        character = try! decoder.decode(Character.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(
            forResource: "sampleepisode", withExtension: "json")!)
        
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }
    
    public func getQuote(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            if let unwrapped = try await fetcher.fetchCharacter(quote.character) {
                character = unwrapped
                character.death = try await fetcher.fetchDeath(for: character.name)
            } else {
                character = Character(name: quote.character)
            }
            
            status = .quoteFetched
        } catch {
            status = .failed(error: error)
        }
    }
    
    // UGLY todo move to separate view model
    public func getEpisode(for show: String) async {
        status = .fetching
        
        do {
            if let unwrapped = try await fetcher.fetchEpisode(from: show) {
                episode = unwrapped
            }
            status = .episodeFetched
            
        } catch {
            status = .failed(error: error)
        }
    }
}
