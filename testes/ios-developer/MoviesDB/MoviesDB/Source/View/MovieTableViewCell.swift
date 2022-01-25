//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Gustavo Rigor on 24/01/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView?
    @IBOutlet weak var movieTitle: UILabel?
    @IBOutlet weak var movieYear: UILabel?
    @IBOutlet weak var movieOverview: UILabel?
    @IBOutlet weak var movieRate: UILabel?
    
    func setCellWithValuesOf(_ movie:Movie){
        var posterUrl = ""
        if let poster = movie.posterPath{
            posterUrl = MovieAPI.build(image: poster, size: .w300)
        }
        updateUI(title: movie.title, releaseDate: movie.releaseDate, rating: movie.voteAverage, overview: movie.overview, poster: posterUrl)
    }
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?){
        self.movieTitle?.text = title
        self.movieYear?.text = releaseDate
        self.movieOverview?.text = overview
        if let rating = rating {
            self.movieRate?.text =  String(rating)
        }
        
        guard let posterUrl = poster, let posterImageUrl = URL(string: posterUrl) else {
            self.moviePoster?.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.moviePoster?.image = nil
        
        getImageFromUrl(url: posterImageUrl)
    }
    
    private func getImageFromUrl(url: URL){
        self.moviePoster?.load(url: url)
    }

}
