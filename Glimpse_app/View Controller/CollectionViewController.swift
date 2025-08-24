//
//  collectionViewController.swift
//  ARshirt
//
//  Created by Chong Zhuang Hong on 16/01/2021.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var styleTableView: UITableView!
    
    var styles: [Collection] = [
    
        Collection(style: "Glimpse", image: "glimpse"),
        Collection(style: "PUBG", image: "PUBG Action Figure Male"),
        Collection(style: "Sample🔥", image: "NezukoCute"),
        Collection(style: "Among Us", image: "red"),
        Collection(style: "Animal", image: "dog1"),
        Collection(style: "Food", image: "cake1"),
        Collection(style: "Glasses", image: "glasses2"),
        Collection(style: "Mask", image: "weldingMask"),
        Collection(style: "Custom", image: "custom"),
        
        
    ]
    
    override func viewDidLoad() {
        
        styleTableView.dataSource = self
        styleTableView.delegate = self
        styleTableView.register(UINib(nibName: "StyleTableViewCell", bundle: nil), forCellReuseIdentifier: "styleTableViewCell")
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- StyleDetailViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StyleDetailViewController {
            destination.styleTitle = styles[(styleTableView.indexPathForSelectedRow)!.row].style
            styleTableView.deselectRow(at: styleTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}

extension CollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        styles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "styleTableViewCell") as! StyleTableViewCell
        cell.label.text = styles[indexPath.row].style
        cell.shirtImage.image = UIImage(named: styles[indexPath.row].image)
        return cell
    }
    
    
}

extension CollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToStyleDetail", sender: self)
    }
}
