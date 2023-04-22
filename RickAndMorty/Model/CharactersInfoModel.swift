//
//  CharactersInfoModel.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 19/04/2023.
//

import UIKit

struct CharactersInfoModel {
    static let template: CharactersInfoModel = .init(
        topTitle: "",
        location: "",
        firstSeenDinamic: "",
        episodeModel: "",
        alsoLabel: "",
        statusLabel: "",
        statusImageBorderColor: UIColor.black,
        imageCharacterURL: nil)
    let topTitle: String
    let location: String
    let firstSeenDinamic: String
    let episodeModel: String
    let alsoLabel: String
    let statusLabel: String
    let statusImageBorderColor: UIColor
    let imageCharacterURL: URL?
}
