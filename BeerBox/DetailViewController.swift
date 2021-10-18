//
//  DetailViewController.swift
//  BeerBox
//
//  Created by Alberto Longo on 15/10/21.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTypeLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    var beer: Beer?
    
    
    override func viewDidLoad() {
        
        if let beer = beer {
            if let imageUrl = beer.imageUrl {
                beerImageView.kf.setImage(with: URL(string: imageUrl))
            }
            beerNameLabel.text = beer.name
            beerTypeLabel.text = beer.tagline
            beerDescriptionLabel.text = beer.description
        }
    }
    
}
