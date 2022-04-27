//
//  SettingsViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 5/19/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    let backButton: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "backIcon")
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.setImage(image, for: .normal)
        return button
    }()
    
    let settingLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 36)
        label.textColor = .darkGray
        label.text = "Settings"
        label.textAlignment = .center
        return label
       }()
    
    let utcSwitchLabel: UILabel = {
        let label = SettingLabels()
        label.text = "Enable Coordinated Universal Time"
        return label
    }()
    
    let utcSwitch: UISwitch = {
       let sw = UISwitch()
        sw.setOn(true, animated: false)
        sw.addTarget(self, action: #selector(utcSwitchAction), for: .touchUpInside)
        return sw
    }()
    
    let compileLabel: UILabel = {
       let label = SettingLabels()
        label.text = "Compile Date: 0000/00/00"
        return label
    }()
    
    let sp02SliderLabel: UILabel = {
       let label = SettingLabels()
        label.text = "Sp02 DataSet Size: 600 Points"
        label.textAlignment = .center
        return label
    }()
    
    let sp02Slider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 600
        slider.minimumValue = 50
        slider.value = Float(sp02Data.count)
        slider.tag = 0
        slider.addTarget(self, action: #selector(sliderActionsLabel), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderActionsUpdate), for: .touchUpInside)
        return slider
    }()
    
    let ppgSliderLabel: UILabel = {
       let label = SettingLabels()
        label.text = "PPG DataSet Size: 600 Points"
        label.textAlignment = .center
        return label
    }()
    
    let ppgSlider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 600
        slider.minimumValue = 50
        slider.value = Float(heartRatePPG.count)
        slider.tag = 1
        slider.addTarget(self, action: #selector(sliderActionsLabel), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderActionsUpdate), for: .touchUpInside)
        return slider
    }()
    
    let bpmSliderLabel: UILabel = {
       let label = SettingLabels()
        label.text = "BPM DataSet Size: 600 Points"
        label.textAlignment = .center
        return label
    }()
    
    let bpmSlider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 600
        slider.minimumValue = 50
        slider.value = Float(heartRateBPM.count)
        slider.tag = 2
        slider.addTarget(self, action: #selector(sliderActionsLabel), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderActionsUpdate), for: .touchUpInside)
        return slider
    }()
    let axSliderLabel: UILabel = {
       let label = SettingLabels()
        label.text = "AccelX DataSet Size: 600 Points"
        label.textAlignment = .center
        return label
    }()
    
    let axSlider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 600
        slider.minimumValue = 50
        slider.value = Float(accelXData.count)
        slider.tag = 3
        slider.addTarget(self, action: #selector(sliderActionsLabel), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderActionsUpdate), for: .touchUpInside)
        return slider
    }()
    
    let aySliderLabel: UILabel = {
       let label = SettingLabels()
        label.text = "AccelY DataSet Size: 600 Points"
        label.textAlignment = .center
        return label
    }()
    
    let aySlider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 600
        slider.minimumValue = 50
        slider.value = Float(accelYData.count)
        slider.tag = 4
        slider.addTarget(self, action: #selector(sliderActionsLabel), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderActionsUpdate), for: .touchUpInside)
        return slider
    }()
    
    let azSliderLabel: UILabel = {
       let label = SettingLabels()
        label.text = "AccelZ DataSet Size: 600 Points"
        label.textAlignment = .center
        return label
    }()
    
    let azSlider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 600
        slider.minimumValue = 50
        slider.value = Float(accelZData.count)
        slider.tag = 5
        slider.addTarget(self, action: #selector(sliderActionsLabel), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderActionsUpdate), for: .touchUpInside)
        return slider
    }()
    
    func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(settingLabel)
        view.addSubview(backButton)
        view.addSubview(utcSwitch)
        view.addSubview(utcSwitchLabel)
        view.addSubview(compileLabel)
        view.addSubview(sp02SliderLabel)
        view.addSubview(sp02Slider)
        view.addSubview(ppgSlider)
        view.addSubview(ppgSliderLabel)
        view.addSubview(bpmSliderLabel)
        view.addSubview(bpmSlider)
        view.addSubview(axSliderLabel)
        view.addSubview(axSlider)
        view.addSubview(aySliderLabel)
        view.addSubview(aySlider)
        view.addSubview(azSliderLabel)
        view.addSubview(azSlider)
        
        setupConstraints()
        primeSwitch()
    }
    
    func primeSwitch(){
        if utcFormat == true{
            utcSwitch.setOn(true, animated: false)
        }
        if utcFormat == false{
            utcSwitch.setOn(false, animated: false)
        }
    }
    
    func setupConstraints(){
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.00558).isActive = true
        settingLabel.widthAnchor.constraint(equalToConstant: view.frame.width*0.3623).isActive = true
        settingLabel.heightAnchor.constraint(equalToConstant: view.frame.height*0.064).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.8937).isActive = true
        backButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: view.frame.height*0.0111).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        utcSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        utcSwitchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0483).isActive = true
        utcSwitchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.2415).isActive = true
        utcSwitchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.1116).isActive = true
        utcSwitchLabel.bottomAnchor.constraint(equalTo: utcSwitchLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        utcSwitch.translatesAutoresizingMaskIntoConstraints = false
        utcSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.7971).isActive = true
        utcSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        utcSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.1116).isActive = true
        utcSwitch.bottomAnchor.constraint(equalTo: utcSwitch.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        sp02SliderLabel.translatesAutoresizingMaskIntoConstraints = false
        sp02SliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        sp02SliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        sp02SliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.2009).isActive = true
        sp02SliderLabel.bottomAnchor.constraint(equalTo: sp02SliderLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        sp02Slider.translatesAutoresizingMaskIntoConstraints = false
        sp02Slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sp02Slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.2343 ).isActive = true
        sp02Slider.widthAnchor.constraint(equalToConstant: view.frame.width*0.7246).isActive = true
        sp02Slider.heightAnchor.constraint(equalToConstant: view.frame.height*0.0335).isActive = true
        
        ppgSliderLabel.translatesAutoresizingMaskIntoConstraints = false
        ppgSliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        ppgSliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        ppgSliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.2902).isActive = true
        ppgSliderLabel.bottomAnchor.constraint(equalTo: ppgSliderLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        ppgSlider.translatesAutoresizingMaskIntoConstraints = false
        ppgSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ppgSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.3348 ).isActive = true
        ppgSlider.widthAnchor.constraint(equalToConstant: view.frame.width*0.7246).isActive = true
        ppgSlider.heightAnchor.constraint(equalToConstant: view.frame.height*0.0335).isActive = true
        
        bpmSliderLabel.translatesAutoresizingMaskIntoConstraints = false
        bpmSliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        bpmSliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        bpmSliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.4018).isActive = true
        bpmSliderLabel.bottomAnchor.constraint(equalTo: bpmSliderLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        bpmSlider.translatesAutoresizingMaskIntoConstraints = false
        bpmSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bpmSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.4353 ).isActive = true
        bpmSlider.widthAnchor.constraint(equalToConstant: view.frame.width*0.7246).isActive = true
        bpmSlider.heightAnchor.constraint(equalToConstant: view.frame.height*0.0335).isActive = true
        
        axSliderLabel.translatesAutoresizingMaskIntoConstraints = false
        axSliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        axSliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        axSliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.5022).isActive = true
        axSliderLabel.bottomAnchor.constraint(equalTo: axSliderLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        axSlider.translatesAutoresizingMaskIntoConstraints = false
        axSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        axSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.5357 ).isActive = true
        axSlider.widthAnchor.constraint(equalToConstant: view.frame.width*0.7246).isActive = true
        axSlider.heightAnchor.constraint(equalToConstant: view.frame.height*0.0335).isActive = true
        
        aySliderLabel.translatesAutoresizingMaskIntoConstraints = false
        aySliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        aySliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        aySliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.6027).isActive = true
        aySliderLabel.bottomAnchor.constraint(equalTo: aySliderLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        aySlider.translatesAutoresizingMaskIntoConstraints = false
        aySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aySlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.6362 ).isActive = true
        aySlider.widthAnchor.constraint(equalToConstant: view.frame.width*0.7246).isActive = true
        aySlider.heightAnchor.constraint(equalToConstant: view.frame.height*0.0335).isActive = true
        
        azSliderLabel.translatesAutoresizingMaskIntoConstraints = false
        azSliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.0241).isActive = true
        azSliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width*0.0241).isActive = true
        azSliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.703).isActive = true
        azSliderLabel.bottomAnchor.constraint(equalTo: azSliderLabel.topAnchor, constant: view.frame.height*0.0335).isActive = true
        
        azSlider.translatesAutoresizingMaskIntoConstraints = false
        azSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        azSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.7366 ).isActive = true
        azSlider.widthAnchor.constraint(equalToConstant: view.frame.width*0.7246).isActive = true
        azSlider.heightAnchor.constraint(equalToConstant: view.frame.height*0.0335).isActive = true
        
        
        
    }
    
    @objc func backButtonAction(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func utcSwitchAction(sender: UISwitch){
        if sender.isOn == true{
            utcFormat = true
        }
        if sender.isOn == false {
            utcFormat = false
        }
    }
    
    @objc func sliderActionsUpdate(sender: UISlider){
        let sliderTag = sender.tag
        
        switch sliderTag {
        case 0:
            sp02Data = Array(repeating: Double(0), count: Int(sender.value))
            //lrgGraphDataPointSize = Int(sender.value)
            break
        case 1:
            heartRatePPG = Array(repeating: Double(0), count: Int(sender.value))
            //lrgGraphDataPointSize = Int(sender.value)
            break
        case 2:
            heartRateBPM = Array(repeating: Double(0), count: Int(sender.value))
            //lrgGraphDataPointSize = Int(sender.value)
            break
        case 3:
            accelXData = Array(repeating: Double(0), count: Int(sender.value))
            //lrgGraphDataPointSize = Int(sender.value)
            break
        case 4:
            accelYData = Array(repeating: Double(0), count: Int(sender.value))
            //lrgGraphDataPointSize = Int(sender.value)
            break
        case 5:
            accelZData = Array(repeating: Double(0), count: Int(sender.value))
            //lrgGraphDataPointSize = Int(sender.value)
            break
        default:
            break
        }
    }
    
    @objc func sliderActionsLabel(sender: UISlider){
        let sliderTag = sender.tag
        
        switch sliderTag {
        case 0:
            sp02SliderLabel.text = "Sp02 DataSet Size: \(sender.value.rounded()) Points"
            break
        case 1:
            ppgSliderLabel.text = "PPG DataSet Size: \(sender.value.rounded()) Points"
            break
        case 2:
            bpmSliderLabel.text = "BPM DataSet Size: \(sender.value.rounded()) Points"
            break
        case 3:
            axSliderLabel.text = "AccelX DataSet Size: \(sender.value.rounded()) Points"
            break
        case 4:
            aySliderLabel.text = "AccelY DataSet Size: \(sender.value.rounded()) Points"
            break
        case 5:
            azSliderLabel.text = "AccelZ DataSet Size: \(sender.value.rounded()) Points"
            break
        default:
            break
        }
    }
    
}
