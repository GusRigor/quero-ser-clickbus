//
//  ViewController.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    private var viewModel = MovieViewModel()
    
    func BaixarExemplos(){
        // EXEMPLO DE COMO OBTER A LISTA DE FILMES POPULARES
        
        MovieListWorker().fetchMovieList(
            section: .popular, page: 1,
            sucess: { response in
                guard let movies = response?.results else { return }
                print(movies.first!)
            },
            failure: { error in
                print(error!)
            })
        
        
        // EXEMPLO DE COMO OBTER OS DETALHES DE UM FILME
        
        MovieDetailsWorker().fetchMovieDetails(
            of: 497582, // COLOQUE O ID DO FILME AQUI
            sucess: { details in
                guard let details = details else { return }
                print(details)
            },
            failure: { error in
                print(error!)
            })
        
        
        // EXEMPLO DE COMO OBTER A LISTA GÊNEROS
        
        GenreListWorker().fetchGenreList(
            sucess: { response in
                guard let genres = response?.genres else { return }
                print(genres)
            },
            failure: { error in
                print(error!)
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPopularMovieData()
    }
    
    private func loadPopularMovieData(){
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView?.dataSource = self
            self?.tableView?.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
}

