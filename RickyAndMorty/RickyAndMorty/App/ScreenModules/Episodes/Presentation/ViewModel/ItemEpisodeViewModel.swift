//
//  ItemEpisodeViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/12/23.
//

struct ItemEpisodeViewModel {
    private(set) var episode: Episode
    
    var numEpisode: String {
        "# \(episode.id)"
    }
    
    var name: String {
        episode.name
    }
    
    var airDate: String {
        episode.airDate
    }
    
    var seasonAndEpisode: String {
        episode.episode
    }
}
