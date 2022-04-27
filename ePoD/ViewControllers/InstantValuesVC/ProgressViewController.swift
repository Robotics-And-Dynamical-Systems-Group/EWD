//
//  ProgressViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 5/18/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

var conversion = 0.0

class ProgressViewController: UIViewController {

    let BL = bleService()
    let shapeLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)

    }
    
    @objc func timerFunc(){
        progressLayer.strokeEnd = CGFloat(bleProgress/6.28)
        conversion = bleProgress*16.6
        //print(bleProgress)
        percentLabel.text = "\(conversion.rounded(toPlaces: 1))%"
        if conversion >= 99.1 {
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    var percentLabel: UILabel = {
       let label = Mylabels()
        label.text = "100%"
        label.textAlignment = .center
        
        return label
    }()
    
    var backView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    func setupView(){
        view.backgroundColor = colorA8CABA
        print(view.frame)
        
        view.addSubview(backView)
        view.addSubview(percentLabel)
        
        let center = CGPoint(x: view.frame.width/2, y: (view.frame.height/3)+view.frame.height*0.0947)
        
        if screenSize.height > 800 {
            backView.translatesAutoresizingMaskIntoConstraints = false
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height/3).isActive = true
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            backView.heightAnchor.constraint(equalToConstant: 170).isActive = true
            backView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            
            percentLabel.translatesAutoresizingMaskIntoConstraints = false
            percentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (screenSize.height/3)+view.frame.height*0.0725).isActive = true
            percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            percentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            percentLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        }
        
        if screenSize.height > 700 && screenSize.height < 800 {
            backView.translatesAutoresizingMaskIntoConstraints = false
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: (screenSize.height/3) - 15).isActive = true
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            backView.heightAnchor.constraint(equalToConstant: 170).isActive = true
            backView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            
            percentLabel.translatesAutoresizingMaskIntoConstraints = false
            percentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (screenSize.height/3)+48).isActive = true
            percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            percentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            percentLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        }
        if screenSize.height < 700 {
            backView.translatesAutoresizingMaskIntoConstraints = false
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant:(screenSize.height/3)-22).isActive = true
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            backView.heightAnchor.constraint(equalToConstant: 170).isActive = true
            backView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            
            percentLabel.translatesAutoresizingMaskIntoConstraints = false
            percentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (screenSize.height/3)+40).isActive = true
            percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            percentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            percentLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        }
        
        
        
        
        
        
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width/6, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        progressLayer.path = circularPath.cgPath
        progressLayer.lineWidth = 16
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.strokeEnd = 0.0
        
        view.layer.addSublayer(shapeLayer)
        view.layer.addSublayer(progressLayer)
        
        
        
        
       
    }

}
