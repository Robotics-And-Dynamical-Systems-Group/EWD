//
//  MainViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    let instantValsChildVC = InstantValsViewController()
    let graphsParentChildVC = GraphsParentViewController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppUtility.lockOrientation(.portrait)
        
        addChildren()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeGestureAction))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
    }
    //MARK: Create Children VC's
    func addChildren() { // Creating and setting up instantvalsVC
        addChild(instantValsChildVC)
        view.addSubview(instantValsChildVC.view)
        instantValsChildVC.didMove(toParent: self)
        instantValsChildVC.view.setGradientBackground(colorOne: colorF27094C, colorTwo: colorFF9472)
        instantValsChildVC.view.layer.shadowColor = UIColor.black.cgColor
        instantValsChildVC.view.layer.shadowOpacity = 0.5
        instantValsChildVC.view.layer.shadowRadius = 7
        instantValsChildVC.view.layer.shadowOffset = .zero
        
        
        //print(instantValsChildVC.view.frame)
        
        addChild(graphsParentChildVC) // Creating and setting up graphsparentVC
        view.addSubview(graphsParentChildVC.view)
        graphsParentChildVC.didMove(toParent: self)
        graphsParentChildVC.view.setGradientBackground(colorOne: color1CD8D2 , colorTwo: color7474BF )
        graphsParentChildVC.view.layer.shadowColor = UIColor.black.cgColor
        graphsParentChildVC.view.layer.shadowOpacity = 0.5
        graphsParentChildVC.view.layer.shadowRadius = 7
        graphsParentChildVC.view.layer.shadowOffset = .zero
        
        
        setConstrainChildren()
    }
    //MARK: Create Constraints for VC's
    func setConstrainChildren(){
        //MARK: Format for IPX IPXS IPXS+ IP11
        if screenSize.height > 800{
            
            instantValsChildVC.view.frame = CGRect(x: 0, y: 0, width: (screenSize.width*0.9), height: screenSize.height*0.345)
            
            graphsParentChildVC.view.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.9, height: screenSize.height*0.525)
            
             instantValsChildVC.view.translatesAutoresizingMaskIntoConstraints = false
             instantValsChildVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (instantValsChildVC.view.frame.height)-view.frame.height*0.0112).isActive = true
             instantValsChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
             instantValsChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
             instantValsChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
             
            
             graphsParentChildVC.view.translatesAutoresizingMaskIntoConstraints = false
             graphsParentChildVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0).isActive = true
             graphsParentChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
             graphsParentChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
             graphsParentChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenSize.height*0.367) .isActive = true
        }
        //MARK: Format for IP8+ IP7+
        if screenSize.height > 700 && screenSize.height < 800 {
            
            instantValsChildVC.view.frame = CGRect(x: 0, y: 0, width: (screenSize.width*0.9), height: screenSize.height*0.37)
            instantValsChildVC.view.setGradientBackground(colorOne: colorF27094C, colorTwo: colorFF9472)
            instantValsChildVC.view.layer.shadowColor = UIColor.black.cgColor
            instantValsChildVC.view.layer.shadowOpacity = 0.5
            instantValsChildVC.view.layer.shadowRadius = 7
            instantValsChildVC.view.layer.shadowOffset = .zero
            
            graphsParentChildVC.view.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.9, height: screenSize.height*0.54)
            graphsParentChildVC.view.setGradientBackground(colorOne: color1CD8D2 , colorTwo: color7474BF )
            graphsParentChildVC.view.layer.shadowColor = UIColor.black.cgColor
            graphsParentChildVC.view.layer.shadowOpacity = 0.5
            graphsParentChildVC.view.layer.shadowRadius = 7
            graphsParentChildVC.view.layer.shadowOffset = .zero
            
            instantValsChildVC.view.translatesAutoresizingMaskIntoConstraints = false
             instantValsChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
             instantValsChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
             instantValsChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
             instantValsChildVC.view.bottomAnchor.constraint(equalTo: instantValsChildVC.view.topAnchor, constant: instantValsChildVC.view.frame.height).isActive = true
         
             graphsParentChildVC.view.translatesAutoresizingMaskIntoConstraints = false
             graphsParentChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
             graphsParentChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
             graphsParentChildVC.view.topAnchor.constraint(equalTo: instantValsChildVC.view.bottomAnchor, constant: 20) .isActive = true
             graphsParentChildVC.view.bottomAnchor.constraint(equalTo: graphsParentChildVC.view.topAnchor,constant: graphsParentChildVC.view.frame.height).isActive = true
                 
        }
        //MARK: Format for IP8 IP7 IP6
        if screenSize.height < 700 {
            
            instantValsChildVC.view.frame = CGRect(x: 0, y: 0, width: (screenSize.width*0.9), height: screenSize.height*0.38)
            instantValsChildVC.view.setGradientBackground(colorOne: colorF27094C, colorTwo: colorFF9472)
            instantValsChildVC.view.layer.shadowColor = UIColor.black.cgColor
            instantValsChildVC.view.layer.shadowOpacity = 0.5
            instantValsChildVC.view.layer.shadowRadius = 7
            instantValsChildVC.view.layer.shadowOffset = .zero
            
            graphsParentChildVC.view.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.9, height: screenSize.height*0.525)
        
            instantValsChildVC.view.translatesAutoresizingMaskIntoConstraints = false
            instantValsChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            instantValsChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            instantValsChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            instantValsChildVC.view.bottomAnchor.constraint(equalTo: instantValsChildVC.view.topAnchor, constant: instantValsChildVC.view.frame.height).isActive = true
        
            graphsParentChildVC.view.translatesAutoresizingMaskIntoConstraints = false
            graphsParentChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            graphsParentChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            graphsParentChildVC.view.topAnchor.constraint(equalTo: instantValsChildVC.view.bottomAnchor, constant: 20) .isActive = true
            graphsParentChildVC.view.bottomAnchor.constraint(equalTo: graphsParentChildVC.view.topAnchor,constant: graphsParentChildVC.view.frame.height).isActive = true
            
        }
        
    }
    
    @objc func leftSwipeGestureAction(sender: Any){
        print("Left Swipe Detected")
        let vc = LargeFormatGraphViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
        
}

    


