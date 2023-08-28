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

final class VideoViewController: UIViewController, VideoViewProtocol, YTPlayerViewDelegate {
    // MARK: - UI Components
    private lazy var videoView: YTPlayerView = {
        let view = YTPlayerView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var presenter: VideoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.load()
    }
    
    func handleOutput(_ output: VideoPresenterOutput) {
        switch output {
        case .showVideo(let id):
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.videoView.load(withVideoId: id)
            }
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoView.playVideo()
    }
    
}

extension VideoViewController {
    private func setupUI() {
        configureNavigationController()
        view.addSubview(videoView)
        videoView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    private func configureNavigationController() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
}
