//
//  ViewController.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func play(_ sender: UIButton) {
        playButton.isEnabled = false
        
        let boardViews = self.view.subviews.filter { $0 is BoardView }
        precondition(boardViews.count == 1)
        if let boardView = boardViews[0] as? BoardView {
            boardView.play { self.playButton.isEnabled = true }
        }
    }
}

