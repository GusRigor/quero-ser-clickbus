//
//  MovieDetailsViewModel.swift
//  MoviesDB
//
//  Created by Gustavo Rigor on 25/01/22.
//

import Foundation

class MovieDetailsViewModel{
    
    var movie: Movie?
    
    func fetchMovieDetailsData( completion: @escaping (MovieDetails, String) -> ()){
        guard let movieId = movie?.id else { return }
        MovieDetailsWorker().fetchMovieDetails(
            of: movieId, // COLOQUE O ID DO FILME AQUI
            sucess: { details in
                guard let details = details else { return }
                completion(details, self.getDirector(details: details))
            },
            failure: { error in
                print(error!)
            })
    }
    
    private func getDirector(details: MovieDetails) -> String{
        let crew = details.credits.crew
        for person in crew{
            if person.job == "Director"{
                return person.name
            }
        }
        return ""
    }
    
}
