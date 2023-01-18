

import UIKit
import Lottie


public class Loader {
    
    ///Shows custom Alert for a while
    class func start() {

        let loadV = LoaderView()
        loadV.tag = 19995
        loadV.frame = UIScreen.main.bounds
        let customView = LottieAnimationView()
        customView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                
        loadV.animationView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.centerXAnchor.constraint(equalTo: loadV.animationView.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: loadV.animationView.centerYAnchor).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        customView.backgroundColor = .clear
        if let view = UIApplication.shared.keyWindow {
            view.addSubview(loadV)
            customView.animation = LottieAnimation.named("loader")
            customView.animationSpeed = 1.5
            customView.loopMode = .loop
            customView.play()
        }
    }
    class func stop() {
        DispatchQueue.main.async {
            for i in UIApplication.shared.keyWindow!.subviews {
                if i.tag == 19995 {
                    if let view = i as? LoaderView {
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
}


class LoaderView: UIView {
    
    var animationView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        animationView.clipsToBounds = true
        animationView.cornerRadius = 12
        animationView.backgroundColor = UIColor(named: "white300")
        self.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
