//
//  GraphsParentViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/19/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class GraphsParentViewController: UIViewController {

    let topGraphChildVC = TopGraphViewController()
    let botGraphChildVC = BottomGraphViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren()
        
    }
    //MARK: Create Children VC's
    func addChildren() { // creating and setting up heartrateVC
        addChild(topGraphChildVC)
        view.addSubview(topGraphChildVC.view)
        topGraphChildVC.didMove(toParent: self)
        topGraphChildVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        topGraphChildVC.view.backgroundColor = .clear
        
        addChild(botGraphChildVC) // creating and setting up sp02VC
        view.addSubview(botGraphChildVC.view)
        botGraphChildVC.didMove(toParent: self)
        botGraphChildVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        botGraphChildVC.view.backgroundColor = .clear
        
        ElementSetup()
        addContraints()
        elementInitialization()
    }
    
   
    
    //MARK:Create UI Elements
    let topGraphLabel: UILabel = {
       let label = GraphLabels()
        label.text = "PPG"
        return label
    }()
    
    let botGraphLabel: UILabel = {
        let label = GraphLabels()
        label.text = "SP02"
        return label
    }()
    
    
    var topAccelZButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("Gz", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 12
        button.tag = 0
        button.addTarget(self, action: #selector(topGraphSelection), for: .touchUpInside)
        return button
    }()
    
    
    var topAccelYButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("Gy", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 12
        button.tag = 1
        button.addTarget(self, action: #selector(topGraphSelection), for: .touchUpInside)
        return button
    }()
    
    
    var topAccelXButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("Gx", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 12
        button.tag = 2
        button.addTarget(self, action: #selector(topGraphSelection), for: .touchUpInside)
        return button
    }()
    
    
    var topBPMButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("BPM", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 12
        button.tag = 3
        button.addTarget(self, action: #selector(topGraphSelection), for: .touchUpInside)
        return button
    }()
    
   
    var topPPGButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("PPG", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 12
        button.tag = 4
        button.addTarget(self, action: #selector(topGraphSelection), for: .touchUpInside)
        return button
    }()
    
    
       var topsp02Button : UIButton = {
         let button = UIButton()
           button.layer.borderWidth = 1.5
           button.layer.borderColor = UIColor.white.cgColor
           button.setBackgroundColor(color: .clear, forState: .normal)
           button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
           button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
           button.setTitle("Sp02", for: .normal)
           button.titleLabel?.font = .systemFont(ofSize: 12)
           button.layer.cornerRadius = 12
           button.tag = 5
           button.addTarget(self, action: #selector(topGraphSelection), for: .touchUpInside)
           return button
       }()
    
    var botAccelZButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.white.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("Gz", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 12)
         button.layer.cornerRadius = 12
         button.tag = 0
         button.addTarget(self, action: #selector(botGraphSelection), for: .touchUpInside)
         return button
     }()
     
     
     var botAccelYButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.white.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("Gy", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 12)
         button.layer.cornerRadius = 12
         button.tag = 1
         button.addTarget(self, action: #selector(botGraphSelection), for: .touchUpInside)
         return button
     }()
     
     
     var botAccelXButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.white.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("Gx", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 12)
         button.layer.cornerRadius = 12
         button.tag = 2
         button.addTarget(self, action: #selector(botGraphSelection), for: .touchUpInside)
         return button
     }()
     
     
     var botBPMButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.white.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("BPM", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 12)
         button.layer.cornerRadius = 12
         button.tag = 3
         button.addTarget(self, action: #selector(botGraphSelection), for: .touchUpInside)
         return button
     }()
     
    
     var botPPGButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.white.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("PPG", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 12)
         button.layer.cornerRadius = 12
         button.tag = 4
         button.addTarget(self, action: #selector(botGraphSelection), for: .touchUpInside)
         return button
     }()
     
     
        var botsp02Button : UIButton = {
          let button = UIButton()
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.white.cgColor
            button.setBackgroundColor(color: .clear, forState: .normal)
            button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            button.setTitle("Sp02", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            button.layer.cornerRadius = 12
            button.tag = 5
            button.addTarget(self, action: #selector(botGraphSelection), for: .touchUpInside)
            return button
        }()
    
    func ElementSetup(){
        view.frame = CGRect(x: 0, y: 0, width: (screenSize.width*0.9), height: screenSize.height*0.525)
        
        topGraphLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        botGraphLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        topsp02Button.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        topAccelZButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        topAccelXButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        topAccelYButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        topBPMButton.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        topPPGButton.frame = CGRect(x: 0, y: 0, width: 45, height: 25) // Loading Issues
        botsp02Button.frame = CGRect(x: 0, y: 0, width: 47, height: 25) // Loading Issues 
        botAccelZButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        botAccelXButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        botAccelYButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        botBPMButton.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        botPPGButton.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        
        view.addSubview(topGraphLabel)
        view.addSubview(botGraphLabel)
        view.addSubview(topsp02Button)
        view.addSubview(topAccelZButton)
        view.addSubview(topAccelYButton)
        view.addSubview(topAccelXButton)
        view.addSubview(topBPMButton)
        view.addSubview(topPPGButton)
        view.addSubview(botsp02Button)
        view.addSubview(botAccelZButton)
        view.addSubview(botAccelYButton)
        view.addSubview(botAccelXButton)
        view.addSubview(botBPMButton)
        view.addSubview(botPPGButton)
    }
    
    
    //MARK: Create Dynamic Constriants
    func addContraints(){
        topGraphChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        topGraphChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0536).isActive = true
        topGraphChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0536 ).isActive = true
        topGraphChildVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width*0.0805).isActive = true
        
        botGraphChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        botGraphChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0536).isActive = true
        botGraphChildVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.8536 ).isActive = true
        botGraphChildVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: +view.frame.height/2 + view.frame.width*0.0805).isActive = true
        
        topGraphLabel.translatesAutoresizingMaskIntoConstraints = false
        topGraphLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0134).isActive = true
        topGraphLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.8051).isActive = true
        topGraphLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0134 ).isActive = true
        topGraphLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topGraphLabel.frame.height).isActive = true
        
        botGraphLabel.translatesAutoresizingMaskIntoConstraints = false
        botGraphLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0134).isActive = true
        botGraphLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.8051).isActive = true
        botGraphLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botGraphLabel.bottomAnchor.constraint(equalTo: botGraphLabel.topAnchor, constant: botGraphLabel.frame.height).isActive = true
        
        
        topAccelZButton.translatesAutoresizingMaskIntoConstraints = false
        topAccelZButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.8588).isActive = true
        topAccelZButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0402).isActive = true
        topAccelZButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        topAccelZButton.bottomAnchor.constraint(equalTo: topAccelZButton.topAnchor, constant: 25).isActive = true
        
        topAccelYButton.translatesAutoresizingMaskIntoConstraints = false
        topAccelYButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.738).isActive = true
        topAccelYButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.161).isActive = true
        topAccelYButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        topAccelYButton.bottomAnchor.constraint(equalTo: topAccelYButton.topAnchor, constant: 25).isActive = true
        
        topAccelXButton.translatesAutoresizingMaskIntoConstraints = false
        topAccelXButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.6146).isActive = true
        topAccelXButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.2818).isActive = true
        topAccelXButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        topAccelXButton.bottomAnchor.constraint(equalTo: topAccelXButton.topAnchor, constant: 25).isActive = true
        
        topBPMButton.translatesAutoresizingMaskIntoConstraints = false
        topBPMButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.483).isActive = true
        topBPMButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.4025).isActive = true
        topBPMButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        topBPMButton.bottomAnchor.constraint(equalTo: topBPMButton.topAnchor, constant: 25).isActive = true
        
        topPPGButton.translatesAutoresizingMaskIntoConstraints = false
        topPPGButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.3488).isActive = true
        topPPGButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.5367).isActive = true
        topPPGButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        topPPGButton.bottomAnchor.constraint(equalTo: topPPGButton.topAnchor, constant: 25).isActive = true
        
        topsp02Button.translatesAutoresizingMaskIntoConstraints = false
        topsp02Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.2147).isActive = true
        topsp02Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.6709).isActive = true
        topsp02Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        topsp02Button.bottomAnchor.constraint(equalTo: topsp02Button.topAnchor, constant: 25).isActive = true
        
        
        botAccelZButton.translatesAutoresizingMaskIntoConstraints = false
        botAccelZButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.8588).isActive = true
        botAccelZButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0402).isActive = true
        botAccelZButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botAccelZButton.bottomAnchor.constraint(equalTo: botAccelZButton.topAnchor, constant: 25).isActive = true
        
        botAccelYButton.translatesAutoresizingMaskIntoConstraints = false
        botAccelYButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.738).isActive = true
        botAccelYButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.161).isActive = true
        botAccelYButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botAccelYButton.bottomAnchor.constraint(equalTo: botAccelYButton.topAnchor, constant: 25).isActive = true
        
        botAccelXButton.translatesAutoresizingMaskIntoConstraints = false
        botAccelXButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.6146).isActive = true
        botAccelXButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.2818).isActive = true
        botAccelXButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botAccelXButton.bottomAnchor.constraint(equalTo: botAccelXButton.topAnchor, constant: 25).isActive = true
        
        botBPMButton.translatesAutoresizingMaskIntoConstraints = false
        botBPMButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.483).isActive = true
        botBPMButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.4025).isActive = true
        botBPMButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botBPMButton.bottomAnchor.constraint(equalTo: botBPMButton.topAnchor, constant: 25).isActive = true
        
        botPPGButton.translatesAutoresizingMaskIntoConstraints = false
        botPPGButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.3488).isActive = true
        botPPGButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.5367).isActive = true
        botPPGButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botPPGButton.bottomAnchor.constraint(equalTo: botPPGButton.topAnchor, constant: 25).isActive = true
        
        botsp02Button.translatesAutoresizingMaskIntoConstraints = false
        botsp02Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.2147).isActive = true
        botsp02Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.6709).isActive = true
        botsp02Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height/2)-view.frame.width*0.0268).isActive = true
        botsp02Button.bottomAnchor.constraint(equalTo: botsp02Button.topAnchor, constant: 25).isActive = true
        
        
    }
    
    
    func elementInitialization(){
        //topGraphSelectionVisualsationReset()
        topPPGButton.setBackgroundColor(color: .white, forState: .normal)
        topPPGButton.clearColorForTitle()
        
        topGraphSelected = 4
        
        //botGraphSelectionVisualsationReset()
        botsp02Button.setBackgroundColor(color: .white, forState: .normal)
        botsp02Button.clearColorForTitle()
        botGraphSelected = 5
    }
    
    func topGraphSelectionVisualsationReset(){
        topAccelZButton.layer.mask = nil
        topAccelZButton.setBackgroundColor(color: .clear, forState: .normal)
        topAccelZButton.setTitleColor(.white, for: .normal)
        
        topAccelYButton.layer.mask = nil
        topAccelYButton.setBackgroundColor(color: .clear, forState: .normal)
        topAccelYButton.setTitleColor(.white, for: .normal)
        
        topAccelXButton.layer.mask = nil
        topAccelXButton.setBackgroundColor(color: .clear, forState: .normal)
        topAccelXButton.setTitleColor(.white, for: .normal)
        
        topBPMButton.layer.mask = nil
        topBPMButton.setBackgroundColor(color: .clear, forState: .normal)
        topBPMButton.setTitleColor(.white, for: .normal)
        
        topPPGButton.layer.mask = nil
        topPPGButton.setBackgroundColor(color: .clear, forState: .normal)
        topPPGButton.setTitleColor(.white, for: .normal)
        
        topsp02Button.layer.mask = nil
        topsp02Button.setBackgroundColor(color: .clear, forState: .normal)
        topsp02Button.setTitleColor(.white, for: .normal)
        
    }
    
    
    @objc func topGraphSelection(sender: UIButton!){
        let buttonTag = sender.tag
        switch buttonTag {
        case 0:
            topGraphSelectionVisualsationReset()
            topAccelZButton.setBackgroundColor(color: .white, forState: .normal)
            topAccelZButton.clearColorForTitle()
            topGraphSelected = 0
            topGraphLabel.text = "GZ"
            break
           
        case 1:
            topGraphSelectionVisualsationReset()
            topAccelYButton.setBackgroundColor(color: .white, forState: .normal)
            topAccelYButton.clearColorForTitle()
            topGraphSelected = 1
            topGraphLabel.text = "GY"
            break
            
        case 2:
            topGraphSelectionVisualsationReset()
            topAccelXButton.setBackgroundColor(color: .white, forState: .normal)
            topAccelXButton.clearColorForTitle()
            topGraphSelected = 2
            topGraphLabel.text = "GX"
            break
            
        case 3:
            topGraphSelectionVisualsationReset()
            topBPMButton.setBackgroundColor(color: .white, forState: .normal)
            topBPMButton.clearColorForTitle()
            topGraphSelected = 3
            topGraphLabel.text = "BPM"
            break
           
        case 4:
            topGraphSelectionVisualsationReset()
            topPPGButton.setBackgroundColor(color: .white, forState: .normal)
            topPPGButton.clearColorForTitle()
            topGraphSelected = 4
            topGraphLabel.text = "PPG"
            break
           
        case 5:
            topGraphSelectionVisualsationReset()
            topsp02Button.setBackgroundColor(color: .white, forState: .normal)
            topsp02Button.clearColorForTitle()
            topGraphSelected = 5
            topGraphLabel.text = "SP02"
            break
           
        default:
            break
        }
        
    }
    
    func botGraphSelectionVisualsationReset(){
        botAccelZButton.layer.mask = nil
        botAccelZButton.setBackgroundColor(color: .clear, forState: .normal)
        botAccelZButton.setTitleColor(.white, for: .normal)
        
        botAccelYButton.layer.mask = nil
        botAccelYButton.setBackgroundColor(color: .clear, forState: .normal)
        botAccelYButton.setTitleColor(.white, for: .normal)
        
        botAccelXButton.layer.mask = nil
        botAccelXButton.setBackgroundColor(color: .clear, forState: .normal)
        botAccelXButton.setTitleColor(.white, for: .normal)
        
        botBPMButton.layer.mask = nil
        botBPMButton.setBackgroundColor(color: .clear, forState: .normal)
        botBPMButton.setTitleColor(.white, for: .normal)
        
        botPPGButton.layer.mask = nil
        botPPGButton.setBackgroundColor(color: .clear, forState: .normal)
        botPPGButton.setTitleColor(.white, for: .normal)
        
        botsp02Button.layer.mask = nil
        botsp02Button.setBackgroundColor(color: .clear, forState: .normal)
        botsp02Button.setTitleColor(.white, for: .normal)
        
    }
    
    @objc func botGraphSelection(sender: UIButton!){
        let buttonTag = sender.tag
        switch buttonTag {
        case 0:
            botGraphSelectionVisualsationReset()
            botAccelZButton.setBackgroundColor(color: .white, forState: .normal)
            botAccelZButton.clearColorForTitle()
            botGraphSelected = 0
            botGraphLabel.text = "GZ"
            break
           
        case 1:
            botGraphSelectionVisualsationReset()
            botAccelYButton.setBackgroundColor(color: .white, forState: .normal)
            botAccelYButton.clearColorForTitle()
            botGraphSelected = 1
            botGraphLabel.text = "GY"
            break
            
        case 2:
            botGraphSelectionVisualsationReset()
            botAccelXButton.setBackgroundColor(color: .white, forState: .normal)
            botAccelXButton.clearColorForTitle()
            botGraphSelected = 2
            botGraphLabel.text = "GX"
            break
            
        case 3:
            botGraphSelectionVisualsationReset()
            botBPMButton.setBackgroundColor(color: .white, forState: .normal)
            botBPMButton.clearColorForTitle()
            botGraphSelected = 3
            botGraphLabel.text = "BPM"
            break
           
        case 4:
            botGraphSelectionVisualsationReset()
            botPPGButton.setBackgroundColor(color: .white, forState: .normal)
            botPPGButton.clearColorForTitle()
            botGraphSelected = 4
            botGraphLabel.text = "PPG"
            break
           
        case 5:
            botGraphSelectionVisualsationReset()
            botsp02Button.setBackgroundColor(color: .white, forState: .normal)
            botsp02Button.clearColorForTitle()
            botGraphSelected = 5
            botGraphLabel.text = "SP02"
            break
           
        default:
            break
        }
        
    }
    
}
