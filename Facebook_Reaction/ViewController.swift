//
//  ViewController.swift
//  Facebook_Reaction
//
//  Created by Ikechukwu Michael on 07/07/2018.
//  Copyright © 2018 Anyskills.co.uk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "fb_core_data_bg"))
        return imageView
        
    }()
    
    let likeImageView: UIImageView = {
       let likeView = UIImageView(image: #imageLiteral(resourceName: "blue_like"))
        return likeView
    }()
    
    let loveImageView: UIImageView = {
        let loveView = UIImageView(image: #imageLiteral(resourceName: "red_heart"))
            loveView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return loveView
    }()
    
    let cryImageView: UIImageView = {
        let cryView = UIImageView(image: #imageLiteral(resourceName: "cry"))
        return cryView
    }()
    
    let laughImageView: UIImageView = {
        let laughView = UIImageView(image: #imageLiteral(resourceName: "cry_laugh"))
        return laughView
    }()
    let suprisedImageView: UIImageView = {
        let surprisedView = UIImageView(image: #imageLiteral(resourceName: "surprised"))
        return surprisedView
    }()
    
    let stackView: UIStackView = {
        let stackedView = UIStackView()
        stackedView.axis = .horizontal
        
        stackedView.distribution = .fillEqually
        stackedView.backgroundColor = .white
        stackedView.spacing = 2
        
        return stackedView
    }()
    
    let iconContainerView: UIView = {
       let iconViews = UIView()
        iconViews.backgroundColor = .white
        iconViews.layer.cornerRadius = 20
        iconViews.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        return iconViews
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        setUpLongPressGesture()
        stackView.frame = iconContainerView.frame
        stackView.addArrangedSubview(likeImageView)
        stackView.addArrangedSubview(loveImageView)
        stackView.addArrangedSubview(laughImageView)
        stackView.addArrangedSubview(suprisedImageView)
        stackView.addArrangedSubview(cryImageView)
        iconContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        var viewConstraints = [NSLayoutConstraint]()
        
        let constraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": stackView])
        let constraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": stackView])
        viewConstraints += constraint1
        viewConstraints += constraint2
        NSLayoutConstraint.activate(viewConstraints)
        
    }

    fileprivate func setUpLongPressGesture(){
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    
    fileprivate func handleGesture(gesture: UILongPressGestureRecognizer){
        view.addSubview(iconContainerView)
        let centerX = iconContainerView.frame.width / 2
        let location = gesture.location(in: self.view)
        self.iconContainerView.transform = CGAffineTransform(translationX: centerX, y: location.y)
        self.iconContainerView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations : {
            self.iconContainerView.alpha = 1
            self.iconContainerView.transform = CGAffineTransform(translationX: centerX, y: location.y - self.iconContainerView.frame.height)
        })
    }
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        
        if gesture.state == .began  {
            self.handleGesture(gesture: gesture)
        } else {
    
            iconContainerView.removeFromSuperview()
        }
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }


}

