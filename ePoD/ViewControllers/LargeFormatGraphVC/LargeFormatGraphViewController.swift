//
//  LargeFormatGraphViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 5/26/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

var LFGVisible = Bool()

class LargeFormatGraphViewController: UIViewController {

    let graphChildVC = GraphViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        LFGVisible = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        LFGVisible = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AppUtility.lockOrientation(.landscapeRight)
        
        addChild(graphChildVC)
        view.addSubview(graphChildVC.view)
        graphChildVC.didMove(toParent: self)
        graphChildVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.height - 80, height: view.frame.width - 80)
        graphChildVC.view.backgroundColor = .clear
        
        _ = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(bleAlert), userInfo: nil, repeats: true)
        
        setupViews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    
    @objc func bleAlert(){
        if LFGVisible == true {
            if bluetoothErr == true{
                let alert = UIAlertController(title: "Bluetooth Error", message: bleErrMsg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                bluetoothErr = false
            }
        }
    }
    
    var graphLabel: UILabel = {
       let label = Mylabels()
        label.textColor = .black
        label.text = "PPG"
        label.textAlignment = .center
        return label
    }()
    
    var backButton: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "backIcon")
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        return button
    }()
    
    var AccelZButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.systemGray.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("g-z", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 16)
         button.layer.cornerRadius = 12
         button.tag = 0
         button.addTarget(self, action: #selector(GraphSelection), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
         return button
     }()
     
     
     var AccelYButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.systemGray.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("g-y", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 16)
         button.layer.cornerRadius = 12
         button.tag = 1
         button.addTarget(self, action: #selector(GraphSelection), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)

         return button
     }()
     
     
     var AccelXButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.systemGray.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("g-x", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 16)
         button.layer.cornerRadius = 12
         button.tag = 2
         button.addTarget(self, action: #selector(GraphSelection), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)

         return button
     }()
     
     
     var BPMButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.layer.borderColor = UIColor.systemGray.cgColor
         button.setBackgroundColor(color: .clear, forState: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("BPM", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 16)
         button.layer.cornerRadius = 12
         button.tag = 3
         button.addTarget(self, action: #selector(GraphSelection), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)

         return button
     }()
     
    
     var PPGButton : UIButton = {
       let button = UIButton()
         button.layer.borderWidth = 1.5
         button.setBackgroundColor(color: .white, forState: .normal)
         button.layer.borderColor = UIColor.systemGray.cgColor
         button.setTitleColor(.white, for: .normal)
         button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
         button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         button.setTitle("PPG", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 16)
         button.layer.cornerRadius = 12
         button.tag = 4
         button.addTarget(self, action: #selector(GraphSelection), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
         return button
     }()
     
     
        var sp02Button : UIButton = {
          let button = UIButton()
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.systemGray.cgColor
            button.setBackgroundColor(color: .clear, forState: .normal)
            button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            button.setTitle("Sp02", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.layer.cornerRadius = 12
            button.tag = 5
            button.addTarget(self, action: #selector(GraphSelection), for: .touchUpInside)
            button.setTitleColor(.systemBlue, for: .normal)

            return button
        }()
    
    
    func setupViews(){
        view.backgroundColor = .white
        print(view.frame)
        view.addSubview(graphLabel)
        view.addSubview(backButton)
        view.addSubview(AccelZButton)
        view.addSubview(AccelYButton)
        view.addSubview(AccelXButton)
        view.addSubview(BPMButton)
        view.addSubview(PPGButton)
        view.addSubview(sp02Button)
        
        createConstraints()
        GraphSelectionInitilization(selection: largeGraphSelected)
        
    }
    
    func createConstraints(){
        graphChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        graphChildVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width*0.0966).isActive = true
        graphChildVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.0669).isActive = true
        
        graphLabel.translatesAutoresizingMaskIntoConstraints = false
        graphLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width*0.0241).isActive = true
        graphLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.0669).isActive = true
        graphLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.2009).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width*0.0362).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.0223).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.1).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: view.frame.width*0.0604).isActive = true
        
        AccelZButton.translatesAutoresizingMaskIntoConstraints = false
        AccelZButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.8371).isActive = true
        AccelZButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height*0.0625).isActive = true
        AccelZButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0241).isActive = true
        AccelZButton.bottomAnchor.constraint(equalTo: AccelZButton.topAnchor, constant: view.frame.width*0.0725).isActive = true
        
        AccelYButton.translatesAutoresizingMaskIntoConstraints = false
        AccelYButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.7143).isActive = true
        AccelYButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height*0.1853).isActive = true
        AccelYButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0241).isActive = true
        AccelYButton.bottomAnchor.constraint(equalTo: AccelYButton.topAnchor, constant: view.frame.width*0.0725).isActive = true
        
        AccelXButton.translatesAutoresizingMaskIntoConstraints = false
        AccelXButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.5915).isActive = true
        AccelXButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height*0.308).isActive = true
        AccelXButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0241).isActive = true
        AccelXButton.bottomAnchor.constraint(equalTo: AccelXButton.topAnchor, constant: view.frame.width*0.0725).isActive = true
        
        BPMButton.translatesAutoresizingMaskIntoConstraints = false
        BPMButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.4688).isActive = true
        BPMButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height*0.4308).isActive = true
        BPMButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0241).isActive = true
        BPMButton.bottomAnchor.constraint(equalTo: BPMButton.topAnchor, constant: view.frame.width*0.0725).isActive = true
        
        PPGButton.translatesAutoresizingMaskIntoConstraints = false
        PPGButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.346).isActive = true
        PPGButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height*0.5536).isActive = true
        PPGButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0241).isActive = true
        PPGButton.bottomAnchor.constraint(equalTo: PPGButton.topAnchor, constant: view.frame.width*0.0725).isActive = true
        
        sp02Button.translatesAutoresizingMaskIntoConstraints = false
        sp02Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.2232).isActive = true
        sp02Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height*0.6763).isActive = true
        sp02Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.0241).isActive = true
        sp02Button.bottomAnchor.constraint(equalTo: sp02Button.topAnchor, constant: view.frame.width*0.0725).isActive = true
        
    }
    
    
    @objc func backButtonAction(sender: UIButton){
        InstantValsVisibile = true
        AppUtility.lockOrientation(.allButUpsideDown)
        self.dismiss(animated: true, completion: nil)
    }
    
    func GraphSelectionVisualsationReset(){
        AccelZButton.setBackgroundColor(color: .white, forState: .normal)
        AccelZButton.layer.borderColor = UIColor.systemGray.cgColor
        AccelZButton.setTitleColor(.systemBlue, for: .normal)
        AccelYButton.setBackgroundColor(color: .white, forState: .normal)
        AccelYButton.layer.borderColor = UIColor.systemGray.cgColor
        AccelYButton.setTitleColor(.systemBlue, for: .normal)
        AccelXButton.setBackgroundColor(color: .white, forState: .normal)
        AccelXButton.layer.borderColor = UIColor.systemGray.cgColor
        AccelXButton.setTitleColor(.systemBlue, for: .normal)
        BPMButton.setBackgroundColor(color: .white, forState: .normal)
        BPMButton.layer.borderColor = UIColor.systemGray.cgColor
        BPMButton.setTitleColor(.systemBlue, for: .normal)
        PPGButton.setBackgroundColor(color: .white, forState: .normal)
        PPGButton.layer.borderColor = UIColor.systemGray.cgColor
        PPGButton.setTitleColor(.systemBlue, for: .normal)
        sp02Button.setBackgroundColor(color: .white, forState: .normal)
        sp02Button.layer.borderColor = UIColor.systemGray.cgColor
        sp02Button.setTitleColor(.systemBlue, for: .normal)

    }
    
    func GraphSelectionInitilization(selection: Int){
        switch selection {
        case 0:
            GraphSelectionVisualsationReset()
            AccelZButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            AccelZButton.layer.borderColor = UIColor.systemBlue.cgColor
            AccelZButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 0
            graphLabel.text = "Grav Z"
            break
           
        case 1:
            GraphSelectionVisualsationReset()
            AccelYButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            AccelYButton.layer.borderColor = UIColor.systemBlue.cgColor
            AccelYButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 1
            graphLabel.text = "Grav Y"
            break
            
        case 2:
            GraphSelectionVisualsationReset()
            AccelXButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            AccelXButton.layer.borderColor = UIColor.systemBlue.cgColor
            AccelXButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 2
            graphLabel.text = "Grav X"
            break
            
        case 3:
            GraphSelectionVisualsationReset()
            BPMButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            BPMButton.layer.borderColor = UIColor.systemBlue.cgColor
            BPMButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 3
            graphLabel.text = "BPM"
            break
           
        case 4:
            GraphSelectionVisualsationReset()
            PPGButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            PPGButton.layer.borderColor = UIColor.systemBlue.cgColor
            PPGButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 4
            graphLabel.text = "PPG"
            break
           
        case 5:
            GraphSelectionVisualsationReset()
            sp02Button.setBackgroundColor(color: .systemBlue, forState: .normal)
            sp02Button.layer.borderColor = UIColor.systemBlue.cgColor
            sp02Button.setTitleColor(.white, for: .normal)
            largeGraphSelected = 5
            graphLabel.text = "SP02"
            break
           
        default:
            break
        }
    }
    
    @objc func GraphSelection(sender: UIButton){
        let buttonTag = sender.tag
        switch buttonTag {
        case 0:
            GraphSelectionVisualsationReset()
            AccelZButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            AccelZButton.layer.borderColor = UIColor.systemBlue.cgColor
            AccelZButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 0
            graphLabel.text = "Grav Z"
            break
           
        case 1:
            GraphSelectionVisualsationReset()
            AccelYButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            AccelYButton.layer.borderColor = UIColor.systemBlue.cgColor
            AccelYButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 1
            graphLabel.text = "Grav Y"
            break
            
        case 2:
            GraphSelectionVisualsationReset()
            AccelXButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            AccelXButton.layer.borderColor = UIColor.systemBlue.cgColor
            AccelXButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 2
            graphLabel.text = "Grav X"
            break
            
        case 3:
            GraphSelectionVisualsationReset()
            BPMButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            BPMButton.layer.borderColor = UIColor.systemBlue.cgColor
            BPMButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 3
            graphLabel.text = "BPM"
            break
           
        case 4:
            GraphSelectionVisualsationReset()
            PPGButton.setBackgroundColor(color: .systemBlue, forState: .normal)
            PPGButton.layer.borderColor = UIColor.systemBlue.cgColor
            PPGButton.setTitleColor(.white, for: .normal)
            largeGraphSelected = 4
            graphLabel.text = "PPG"
            break
           
        case 5:
            GraphSelectionVisualsationReset()
            sp02Button.setBackgroundColor(color: .systemBlue, forState: .normal)
            sp02Button.layer.borderColor = UIColor.systemBlue.cgColor
            sp02Button.setTitleColor(.white, for: .normal)
            largeGraphSelected = 5
            graphLabel.text = "SP02"
            break
           
        default:
            break
        }
    }
    
    
}
