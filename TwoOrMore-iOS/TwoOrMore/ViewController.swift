//
//  ViewController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 4/14/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player : AVPlayer?
    var song : AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // put link to prayer music here instead
        let url = NSURL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        song = AVPlayerItem(URL: url!)
        player = AVPlayer(playerItem: song!)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRectMake(0, 0, 10, 50)
        self.view.layer.addSublayer(playerLayer)
    }

    override func viewDidAppear(animated: Bool) {
        player!.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

