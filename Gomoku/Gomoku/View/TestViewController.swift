//
//  TestViewController.swift
//  Gomoku
//
//  Created by Mike Laursen on 1/27/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func play(_ sender: UIButton) {
        playButton.alpha = 0.5
        playButton.isEnabled = false
        
        let boardViews = self.view.subviews.filter { $0 is TestBoardView }
        precondition(boardViews.count == 1)
        let boardView = boardViews[0] as! TestBoardView
        boardView.play {
            self.playButton.alpha = 1.0
            self.playButton.isEnabled = true
        }
    }
}
