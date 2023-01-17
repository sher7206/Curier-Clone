//
//  SkretchableHeaderView.swift
//  Express Courier
//
//  Created by apple on 17/01/23.
//

import UIKit

class SkretchableHeaderView: UIView {

    public let v = UIView()
    
    var vH = NSLayoutConstraint()
    var vB = NSLayoutConstraint()
    var containerView = UIView()
    var conteinerH = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatViews()
        setCOnstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func creatViews(){
        addSubview(containerView)
        containerView.addSubview(v)
    }
    func setCOnstraints(){
        
        NSLayoutConstraint.activate([widthAnchor.constraint(equalTo:
                                                                containerView.widthAnchor),
                                     centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     heightAnchor.constraint(equalTo: containerView.heightAnchor)
                                    ])
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: v.widthAnchor).isActive = true
        conteinerH = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        conteinerH.isActive = true
        
        v.translatesAutoresizingMaskIntoConstraints = false
        vB = v.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        vB.isActive = true
        vH = v.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        vH.isActive = true
    }


    public func crollViewDidScroll(scrollView: UIScrollView){
        conteinerH.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        vB.constant = offsetY >= 0 ? 0 : -offsetY/2
        vH.constant = max(offsetY+scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
