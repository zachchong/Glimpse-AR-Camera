//
//  supportViewController.swift
//  Glimpse
//
//  Created by Chong Zhuang Hong on 01/02/2021.
//

import Foundation
import UIKit

class SupportViewController : UIViewController {
    
    @IBOutlet weak var supportTableView: UITableView!
    
    var supportMessage : [Support] = [
        
        Support(title: "3D Model", body: "First, choose your 3D model. Then, SCAN your SHIRT LOGO. You may use the flashlight to help you in dark. That's it. Have fun!", image: "arkit"),
        Support(title: "Scanning Logo", body: "Your casual T-shirt will not work on this app. Don't worry, you can try out our limited SAMPLE or GRAB your stylish GLIMPSE SHIRT now and enjoy your AR experience. Check out our ONLINE STORE on Instagram or Facebook!", image: "camera.metering.unknown"),
        Support(title: "Sample", body: "Congratulation! We have some SAMPLE for you to try out our app. Choose one of the samples and POINT the camera on our app icon. You can find full app icon image on our INSTAGRAM. Don't miss out!", image: "shippingbox"),
        Support(title: "Unlock", body: "You can easily UNLOCK the HOTS 3R model by watching a reward ads. Make sure you have a connection to the Internet. It usually takes few seconds to load the ads. Thank you for your patience.", image: "lock")
        
    ]
    
    override func viewDidLoad() {
        
        supportTableView.dataSource = self
        supportTableView.register(UINib(nibName: "SupportTableViewCell", bundle: nil), forCellReuseIdentifier: "supportTableViewCell")
    }
    
    @IBAction func instagramButtonPressed(_ sender: UIButton) {
        
        openUrl(urlStr: "https://www.instagram.com/glimpse_outfits/")
        
    }
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        
        openUrl(urlStr: "https://m.facebook.com/glimpseoutfitsAR/")
        
    }
    
    func openUrl(urlStr: String!) {
        if let url = URL(string:urlStr), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension SupportViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        supportMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supportTableViewCell") as! SupportTableViewCell
        cell.title.text = supportMessage[indexPath.row].title
        cell.body.text = supportMessage[indexPath.row].body
        cell.supportImage.image = UIImage(systemName: supportMessage[indexPath.row].image)
        return cell
    }
    
    
}
