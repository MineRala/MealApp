//
//  VideoView.swift
//  MealApp
//
//  Created by Mine Rala on 28.08.2023.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol VideoViewProtocol: AnyObject {
    var presenter: VideoPresenterProtocol? { get set }
    
    func handleOutput(_ output: VideoPresenterOutput)
}

final class VideoViewController: UIViewController {
    // MARK: Properties
    private lazy var videoView: YTPlayerView = {
        let view = YTPlayerView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: Attributes
    var presenter: VideoPresenterProtocol?
}

// MARK: - Lifecycle
extension VideoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.load()
    }
}

// MARK: - Setup UI
extension VideoViewController {
    private func configureNavigationController() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupUI() {
        configureNavigationController()
        view.addSubview(videoView)
        videoView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
}

// MARK: - VideoViewProtocol
extension VideoViewController: VideoViewProtocol {
    func handleOutput(_ output: VideoPresenterOutput) {
        switch output {
        case .showVideo(let id):
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.videoView.load(withVideoId: id)
            }
        }
    }
}

// MARK: - YTPlayerViewDelegate
extension VideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoView.playVideo()
    }
}
