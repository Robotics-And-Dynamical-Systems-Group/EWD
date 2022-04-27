//
//  InstantValsViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit
import MessageUI

var InstantValsVisibile = Bool()
class InstantValsViewController: UIViewController {

    
    override func viewDidAppear(_ animated: Bool) {
        InstantValsVisibile = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        InstantValsVisibile = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        constrainSubViews()
        _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateLabels), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(bleAlert), userInfo: nil, repeats: true)
        
    }
    
    
    //MARK: UI Element Creation
    var timeLabel: UILabel = {
        let label = Mylabels()
        label.text = "Time: nil"
        return label
    }()
    var timeZoneLabel: UILabel = {
        let label = Mylabels()
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.text = "UTC"
        return label
    }()
    var AxLabel: UILabel = {
        let label = Mylabels()
        label.text = "g-x: nil"
        return label
    }()
    var AyLabel: UILabel = {
        let label = Mylabels()
        label.text = "g-y: nil"
        return label
    }()
    var AzLabel: UILabel = {
        let label = Mylabels()
        label.text = "g-z: nil"
        return label
    }()
    var HrLabel: UILabel = {
        let label = Mylabels()
        label.text = "BPM: nil"
        label.textAlignment = .center
        return label
    }()
    var Sp02Label: UILabel = {
        let label = Mylabels()
        label.text = "Sp02: nil"
        label.textAlignment = .center
        return label
    }()
    
    
    var connectButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        print(bluetoothBtnState)
        if bluetoothBtnState == false {
            button.setTitle("Connect To Device", for: .normal)
        }
        if bluetoothBtnState == true {
            button.setTitle("Disconnect Device", for: .normal)
        }
        button.addTarget(self, action: #selector(connectButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 15.0
        return button
    }()
    
    var exportButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.setBackgroundColor(color: colorF3CFC8, forState: .highlighted)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("Export to CSV", for: .normal)
        button.addTarget(self, action: #selector(exportButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    var clearDBButton : UIButton = {
      let button = UIButton()
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.setBackgroundColor(color: colorF3CFC8, forState: .highlighted)
        button.titleLabel?.numberOfLines = 0 // Dynamic number of lines
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("Clear DB", for: .normal)
        button.addTarget(self, action: #selector(clearDBButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    var lsgButton: UIButton = {
      let button = UIButton()
        let image = UIImage(named: "ecg")
        let beginImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIColorInvert")
        filter?.setValue(beginImage, forKey: kCIInputImageKey)
        let newImage = UIImage(ciImage: (filter?.outputImage)!)
        button.setImage(newImage, for: .normal)
        button.addTarget(self, action: #selector(largeScaleGraphButtonAction), for: .touchUpInside)
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    var settingButton: UIButton = {
      let button = UIButton()
        let image = UIImage(named: "settingsIcon2")
        let beginImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIColorInvert")
        filter?.setValue(beginImage, forKey: kCIInputImageKey)
        let newImage = UIImage(ciImage: (filter?.outputImage)!)
        button.setImage(newImage, for: .normal)
        button.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        return button
    }()
    

    //MARK: View Setup
    func setupView(){
        
        view.frame = CGRect(x: 0, y: 0, width: (screenSize.width*0.9), height: screenSize.height*0.345)
        print(view.frame)
        
        timeLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        AxLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        AyLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        AzLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        view.addSubview(timeLabel)
        view.addSubview(AxLabel)
        view.addSubview(AyLabel)
        view.addSubview(AzLabel)
        view.addSubview(HrLabel)
        view.addSubview(Sp02Label)
        view.addSubview(connectButton)
        view.addSubview(exportButton)
        view.addSubview(settingButton)
        view.addSubview(timeZoneLabel)
        view.addSubview(clearDBButton)
        view.addSubview(lsgButton)
    }
    //MARK: Dynamic Constraints
    func constrainSubViews(){
        //MARK: Format for IPX IPXS IPXS+ IP11
        if view.frame.height > 275 {
            
            connectButton.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
            exportButton.frame = CGRect(x: 0, y: 0, width: 160, height: 30)
            clearDBButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            lsgButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
            settingButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

            
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.0648).isActive = true
            timeLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: view.frame.width*0.4026).isActive = true
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
            
            timeZoneLabel.translatesAutoresizingMaskIntoConstraints = false
            timeZoneLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
            timeZoneLabel.trailingAnchor.constraint(equalTo: timeZoneLabel.leadingAnchor, constant: view.frame.width*0.2147).isActive = true
            timeZoneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
          
            AxLabel.translatesAutoresizingMaskIntoConstraints = false
            AxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0537).isActive = true
            AxLabel.trailingAnchor.constraint(equalTo: AxLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
            AxLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
            
            AyLabel.translatesAutoresizingMaskIntoConstraints = false
            AyLabel.leadingAnchor.constraint(equalTo: AxLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
            AyLabel.trailingAnchor.constraint(equalTo: AyLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
            AyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
            
            AzLabel.translatesAutoresizingMaskIntoConstraints = false
            AzLabel.leadingAnchor.constraint(equalTo: AyLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
            AzLabel.trailingAnchor.constraint(equalTo: AzLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
            AzLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
     
            HrLabel.translatesAutoresizingMaskIntoConstraints = false
            HrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0537).isActive = true
            HrLabel.trailingAnchor.constraint(equalTo: HrLabel.leadingAnchor, constant: view.frame.width*0.4195 ).isActive = true
            HrLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.42).isActive = true
            
            Sp02Label.translatesAutoresizingMaskIntoConstraints = false
            Sp02Label.leadingAnchor.constraint(equalTo: HrLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
            Sp02Label.trailingAnchor.constraint(equalTo: Sp02Label.leadingAnchor, constant: view.frame.width*0.4195 ).isActive = true
            Sp02Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.420).isActive = true
            
            exportButton.translatesAutoresizingMaskIntoConstraints = false
            exportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.06).isActive = true
            exportButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: exportButton.frame.width).isActive = true
            exportButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
            exportButton.bottomAnchor.constraint(equalTo: exportButton.topAnchor, constant: exportButton.frame.height).isActive = true
            
            clearDBButton.translatesAutoresizingMaskIntoConstraints = false
            clearDBButton.leadingAnchor.constraint(equalTo: exportButton.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
            clearDBButton.trailingAnchor.constraint(equalTo: clearDBButton.leadingAnchor, constant: clearDBButton.frame.width).isActive = true
            clearDBButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
            clearDBButton.bottomAnchor.constraint(equalTo: clearDBButton.topAnchor, constant: clearDBButton.frame.height).isActive = true
            
            lsgButton.translatesAutoresizingMaskIntoConstraints = false
            lsgButton.leadingAnchor.constraint(lessThanOrEqualTo: clearDBButton.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
            lsgButton.trailingAnchor.constraint(equalTo: lsgButton.leadingAnchor, constant: lsgButton.frame.width).isActive = true
            lsgButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
            lsgButton.bottomAnchor.constraint(equalTo: lsgButton.topAnchor, constant: lsgButton.frame.height).isActive = true
            
            connectButton.translatesAutoresizingMaskIntoConstraints = false
            connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width * 0.03)).isActive = true
                connectButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width * 0.969)).isActive = true
            connectButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.809).isActive = true
            connectButton.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: connectButton.frame.height).isActive = true
            
            settingButton.translatesAutoresizingMaskIntoConstraints = false
            settingButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width * 0.161).isActive = true
            settingButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: settingButton.frame.width).isActive = true
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
            settingButton.bottomAnchor.constraint(equalTo: settingButton.topAnchor, constant: settingButton.frame.height).isActive = true
            
        }
        //MARK: Format for IP8+ IP7+
        if view.frame.height > 250 && view.frame.height < 270 {
            
           connectButton.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
           exportButton.frame = CGRect(x: 0, y: 0, width: 160, height: 30)
           clearDBButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
           lsgButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
           settingButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

           
          timeLabel.translatesAutoresizingMaskIntoConstraints = false
          timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.0648).isActive = true
          timeLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: view.frame.width*0.4026).isActive = true
          timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
          
          timeZoneLabel.translatesAutoresizingMaskIntoConstraints = false
          timeZoneLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
          timeZoneLabel.trailingAnchor.constraint(equalTo: timeZoneLabel.leadingAnchor, constant: view.frame.width*0.2147).isActive = true
          timeZoneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
        
          AxLabel.translatesAutoresizingMaskIntoConstraints = false
          AxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0537).isActive = true
          AxLabel.trailingAnchor.constraint(equalTo: AxLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
          AxLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
          
          AyLabel.translatesAutoresizingMaskIntoConstraints = false
          AyLabel.leadingAnchor.constraint(equalTo: AxLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
          AyLabel.trailingAnchor.constraint(equalTo: AyLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
          AyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
          
          AzLabel.translatesAutoresizingMaskIntoConstraints = false
          AzLabel.leadingAnchor.constraint(equalTo: AyLabel.trailingAnchor, constant: view.frame.width*0.0402).isActive = true
          AzLabel.trailingAnchor.constraint(equalTo: AzLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
          AzLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
   
          HrLabel.translatesAutoresizingMaskIntoConstraints = false
          HrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0537).isActive = true
          HrLabel.trailingAnchor.constraint(equalTo: HrLabel.leadingAnchor, constant: view.frame.width*0.4195 ).isActive = true
          HrLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.42).isActive = true
          
          Sp02Label.translatesAutoresizingMaskIntoConstraints = false
          Sp02Label.leadingAnchor.constraint(equalTo: HrLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
          Sp02Label.trailingAnchor.constraint(equalTo: Sp02Label.leadingAnchor, constant: view.frame.width*0.4195 ).isActive = true
          Sp02Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.420).isActive = true
          
           exportButton.translatesAutoresizingMaskIntoConstraints = false
           exportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.06).isActive = true
           exportButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: exportButton.frame.width).isActive = true
           exportButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
           exportButton.bottomAnchor.constraint(equalTo: exportButton.topAnchor, constant: exportButton.frame.height).isActive = true
           
           clearDBButton.translatesAutoresizingMaskIntoConstraints = false
           clearDBButton.leadingAnchor.constraint(equalTo: exportButton.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
           clearDBButton.trailingAnchor.constraint(equalTo: clearDBButton.leadingAnchor, constant: clearDBButton.frame.width).isActive = true
           clearDBButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
           clearDBButton.bottomAnchor.constraint(equalTo: clearDBButton.topAnchor, constant: clearDBButton.frame.height).isActive = true
           
           lsgButton.translatesAutoresizingMaskIntoConstraints = false
            lsgButton.leadingAnchor.constraint(lessThanOrEqualTo: clearDBButton.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
           lsgButton.trailingAnchor.constraint(equalTo: lsgButton.leadingAnchor, constant: lsgButton.frame.width).isActive = true
           lsgButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
           lsgButton.bottomAnchor.constraint(equalTo: lsgButton.topAnchor, constant: lsgButton.frame.height).isActive = true
           
           connectButton.translatesAutoresizingMaskIntoConstraints = false
           connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width * 0.03)).isActive = true
           connectButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width * 0.969)).isActive = true
           connectButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.84).isActive = true
           connectButton.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: connectButton.frame.height).isActive = true
           
           settingButton.translatesAutoresizingMaskIntoConstraints = false
           settingButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width * 0.161).isActive = true
           settingButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: settingButton.frame.width).isActive = true
           settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.05).isActive = true
           settingButton.bottomAnchor.constraint(equalTo: settingButton.topAnchor, constant: settingButton.frame.height).isActive = true
        }
        
        //MARK: Format for IP8 IP6
        if view.frame.height <= 250{
            
            connectButton.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
            exportButton.frame = CGRect(x: 0, y: 0, width: 145, height: 30)
            clearDBButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            lsgButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
            settingButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

            
           timeLabel.translatesAutoresizingMaskIntoConstraints = false
           timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height*0.0648).isActive = true
           timeLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: view.frame.width*0.4026).isActive = true
           timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
           
           timeZoneLabel.translatesAutoresizingMaskIntoConstraints = false
           timeZoneLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: view.frame.width*0.0537).isActive = true
           timeZoneLabel.trailingAnchor.constraint(equalTo: timeZoneLabel.leadingAnchor, constant: view.frame.width*0.2147).isActive = true
           timeZoneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.0648).isActive = true
         
           AxLabel.translatesAutoresizingMaskIntoConstraints = false
           AxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0537).isActive = true
           AxLabel.trailingAnchor.constraint(equalTo: AxLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
           AxLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
           
           AyLabel.translatesAutoresizingMaskIntoConstraints = false
           AyLabel.leadingAnchor.constraint(equalTo: AxLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
           AyLabel.trailingAnchor.constraint(equalTo: AyLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
           AyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
           
           AzLabel.translatesAutoresizingMaskIntoConstraints = false
           AzLabel.leadingAnchor.constraint(equalTo: AyLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
           AzLabel.trailingAnchor.constraint(equalTo: AzLabel.leadingAnchor, constant: view.frame.width*0.2797 ).isActive = true
           AzLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.243).isActive = true
    
           HrLabel.translatesAutoresizingMaskIntoConstraints = false
           HrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0537).isActive = true
           HrLabel.trailingAnchor.constraint(equalTo: HrLabel.leadingAnchor, constant: view.frame.width*0.4195 ).isActive = true
           HrLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.42).isActive = true
           
           Sp02Label.translatesAutoresizingMaskIntoConstraints = false
           Sp02Label.leadingAnchor.constraint(equalTo: HrLabel.trailingAnchor, constant: view.frame.width*0.0268).isActive = true
           Sp02Label.trailingAnchor.constraint(equalTo: Sp02Label.leadingAnchor, constant: view.frame.width*0.4195 ).isActive = true
           Sp02Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.420).isActive = true
           
            exportButton.translatesAutoresizingMaskIntoConstraints = false
            exportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.03).isActive = true
            exportButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: exportButton.frame.width).isActive = true
            exportButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
            exportButton.bottomAnchor.constraint(equalTo: exportButton.topAnchor, constant: exportButton.frame.height).isActive = true
            
            clearDBButton.translatesAutoresizingMaskIntoConstraints = false
            clearDBButton.leadingAnchor.constraint(equalTo: exportButton.trailingAnchor, constant: view.frame.width*0.048).isActive = true
            clearDBButton.trailingAnchor.constraint(equalTo: clearDBButton.leadingAnchor, constant: clearDBButton.frame.width).isActive = true
            clearDBButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
            clearDBButton.bottomAnchor.constraint(equalTo: clearDBButton.topAnchor, constant: clearDBButton.frame.height).isActive = true
            
            lsgButton.translatesAutoresizingMaskIntoConstraints = false
            lsgButton.leadingAnchor.constraint(lessThanOrEqualTo: clearDBButton.trailingAnchor, constant: view.frame.width*0.048).isActive = true
            lsgButton.trailingAnchor.constraint(equalTo: lsgButton.leadingAnchor, constant: lsgButton.frame.width).isActive = true
            lsgButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.645).isActive = true
            lsgButton.bottomAnchor.constraint(equalTo: lsgButton.topAnchor, constant: lsgButton.frame.height).isActive = true
            
            connectButton.translatesAutoresizingMaskIntoConstraints = false
            connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width * 0.03)).isActive = true
            connectButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width * 0.969)).isActive = true
            connectButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.84).isActive = true
            connectButton.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: connectButton.frame.height).isActive = true
            
            settingButton.translatesAutoresizingMaskIntoConstraints = false
            settingButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width * 0.161).isActive = true
            settingButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: settingButton.frame.width).isActive = true
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.05).isActive = true
            settingButton.bottomAnchor.constraint(equalTo: settingButton.topAnchor, constant: settingButton.frame.height).isActive = true
        }
        
    }
    
    //MARK: Labels Update
    @objc func updateLabels(){
        
        ConnectBtnCancel()
        
        let date = Date()
        let df = DateFormatter()
        var t = String()
        
        if utcFormat == true{
            df.dateFormat = "HH:mm:ss"
            df.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
            t = df.string(from: date)
            timeZoneLabel.text = "UTC"
        }
        else {
            df.dateFormat = "HH:mm:ss"
            t = df.string(from: date)
            timeZoneLabel.text = TimeZone.current.abbreviation()
        }
        
        timeLabel.text = "\(t) "
        
        if currentAx > 16 || currentAx < -16{
            AxLabel.text = "g-x: err)"
        }
        if currentAx <= 16 && currentAx >= -16{
            AxLabel.text = "g-x: \(currentAx.rounded(toPlaces: 1))"
        }
        if currentAy > 16 || currentAy < -16{
            AyLabel.text = "g-y: err"
        }
        if currentAy <= 16 && currentAy >= -16{
            AyLabel.text = "g-y: \(currentAy.rounded(toPlaces: 1))"
        }
        if currentAz > 16 || currentAz < -16{
            AzLabel.text = "g-z: err"
        }
        if currentAz <= 16 && currentAz >= -16{
            AzLabel.text = "g-z: \(currentAz.rounded(toPlaces: 1))"
        }
        if currentSp02 > 200 || currentSp02 < 0{
            Sp02Label.text = "Sp02: err"
        }
        if currentSp02 <= 200 && currentSp02 >= 0{
            Sp02Label.text = "Sp02: \(Int(currentSp02))%"
        }
        if currentBPM > 250 || currentBPM < 0{
            HrLabel.text = "BPM: err"
        }
        if currentBPM <= 250 && currentBPM >= 0{
            HrLabel.text = "BPM: \(Int(currentBPM))"
        }
        
    }
    
    func ConnectBtnCancel(){
        if bleCancel == true {
            bleCancel = false
            bluetoothBtnState = false
            connectButton.setTitle("Connect To Device", for: .normal)
            connectButton.layer.mask = nil
            connectButton.backgroundColor = .clear
        }
        else{
            return
        }
    }
    
    @objc func clearDBButtonAction(sender: UIButton){
        
        let alert = UIAlertController(title: "Database Managment", message: "Are you sure you want to delete all the data in the Database?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            database = [[""],[""],[""],[""],[""],[""],[""],[""],[""]] // Devicetime|Sp02|PPG|BPM|AX|AY|AZ|R_VAL|BEATRESET|
            DeviceTime = [""]
            ePodTime = [""]
            sp02Data = Array(repeating: Double(0), count: 600)
            heartRatePPG = Array(repeating: Double(0), count: 600)
            heartRateBPM = Array(repeating: Double(0), count: 600)
            accelXData = Array(repeating: Double(0), count: 600)
            accelYData = Array(repeating: Double(0), count: 600)
            accelZData = Array(repeating: Double(0), count: 600)
            
            currentAx = 0.0
            currentAy = 0.0
            currentAz = 0.0
            currentBPM = 0.0
            currentSp02 = 0.0
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert,animated: true)
    
    }
    
    @objc func largeScaleGraphButtonAction(sender: UIButton){
        let vc = LargeFormatGraphViewController()
        InstantValsVisibile = false
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: SettingsButton Function
    @objc func settingsButtonAction(sender: UIButton!){
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: ConnectButton Function
    @objc func connectButtonAction(sender: UIButton!){
        print("Connect Button Tapped")
        
        
        
        if bluetoothBtnState == false {
        
            
            let alert = UIAlertController(title: "Database Managment", message: "Connecting to a device will delete ALL data in the Database. Are you sure you want to connect?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                database = [[""],[""],[""],[""],[""],[""],[""],[""],[""]] // Devicetime|Sp02|PPG|BPM|AX|AY|AZ|R_VAL|BEATRESET|
                DeviceTime = [""]
                ePodTime = [""]
                sp02Data = Array(repeating: Double(0), count: 600)
                heartRatePPG = Array(repeating: Double(0), count: 600)
                heartRateBPM = Array(repeating: Double(0), count: 600)
                accelXData = Array(repeating: Double(0), count: 600)
                accelYData = Array(repeating: Double(0), count: 600)
                accelZData = Array(repeating: Double(0), count: 600)
                
                currentAx = 0.0
                currentAy = 0.0
                currentAz = 0.0
                currentBPM = 0.0
                currentSp02 = 0.0
                
                bluetooth.bleInit()
                bluetoothBtnState = true
                self.connectButton.setTitle("Disconnect Device", for: .normal)
                self.connectButton.clearColorForTitle()
                self.connectButton.backgroundColor = .white
                let vc = BLEPopOutViewController()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
                
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert,animated: true)
            
            
            
        }
        else if bluetoothBtnState == true{
            bluetoothBtnState = false
            connectButton.setTitle("Connect To Device", for: .normal)
            connectButton.layer.mask = nil
            connectButton.backgroundColor = .clear
            
            bluetooth.disconnectPeripheral()
        }
        
    }
    
    
    @objc func bleAlert(){
        if InstantValsVisibile == true {
            if bluetoothErr == true{
                let alert = UIAlertController(title: "Bluetooth Error", message: bleErrMsg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                bluetoothErr = false
            }
        }
    }
    
    //MARK:ExportButton Function
    @objc func exportButtonAction(sender: UIButton!){
        print("Exporting CSV")
        let objectsToShare = [createCSV()]
        // Creates Activity VC for sharing file
        let vc = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: [])
        present(vc, animated: true,completion: nil)
    }

}

    //MARK: CSV Generation
    func createCSV() -> URL? {
    
        var csvString = "\("CodeCompileDate: ")\(CodeCompileDate)\n\n\("CodeCompileName: ")\(CodeCompileName)\n\n\("SDSaveName: ")\(SDSaveName)\n\n\("IphoneTime"),\("ePoDTime"),\("Sp02"),\("PPG"),\("BPM"),\("Grav_X"),\("Grav_Y"),\("Grav_Z"),\("R_Val"),\("BeatReset")\n\n"

        for i in 0..<DeviceTime.count-1{
            csvString = csvString.appending("\(DeviceTime[i]),\(ePodTime[i]),\(String(database[0][i])),\(String(database[1][i])),\(String(database[2][i])),\(String(database[3][i])),\(String(database[4][i])),\(String(database[5][i])),\(String(database[6][i])),\(String(database[7][i]))\n")
            
        }

        let fileManager = FileManager.default
        let fileURL: URL
        
        let date = Date()
        let df = DateFormatter()
        var t = String()
        
        if utcFormat == true{
            df.dateFormat = "yyyy_MM_dd HH_mm_ss"
            df.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
            t = df.string(from: date) + "_UTC"
        }
        if utcFormat == false{
            df.dateFormat = "yyyy_MM_dd HH_mm_ss"
            t = df.string(from: date) + "_" + TimeZone.current.abbreviation()!
        }
        
        
        do {
            let filename = "ePoD_ReportGenerated_\(t).csv"
            
            let path = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            fileURL = path.appendingPathComponent(filename)
            
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
            
        }
        catch {
            print("Error Creating File")
            return nil
    }
    
}





//MARK: UIButton Extension
extension UIButton {

    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }

}
