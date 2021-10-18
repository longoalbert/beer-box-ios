//
//  Beer.swift
//  BeerBox
//
//  Created by Alberto Longo on 14/10/21.
//

import Foundation


struct Beer {
    
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let imageUrl: String?
    let abv: Float
    let ibu: Float?
    let targetFg: Int?
    let targetOg: Float?
    let ebc: Float?
    let srm: Float?
    let ph: Float?
    let attenuationLevel: Float?
    let brewersTips: String
    let contributedBy: String
    let volume: Volume
    let boilVolume: Volume
    
    
    struct Volume {
        let value: Int
        let unit: String
    }
    
}
