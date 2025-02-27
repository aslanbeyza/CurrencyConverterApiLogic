//
//  ViewController.swift
//  CurrencyConverterApiLogic
//
//  Created by Beyza Aslan on 27.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gepLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=52b98d58eb8966f9db912f2c5e6d898b")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Hata", message: error.localizedDescription, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            } else if let data = data {
                do {                                                                                             //casting  key string ama karşısında geleni bilemezsin o any                                                                                                olur
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String,Any>
                    
                    
                    DispatchQueue.main.async {
                        //print(jsonResponse["rates"]) // JSON verisini yazdır
                        if let rates = jsonResponse["rates"] as? [String:Any] {
                            print(rates)
                            
                            if let cad  =  rates["CAD"] as? Double {
                                //print("cad değeri ->",cad)
                                self.cadLabel.text = "CAD: \(cad)"
                                self.chfLabel.text = "CHF: \(cad * 0.9072)"
                                self.gepLabel.text = "GEL: \(cad * 3.7744)"
                                self.jpyLabel.text = "JPY: \(cad * 128.07)"
                                self.usdLabel.text = "USD: \(cad * 1.0936)"
                                self.tryLabel.text = "TRY: \(cad * 7.018)"
                            }
//                            Bu şekildede tek tek devam edebilirdi
//                            // CHF Kuru
//                            if let chf = rates["CHF"] as? Double {
//                                self.chfLabel.text = "CHF: \(chf)"
//                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "JSON Hatası", message: "Veri işlenirken hata oluştu: \(error.localizedDescription)", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        task.resume()
    }
    
}
