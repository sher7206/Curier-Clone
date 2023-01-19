//
//  NetworkMonitorView.swift
//  Paywork
//
//  Created by Asliddin Rasulov on 28/06/22.
//

import UIKit
import Lottie

class NetworkMonitorView: UIViewController {
    
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Set animation content mode
        
        animationView.contentMode = .scaleAspectFit
        
        // 2. Set animation loop mode
        
        animationView.loopMode = .loop
        
        // 3. Adjust animation speed
        
        animationView.animationSpeed = 0.5
        
        // 4. Play animation
        animationView.play()
    }
}
