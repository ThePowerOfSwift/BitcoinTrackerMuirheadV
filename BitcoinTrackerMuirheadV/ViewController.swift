//
//  ViewController.swift
//  BitcoinTrackerMuirheadV
//
//  Created by c85529 on 10/16/18.
//  Copyright © 2018 c85529. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{
    
    @IBOutlet weak var priceLabel: UILabel!
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var finalURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func getBitcoinData(apiUrl: URL){
        print(apiUrl)
        
        //make api request
        Alamofire.request(apiUrl,method: .get).responseJSON { response in
            print(response)
            //response is the data gotten back after api call
            if response.result.isSuccess{
                
                //convert response data from ANY format to JSON format by casting
                let bitcoinJSON: JSON = JSON(response.result.value!)
                
                self.updateBitcoinData(bitcoinJSON: bitcoinJSON)
                
                
            }else if response.result.isFailure{
                print("Failed to get API Data sorry..")
                self.priceLabel.text = "Jahko"
            }
            else{
                print("ok")
            }
        }
    }
    
    func updateBitcoinData(bitcoinJSON:JSON){
        
        if let bitcoinPrice = bitcoinJSON["ask"].double
        {
            priceLabel.text = String(bitcoinPrice)
            
        }
        else
        {
            print("failed in updating bitcoinData")
        }
    }
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    //data in each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    //which row user selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        var finalURL2 = URL(string: finalURL)
        getBitcoinData(apiUrl: finalURL2!)
    }
    
}

