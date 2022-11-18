//
//  DetailsViewController.swift
//  AppCarros
//
//  Created by Igor Fernandes on 18/11/22.
//

import UIKit
import AVKit
import AVFoundation

class DetailsViewController: UIViewController {
    let playerViewController = AVPlayerViewController()
    var cars: CarInfo
    
    init?(coder: NSCoder, cars: CarInfo) {
        self.cars = cars
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        addTapGesture()
        setVideoPlayer()
    }
    
    func setVideoPlayer() {
        if let video = cars.urlVideo {
            let videoURL = URL(string: video)
            let player = AVPlayer(url: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = videoContainerView.bounds
            videoContainerView.layer.addSublayer(playerLayer)
            
            playerViewController.player = player
        }
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapVideo))
        videoContainerView.addGestureRecognizer(tap)
    }
    
    @objc func didTapVideo() {
        present(playerViewController, animated: true)
        playerViewController.player?.play()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsTableViewCell.nib(), forCellReuseIdentifier: DetailsTableViewCell.identifier)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
        cell.configure(with: cars)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
