//
//  GameMasterViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import WebKit

class GameMasterViewController: UIViewController {

    @IBOutlet weak var blocklyButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    var gameDetailViewController: GameDetailViewController? {
        didSet {
            self.gameView = gameDetailViewController?.webView
        }
    }
    
    var gameView : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func blockly() {
        GVBlocklyCommand(gameView: gameView!).execute({})
    }
    
    @IBAction func clear() {
        GVClearCommand(gameView: gameView!).execute({})
    }
    
    @IBAction func play() {
        GVPlayCommand(gameView: gameView!).execute({})
    }
    
    @IBAction func stop() {
        GVStopCommand(gameView: gameView!).execute({})
    }

    @IBAction func step() {
        GVStepCommand(gameView: gameView!).execute({})
    }
    
    @IBAction func load() {
        GVLoadCommand(gameView: gameView!).execute({})
    }

    @IBAction func save() {
        GVSaveCommand(gameView: gameView!).execute({})
    }
    
    @IBAction func help() {
        GVHelpCommand(gameView: gameView!).execute({})
    }
    
    @IBAction func mute() {
        GVMuteCommand(gameView: gameView!).execute({})
    }
    @IBAction func quit() {
        GVQuitCommand(gameView: gameView!).execute({})
    }
}
