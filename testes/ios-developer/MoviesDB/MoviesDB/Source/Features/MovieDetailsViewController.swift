//
//  MovieDetailsViewController.swift
//  MoviesDB
//
//  Created by Gustavo Rigor on 25/01/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView?
    @IBOutlet weak var posterImage: UIImageView?
    @IBOutlet weak var movieTitle: UILabel?
    @IBOutlet weak var movieRuntime: UILabel?
    
    @IBOutlet weak var movieYearTime: UILabel?
    @IBOutlet weak var movieDirector: UILabel?
    @IBOutlet weak var movieNumberVotes: UILabel?
    @IBOutlet weak var movieRating: UILabel?

    @IBOutlet weak var movieOverview: UILabel?

    @IBOutlet weak var movieBudget: UILabel?
    @IBOutlet weak var movieRevenue: UILabel?
    
    //MARK: - ViewModel
    var viewModel = MovieDetailsViewModel()

    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Methods
    private func updateUI(){
        updateUiMovie()
        viewModel.fetchMovieDetailsData { details, director in
            self.movieRuntime?.text = "\(details.runtime) min"
            self.movieDirector?.text = director
            self.movieBudget?.text = "budget: $\(details.budget)"
            self.movieRevenue?.text = "revenue: $\(details.revenue)"
        }
    }
    
    private func updateUiMovie(){
        let movie = viewModel.movie
        var posterUrl = ""
        var backdropUrl = ""
        if let poster = movie?.posterPath, let background = movie?.backdropPath{
            posterUrl = MovieAPI.build(image: poster, size: .w300)
            backdropUrl = MovieAPI.build(image: background, size: .w500)
        }
        self.posterImage?.image = nil
        self.backgroundImage?.image = nil
        if let url = URL(string: posterUrl), let bgUrl = URL(string: backdropUrl){
            self.posterImage?.load(url: url)
            self.backgroundImage?.load(url: bgUrl)
        }
        
        self.movieTitle?.text = movie?.title
        self.movieYearTime?.text = movie?.releaseDate
        self.movieNumberVotes?.text = "\(movie?.voteCount ?? 0) votes"
        self.movieRating?.text = String(movie?.voteAverage ?? 0.0)
        self.movieOverview?.text = movie?.overview
        
    }
    
    

    // MARK: - Actions
    @IBAction func backButtonMovieList(_ sender: Any) {
        if let navigation = self.navigationController{
            navigation.popToRootViewController(animated: true)
        }
    }
    
}
