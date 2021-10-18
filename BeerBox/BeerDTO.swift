//
//  BeerDTO.swift
//  BeerBox
//
//  Created by Alberto Longo on 14/10/21.
//

import Foundation


struct BeerDTO: Decodable, DomainModel {
    
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
    let volume: VolumeDTO
    let boilVolume: VolumeDTO
    
    
    struct VolumeDTO: Decodable, DomainModel {
        
        let value: Int
        let unit: String
        
        func toDomainModel() -> Beer.Volume {
            return Beer.Volume(
                value: self.value,
                unit: self.unit
            )
        }
        
    }
        
    func toDomainModel() -> Beer {
        return Beer(
            id: self.id,
            name: self.name,
            tagline: self.tagline,
            firstBrewed: self.firstBrewed,
            description: self.description,
            imageUrl: self.imageUrl,
            abv: self.abv,
            ibu: self.ibu,
            targetFg: self.targetFg,
            targetOg: self.targetOg,
            ebc: self.ebc,
            srm: self.srm,
            ph: self.ph,
            attenuationLevel: self.attenuationLevel,
            brewersTips: self.brewersTips,
            contributedBy: self.contributedBy,
            volume: self.volume.toDomainModel(),
            boilVolume: self.boilVolume.toDomainModel()
        )
    }
    
}
