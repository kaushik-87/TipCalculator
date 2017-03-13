//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kaushik Thekkekere 
import UIKit
class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource  {

    let calculator = Calculator()
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var tipInPercentage: UISlider!
    @IBOutlet weak var tipAmount: UITextField!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var splitBetween: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: chalkDusterFontName, size: 20)!,NSForegroundColorAttributeName: UIColor.white]


        self.billAmount.attributedPlaceholder =
            NSAttributedString(string: "$0.00", attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
        self.tipAmount.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
        self.billAmount.becomeFirstResponder()
        self.billAmount.delegate = self
        self.totalAmount.text = localizedCurrencyInString(value: NSNumber(value: 0.00))
        self.tipValue.text = String(format:"%.0f",self.tipInPercentage.value)
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGestureRecogniser)
        
        self.tipInPercentage.setThumbImage(UIImage(named:"Chalk-2"), for: UIControlState.normal)
        self.tipInPercentage.setThumbImage(UIImage(named:"Chalk-2"), for: UIControlState.highlighted)
        self.tipInPercentage.setMaximumTrackImage(nil, for: UIControlState.normal)
        self.tipInPercentage.setMinimumTrackImage(UIImage (named:"Chalk_line2"), for: UIControlState.normal)
        
        let userDefaults = UserDefaults.standard;
        userDefaults.set(18, forKey: defaultTipValue)
        userDefaults.synchronize()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard;
        if ((userDefaults.object(forKey: defaultTipValue)) != nil)
        {
            self.tipInPercentage.value = Float(userDefaults.integer(forKey: defaultTipValue))
            self.tipValue.text = String(format:"%.0f",self.tipInPercentage.value)

        }

    }
    


func tap(sender: UITapGestureRecognizer) {
    if self.billAmount.isFirstResponder {
        billAmount.resignFirstResponder()
    }
}
    

    func calculateTip() -> Void {
        
        let string = self.billAmount.text
        
        if (string != "")
        {
            let tipAmount = calculator.calculateTipAmount(billAmount: currencyNumberFormatter().number(from: self.billAmount.text!)!, tipPercentage: NumberFormatter().number(from: self.tipValue.text!)!)
            self.tipAmount.text = localizedCurrencyInString(value: tipAmount)
            var total = calculator.totalAmount(billAmount: currencyNumberFormatter().number(from: self.billAmount.text!)!, tipAmount: tipAmount)
            if(splitBetween.selectedRow(inComponent: 0)>0)
            {
                total = calculator.splitAmount(totalAmount: total, splitBy: NSNumber(value: splitBetween.selectedRow(inComponent: 0)+1))
            }
            self.totalAmount.text = localizedCurrencyInString(value: total)
        }
        

    }
    
    
    func localizedCurrencyInString(value:NSNumber) -> String {
    
        return currencyNumberFormatter().string(from: value)!
    }
    
    // Number formatter used for displaying the values
    func currencyNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter;
    }

    @IBAction func sliderAction(_ sender: Any) {
        self.tipValue.text = String(format:"%.0f",self.tipInPercentage.value)
        if((self.billAmount.text?.characters.count)!>0)
        {
            calculateTip()
        }
    }
    
    
    
    //TextField delegate methods to handle the input values and default behaviours
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        self.billAmount.text = ""
        return true;
    }
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        if((textField.text?.characters.count)!>1)
        {
            self.billAmount.text = localizedCurrencyInString(value: NSNumber(value: Float(textField.text!)!))
            calculateTip()

        }
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            if ((textField.text?.contains("."))! && string == ".") {
                return false
            }

        return true
        }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 10
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
        
        
        var splitBetWeenStr = "None"
        if(row != 0)
        {
            splitBetWeenStr = String(format:"%d People",row+1)
        }
        label.text = splitBetWeenStr
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        calculateTip()
    }

}


