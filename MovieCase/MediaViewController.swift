//
//  MediaViewController.swift
//  MovieCase
//
//  Created by Bilge Çakar on 22.05.2022.
//

import UIKit
import AVFoundation
import SwiftUI

class MediaViewController: UIViewController {
    
    var movie : Movies?
    
    private var movieName = UILabel()
    
    var player = AVPlayer()
    
    var isPlaying : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let temp = movie
        {
            movieName.text = temp.title
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let videoURL = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
            self.updateUI()
        })
        
    }
    
    private func updateUI()
    {
        //Design movie's name label
        movieName.textColor = .black
        movieName.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        movieName.center = self.view.center
        movieName.numberOfLines = 3
        movieName.frame = CGRect(x: 10, y: -65, width: view.frame.size.width, height: view.frame.size.height)
        self.view.addSubview(movieName)
        
    }
    
    // Pause/resume video
    @IBAction func pauseVideo(_ sender: UIButton) {
        
        if isPlaying
        {
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
            isPlaying = false
            
        }else{
            
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
            isPlaying = true
            
        }
    
    }
    
    //Forward video for 5 s
    @IBAction func forwardVideo(_ sender: UIButton) {
        
        let moveForward : Float64 = 5
 
        if let duration  = player.currentItem?.duration {
                let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
                let newTime = playerCurrentTime + moveForward
                if newTime < CMTimeGetSeconds(duration)
                {
                    let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                    player.seek(to: selectedTime)
                }
                player.pause()
                player.play()
                }
        
        
    }
    
    //Runback video for 5 s
    @IBAction func backVideo(_ sender: UIButton) {
        let moveForward : Float64 = 5
 
        if let duration  = player.currentItem?.duration {
                let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
                let newTime = playerCurrentTime - moveForward
                if newTime < CMTimeGetSeconds(duration)
                {
                    let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                    player.seek(to: selectedTime)
                }
                player.pause()
                player.play()
                }
    }
}
