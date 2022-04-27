//
//  GraphsViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit
import Charts

class GraphsViewController: UIViewController {
// MARK: Setting Views
    
    var sp02graph:UIView = {
        let view = SP02Graph()
        //view.layer.borderColor = UIColor.black.cgColor
        //view.layer.borderWidth = 2.0
        view.backgroundColor = .clear
        return view
    }()
    
    var hrGraph:UIView = {
        let view = HeartRateGraph()
        view.backgroundColor = .clear
        //Timer.init(timeInterval: 1, target: self, selector: #selector(updateHrGraph), userInfo: nil, repeats: true)
        return view
    }()
    
    var sp02GraphTitle: UILabel = {
        let label = UILabel()
        label.text = "Sp02"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .white
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 2.0
        return label
    }()
    
    var hrGraphTitle: UILabel = {
        let label = UILabel()
        label.text = "Heart Rate"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .white
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 2.0
        return label
    }()
    
    var sp02GraphYAxis: UILabel = {
        let label = UILabel()
        label.text = "Percent 02"
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .white
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 2.0
        return label
    }()
    
    var hrGraphYAxis: UILabel = {
        let label = UILabel()
        label.text = "BPM"
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .white
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 2.0
        return label
    }()
    
    var sp02GraphXAxis: UILabel = {
        let label = UILabel()
        label.text = "Time (s)"
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = .white
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 2.0
        return label
    }()
    
    var hrGraphXAxis: UILabel = {
        let label = UILabel()
        label.text = "Time (s)"
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = .white
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 2.0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    
    
    
    // MARK: Views Setup
    func setupView(){
        
        //print("Setting Up Views")
        view.addSubview(sp02graph)
        view.addSubview(sp02GraphTitle)
        view.addSubview(sp02GraphYAxis)
        view.addSubview(sp02GraphXAxis)
        view.addSubview(hrGraph)
        view.addSubview(hrGraphTitle)
        view.addSubview(hrGraphXAxis)
        view.addSubview(hrGraphYAxis)
        
        sp02GraphXAxis.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        sp02GraphYAxis.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        sp02GraphTitle.frame = CGRect(x: 0, y: 0, width: 90, height: 40)
        sp02graph.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        
        hrGraphXAxis.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        hrGraphYAxis.frame = CGRect(x: 0, y: 0, width: 90, height: 40)
        hrGraphTitle.frame = CGRect(x: 0, y: 0, width: 140, height: 40)
        hrGraph.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        
        
        // MARK: Top Graph Constraints
        sp02graph.translatesAutoresizingMaskIntoConstraints = false
        sp02graph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sp02graph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20 ).isActive = true
        sp02graph.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +20).isActive = true
        sp02graph.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.size.height/3)+40).isActive = true
        
        sp02GraphTitle.translatesAutoresizingMaskIntoConstraints = false
        sp02GraphTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width/2)-(sp02GraphTitle.frame.size.width/2)).isActive = true
        sp02GraphTitle.trailingAnchor.constraint(equalTo: (view.trailingAnchor), constant: -(view.frame.size.width/2)+(sp02GraphTitle.frame.size.width/2)).isActive = true
        sp02GraphTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +10).isActive = true
        
        
        sp02GraphYAxis.translatesAutoresizingMaskIntoConstraints = false
        sp02GraphYAxis.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30).isActive = true
        sp02GraphYAxis.trailingAnchor.constraint(equalTo: (view.trailingAnchor), constant: -view.frame.size.width + 5 + sp02GraphYAxis.frame.width).isActive = true
        sp02GraphYAxis.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        sp02GraphYAxis.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        sp02GraphXAxis.translatesAutoresizingMaskIntoConstraints = false
        sp02GraphXAxis.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width/2)-(sp02GraphXAxis.frame.size.width/2)).isActive = true
        sp02GraphXAxis.trailingAnchor.constraint(equalTo: (view.trailingAnchor), constant: -(view.frame.size.width/2)+(sp02GraphXAxis.frame.size.width/2)).isActive = true
        sp02GraphXAxis.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  (view.frame.size.height/4)-30).isActive = true
        
        // MARK: Bottom Graph Constraints
        hrGraph.translatesAutoresizingMaskIntoConstraints = false
        hrGraph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hrGraph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20 ).isActive = true
        hrGraph.topAnchor.constraint(equalTo: sp02graph.bottomAnchor, constant: +40).isActive = true
        
        hrGraphTitle.translatesAutoresizingMaskIntoConstraints = false
        hrGraphTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width/2)-(hrGraphTitle.frame.size.width/2)).isActive = true
        hrGraphTitle.trailingAnchor.constraint(equalTo: (view.trailingAnchor), constant: -(view.frame.size.width/2)+(hrGraphTitle.frame.size.width/2)).isActive = true
        hrGraphTitle.topAnchor.constraint(equalTo: sp02graph.bottomAnchor, constant: +30).isActive = true
        
        hrGraphYAxis.translatesAutoresizingMaskIntoConstraints = false
        hrGraphYAxis.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30).isActive = true
        hrGraphYAxis.trailingAnchor.constraint(equalTo: (view.trailingAnchor), constant: -view.frame.size.width + 5 + hrGraphYAxis.frame.width).isActive = true
        hrGraphYAxis.topAnchor.constraint(equalTo: sp02graph.bottomAnchor, constant: 90).isActive = true
        hrGraphYAxis.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
       
        
        hrGraphXAxis.translatesAutoresizingMaskIntoConstraints = false
        hrGraphXAxis.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.size.width/2)-(hrGraphXAxis.frame.size.width/2)).isActive = true
        hrGraphXAxis.trailingAnchor.constraint(equalTo: (view.trailingAnchor), constant: -(view.frame.size.width/2)+(hrGraphXAxis.frame.size.width/2)).isActive = true
        hrGraphXAxis.topAnchor.constraint(equalTo: hrGraph.topAnchor , constant:(view.frame.size.height/4)-50)  .isActive = true
    }
    
}
