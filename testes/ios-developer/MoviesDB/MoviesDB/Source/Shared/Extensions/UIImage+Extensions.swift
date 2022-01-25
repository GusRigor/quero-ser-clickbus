//
//  UIImage+Extensions.swift
//  MoviesDB
//
//  Created by Gustavo Rigor on 24/01/22.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        URLSession.shared.dataTask(with: url) { data, responser, error in
            if let error = error {
                print("Datatask erro: \(error.localizedDescription)")
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.image = image
                }
            }

        }.resume()
        
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
    }
}
