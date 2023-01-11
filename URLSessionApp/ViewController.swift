//
//  ViewController.swift
//  URLSessionApp
//
//  Created by Sosin Vladislav on 11.01.2023.
//

import UIKit

class ViewController: UIViewController {
    let link = "https://picsum.photos/v2/list"
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let course = try jsonDecoder.decode([Image].self, from: data)
                print(course)
                self.successAlert()
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
            
        }.resume()
    }
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
