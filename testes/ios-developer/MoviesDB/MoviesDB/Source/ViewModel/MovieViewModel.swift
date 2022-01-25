//
//  MovieViewModel.swift
//  MoviesDB
//
//  Created by Gustavo Rigor on 24/01/22.
//

import Foundation

class MovieViewModel{
    
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData( completion: @escaping () -> ()){
        
        MovieListWorker().fetchMovieList(
            section: .popular, page: 1,
            sucess: { response in
                guard let movies = response?.results else { return }
                self.popularMovies = movies
                completion()
            },
            failure: { error in
                print(error!)
            })
    }
    
    func numberOfRowsInSection(section:Int) -> Int{
        return popularMovies.count != 0 ? popularMovies.count : 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie{
        return popularMovies[indexPath.row]
    }
    
    
}
