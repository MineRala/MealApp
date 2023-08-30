//
//  VideoInteractor.swift
//  MealApp
//
//  Created by Mine Rala on 28.08.2023.
//

import Foundation

protocol VideoInteractorProtocol: AnyObject {
    var delegate: VideoInteractorDelegate? { get set }
   
    func load(url: String)
}

protocol VideoInteractorDelegate: AnyObject {
    func handleOutput(_ output: VideoInteractorOutput)
}

enum VideoInteractorOutput {
    case showVideo(String)
}

final class VideoInteractor: VideoInteractorProtocol {
    // MARK: Attributes
    public weak var delegate: VideoInteractorDelegate?
    
    func load(url: String) {
        delegate?.handleOutput(.showVideo(url.getVideoID()))
    }
}
