//
//  ViewController.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttons: UIStackView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var quitButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var undoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Remove the Play button, which is only there for computer vs.
        // computer mode, which isn't even implemented yet. Well, it is, only
        // using the old, non-SpriteKit UI.
        self.playButton.removeFromSuperview()
        
        titleLabel.text = "Gomoku (Creative Mode)"
        
        self.play()
    }

    private func play() {
        let boardViews = self.view.subviews.filter { $0 is BoardView }
        precondition(boardViews.count == 1)
        let boardView = boardViews[0] as! CreativeBoardView
        boardView.play {
//            self.setButtons(showPlayButton: true)
        }
    }

    @IBAction func play(_ sender: UIButton) {
        setButtons(showPlayButton: false)
        self.play()
    }
    
    @IBAction func quit(_ sender: Any) {
        let boardViews = self.view.subviews.filter { $0 is BoardView }
        precondition(boardViews.count == 1)
        let boardView = boardViews[0] as! CreativeBoardView
        boardView.quit()

//        setButtons(showPlayButton: true)
    }
    
    @IBAction func undo(_ sender: Any) {
        let boardViews = self.view.subviews.filter { $0 is BoardView }
        precondition(boardViews.count == 1)
        let boardView = boardViews[0] as! CreativeBoardView
        boardView.undo()
    }

    private func setButtons(showPlayButton: Bool) {
        if showPlayButton {
            assert(playButton.superview == nil)
            buttons.addArrangedSubview(self.playButton)
            self.quitButton.removeFromSuperview()
            self.undoButton.removeFromSuperview()
        } else {
            assert(playButton.superview != nil)
            buttons.addArrangedSubview(undoButton)
            buttons.addArrangedSubview(quitButton)
            playButton.removeFromSuperview()
        }
    }
}

