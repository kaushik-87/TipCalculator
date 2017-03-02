//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Kaushik Thekkekere

import Foundation
import UIKit

class SettingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var defaultTip: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: chalkDusterFontName, size: 20)!,NSForegroundColorAttributeName: UIColor.white]
        
        let rightButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SaveSettings))
        rightButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: chalkDusterFontName, size: 20)!,NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        navigationItem.rightBarButtonItem = rightButton
        let leftButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Back))
        leftButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: chalkDusterFontName, size: 20)!,NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard;
        self.defaultTip.selectRow(userDefaults.integer(forKey: defaultTipValue), inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

//    @IBAction func SliderHideAction(_ sender: Any) {
//    }

    @IBAction func SaveSettings(_ sender: Any) {
        let userDefaults = UserDefaults.standard;
        userDefaults.set(Int(self.defaultTip.selectedRow(inComponent: 0)), forKey: defaultTipValue)
        userDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 31
    }

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 35.00
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: chalkDusterFontName, size: 35)
        
        label.text = String(row)
        
        return label
    }

}
