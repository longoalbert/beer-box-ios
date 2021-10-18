//
//  BeerTableViewCell.swift
//  BeerBox
//
//  Created by Alberto Longo on 14/10/21.
//

import UIKit


class BeerTableViewCell: UITableViewCell {

    static let identifier = "Beer cell identifier"
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTypeLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
}
