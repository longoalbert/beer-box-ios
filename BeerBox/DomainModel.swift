//
//  DomainModel.swift
//  BeerBox
//
//  Created by Alberto Longo on 14/10/21.
//

import Foundation


protocol DomainModel {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
