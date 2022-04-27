//
//  BLEPopOutViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/14/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class BLEPopOutViewController: UIViewController {
    private var selectedRow = Int()
    //MARK: UI Element Creation
    var containerViewPicker: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        return view
    }()
    
    let picker = SelectBlePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        setupView()
        toolbarSetup()
    }
    
    //MARK: View Setup
    func setupView(){
        view.backgroundColor = colorA8CABA
        view.addSubview(containerViewPicker)
        containerViewPicker.addSubview(picker)
        
        containerViewPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height/3).isActive = true
        containerViewPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerViewPicker.heightAnchor.constraint(equalToConstant: 170).isActive = true
        containerViewPicker.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        picker.centerXAnchor.constraint(equalTo: containerViewPicker.centerXAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: containerViewPicker.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: containerViewPicker.bottomAnchor).isActive = true
        picker.leftAnchor.constraint(equalTo: containerViewPicker.leftAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: containerViewPicker.rightAnchor).isActive = true
        
    }
    
    
    //MARK: Toolbar Setup
    func toolbarSetup() {
        let bleToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        bleToolbar.translatesAutoresizingMaskIntoConstraints = false
        bleToolbar.barStyle = .default
        bleToolbar.isTranslucent = true
        bleToolbar.tintColor = .white
        bleToolbar.clipsToBounds = true
        bleToolbar.barTintColor = .darkGray
        
        bleToolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        bleToolbar.isUserInteractionEnabled = true
        
        containerViewPicker.addSubview(bleToolbar)
        bleToolbar.centerXAnchor.constraint(equalTo: picker.centerXAnchor).isActive = true
        bleToolbar.topAnchor.constraint(equalTo: containerViewPicker.topAnchor).isActive = true
        bleToolbar.leadingAnchor.constraint(equalTo: containerViewPicker.leadingAnchor).isActive = true
        bleToolbar.trailingAnchor.constraint(equalTo: containerViewPicker.trailingAnchor).isActive = true
        
    }
    //MARK: Button Actions
    @objc func doneButtonAction(sender: UIBarButtonItem){
       
        print("Done Pressed")
        if perphNames.isEmpty == false  {
            print("Selected Bluetooth Peripheral: \(perphNames[selectedRow])")
            
            let dispatchQueue = DispatchQueue(label: "Selected Bluetooth Queue", qos: .background)
            dispatchQueue.async {
                bluetooth.connectToPerph(peripheral: peripherals[self.selectedRow])
            }
            weak var pvc = self.presentingViewController
            self.dismiss(animated: true, completion: {
                let vc = ProgressViewController()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                pvc?.present(vc, animated: true, completion: nil)
            })
            
 
        }
        else{
            bleCancel = true
            print("Connection Bad")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func cancelButtonAction(sender: UIBarButtonItem){
        print("Cancel Pressed")
        bleCancel = true
        self.dismiss(animated: true, completion: nil)
    }
    

}
//MARK: UIPicker Extension
extension BLEPopOutViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(perphNames)
        return perphNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let label = NSAttributedString(string: perphNames[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}
