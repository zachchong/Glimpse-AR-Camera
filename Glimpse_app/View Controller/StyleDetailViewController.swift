//
//  StyleDetailViewController.swift
//  ARshirt
//
//  Created by Chong Zhuang Hong on 17/01/2021.
//

import Foundation
import UIKit
import GoogleMobileAds

class StyleDetailViewController: UIViewController{
    
    var styleTitle : String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var scene = [Scene]()
    
    private var rewardedAd: GADRewardedAd!
    
    let userDefaults = UserDefaults()
    
    var errorMessage : String?
    
    //MARK:- Shirt Scene
    var glimpse : [Scene] = [
        Scene(sceneName: "D1.mp4", firstTitle: "", secondTitle: "*D1*", sceneImage: "D1", lockIsHidden: true),
        Scene(sceneName: "D2.m4v", firstTitle: "", secondTitle: "*D2*", sceneImage: "D2", lockIsHidden: false),
        Scene(sceneName: "D3.m4v", firstTitle: "", secondTitle: "*D3*", sceneImage: "D3", lockIsHidden: false)
    ]
    
    var PUBG : [Scene] = [
        Scene(sceneName: "art.scnassets/PUBG/AWM.scn", firstTitle: "", secondTitle: "AWM 🔥", sceneImage: "AWM", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/PUBG/box.scn", firstTitle: "", secondTitle: "PUBG Air Drop Boxes", sceneImage: "PUBG Air Drop Boxes", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/PUBG/car.scn", firstTitle: "", secondTitle: "UAZ", sceneImage: "UAZ", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/PUBG/flareGun.scn", firstTitle: "", secondTitle: "Flare Gun", sceneImage: "Flare Gun", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/PUBG/grenade.scn", firstTitle: "", secondTitle: "Grenade 🔥", sceneImage: "Grenade", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/PUBG/model.scn", firstTitle: "", secondTitle: "PUBG Action Figure Male 🔥", sceneImage: "PUBG Action Figure Male", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/PUBG/pan.scn", firstTitle: "", secondTitle: "Pan", sceneImage: "Pan", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/PUBG/parachute.scn", firstTitle: "", secondTitle: "Parachute 🔥", sceneImage: "Parachute", lockIsHidden: false)
    ]
    
    var Among_Us : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Among Us/blue.scn", firstTitle: "", secondTitle: "Blue 🔥", sceneImage: "blue", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Among Us/red.scn", firstTitle: "", secondTitle: "Red 🔥", sceneImage: "red", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Among Us/white.scn", firstTitle: "", secondTitle: "White", sceneImage: "white", lockIsHidden: true),
    
    ]
    
    
    var animalScene : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Animal/cat1.scn", firstTitle: "猫", secondTitle: "Cat 🔥", sceneImage: "cat1", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Animal/crocodile.scn", firstTitle: "鳄鱼", secondTitle: "Crocodile", sceneImage: "crocodile", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Animal/dinosour.scn", firstTitle: "恐龙", secondTitle: "Dinosour 🔥", sceneImage: "dinosour", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Animal/dog3.scn", firstTitle: "狗", secondTitle: "Dog", sceneImage: "dog3", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Animal/shark.scn", firstTitle: "鲨鱼", secondTitle: "Shark 🔥", sceneImage: "shark", lockIsHidden: false),
        
        
    ]
    
    
    var foodScene : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Food/cake1.scn", firstTitle: "蛋糕", secondTitle: "Cake", sceneImage: "cake1", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Food/cake2.scn", firstTitle: "蛋糕", secondTitle: "Cake", sceneImage: "cake2", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Food/dessert.scn", firstTitle: "甜点", secondTitle: "Dessert", sceneImage: "dessert", lockIsHidden: true)
        
    ]
    
    var glassesScene : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Glasses/glasses1.scn", firstTitle: "眼镜", secondTitle: "Glasses", sceneImage: "glasses1", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Glasses/glasses2.scn", firstTitle: "眼镜", secondTitle: "Glasses 🔥", sceneImage: "glasses2", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Glasses/glasses3.scn", firstTitle: "眼镜", secondTitle: "Glasses", sceneImage: "glasses3", lockIsHidden: false)
        
        
    ]
    
    var maskScene : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Mask/batmanMask.scn", firstTitle: "蝙蝠侠面具", secondTitle: "Batman Mask", sceneImage: "batmanMask", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Mask/steampunkMask.scn", firstTitle: "蒸汽朋克面具", secondTitle: "Steampunk Mask", sceneImage: "steampunkMask", lockIsHidden: true),
        Scene(sceneName: "art.scnassets/Mask/weldingMask.scn", firstTitle: "焊接头盔", secondTitle: "Welding Helmet 🔥", sceneImage: "weldingMask", lockIsHidden: false)
        
    ]
    
    var customScene : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Custom/robot.scn", firstTitle: "机器人", secondTitle: "Robot", sceneImage: "robot", lockIsHidden: false),
        
    ]
    
    var sampleScene : [Scene] = [
        
        Scene(sceneName: "art.scnassets/Sample/phoenixBird.scn", firstTitle: "凤凰", secondTitle: "Phoenix 🔥", sceneImage: "phoenix", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Sample/nezuko.scn", firstTitle: "", secondTitle: "Nezuko", sceneImage: "NezukoCute", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Sample/Inosuke.scn", firstTitle: "", secondTitle: "Inosuke", sceneImage: "InosukeCute", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Animal/dog1.scn", firstTitle: "狗", secondTitle: "Dog 🔥", sceneImage: "dog1", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Mask/venetianMask.scn", firstTitle: "威尼斯面具", secondTitle: "Venetian Mask 🔥", sceneImage: "venetianMask", lockIsHidden: false),
        Scene(sceneName: "art.scnassets/Mask/makomosMask.scn", firstTitle: "真菰の仮面", secondTitle: "Makomo - Mask 🔥", sceneImage: "makomoMask", lockIsHidden: false)
        
    ]
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "detailTableViewCell")
        
        if let titleText = styleTitle {
            navigationBar.topItem?.title = titleText
        }
        
        tableView.register(UINib(nibName: "StyleTableViewCell", bundle: nil), forCellReuseIdentifier: "styleTableViewCell")
        
        //MARK:- Scene Methods
        if styleTitle == "Animal" {
            scene = animalScene
        } else if styleTitle == "PUBG" {
            scene = PUBG
        } else if styleTitle == "Among Us" {
            scene = Among_Us
        } else if styleTitle == "Food" {
            scene = foodScene
        } else if styleTitle == "Glasses" {
            scene = glassesScene
        } else if styleTitle == "Mask" {
            scene = maskScene
        } else if styleTitle == "Custom" {
            scene = customScene
        } else if styleTitle == "Sample🔥" {
            scene = sampleScene
        } else if styleTitle == "Glimpse" {
            scene = glimpse
        }
        
//        rewardedAd = createAndLoadAds()
        
        //MARK:- user default
        let crocodile = userDefaults.value(forKey: "crocodile") as? Bool
        let dinosour = userDefaults.value(forKey: "dinosour") as? Bool
        let shark = userDefaults.value(forKey: "shark") as? Bool
        let glasses2 = userDefaults.value(forKey: "glasses2") as? Bool
        let glasses3 = userDefaults.value(forKey: "glasses3") as? Bool
        let weldingHelmet = userDefaults.value(forKey: "weldingHelmet") as? Bool
        let robot = userDefaults.value(forKey: "robot") as? Bool
        let phoenix = userDefaults.value(forKey: "phoenix") as? Bool
        let dog = userDefaults.value(forKey: "dog") as? Bool
        let venetianMask = userDefaults.value(forKey: "venetianmask") as? Bool
        let makomoMask = userDefaults.value(forKey: "makomomask") as? Bool
        let D2 = userDefaults.value(forKey: "D2") as? Bool
        let D3 = userDefaults.value(forKey: "D3") as? Bool
        let red = userDefaults.value(forKey: "red") as? Bool
        let blue = userDefaults.value(forKey: "blue") as? Bool
        let AWM = userDefaults.value(forKey: "AWM") as? Bool
        let UAZ = userDefaults.value(forKey: "UAZ") as? Bool
        let grenade = userDefaults.value(forKey: "grenade") as? Bool
        let male = userDefaults.value(forKey: "male") as? Bool
        let parachute = userDefaults.value(forKey: "parachute") as? Bool
        let nezuko = userDefaults.value(forKey: "nezuko") as? Bool
        let inosuke = userDefaults.value(forKey: "inosuke") as? Bool
        
        
        
        if styleTitle == "Animal"{
            scene[1].lockIsHidden = crocodile ?? false
            scene[2].lockIsHidden = dinosour ?? false
            scene[4].lockIsHidden = shark ?? false
        }
        
        if styleTitle == "PUBG" {
            scene[0].lockIsHidden = AWM ?? false
            scene[2].lockIsHidden = UAZ ?? false
            scene[4].lockIsHidden = grenade ?? false
            scene[5].lockIsHidden = male ?? false
            scene[7].lockIsHidden = parachute ?? false
        }
        
        if styleTitle == "Among Us" {
            scene[0].lockIsHidden = blue ?? false
            scene[1].lockIsHidden = red ?? false
        }
        
        if styleTitle == "Glasses" {
            scene[1].lockIsHidden = glasses2 ?? false
            scene[2].lockIsHidden = glasses3 ?? false
        }
        
        if styleTitle == "Mask" {
            scene[2].lockIsHidden = weldingHelmet ?? false
            
        }
        
        if styleTitle == "Custom" {
            scene[0].lockIsHidden = robot ?? false
        }
        
        if styleTitle == "Sample🔥" {
            scene[0].lockIsHidden = phoenix ?? false
            scene[1].lockIsHidden = nezuko ?? false
            scene[2].lockIsHidden = inosuke ?? false
            scene[3].lockIsHidden = dog ?? false
            scene[4].lockIsHidden = venetianMask ?? false
            scene[5].lockIsHidden = makomoMask ?? false
        }
        
        if styleTitle == "Glimpse" {
            scene[1].lockIsHidden = D2 ?? false
            scene[2].lockIsHidden = D3 ?? false
        }
        
        
    }
    
    func createAndLoadAds() -> GADRewardedAd {
        
        let alert = UIAlertController(title: nil , message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        let rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3547836528823419/3981599115")
        rewardedAd.load(GADRequest()) { error in
            
            
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.dismiss(animated: true, completion: self.showError)
                    
                }  else {
                    print("Ads loaded successfully")
                    self.dismiss(animated: true, completion: self.presentAds)
                }
                
        }
        return rewardedAd
        
    }
    
    @objc func presentAds() {
        rewardedAd.present(fromRootViewController: self, delegate: self)
    }
    
    @objc func showError() {
        let alert = UIAlertController(title: nil , message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            
            destination.sceneName = scene[(tableView.indexPathForSelectedRow)!.row].sceneName
            
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    
    
}

//MARK:- UITableViewDataSource

extension StyleDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scene.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell") as! DetailTableViewCell
        cell.titleJapanese.text = scene[indexPath.row].firstTitle
        cell.titleEnglish.text = scene[indexPath.row].secondTitle
        cell.sceneImage.image = UIImage(named: scene[indexPath.row].sceneImage)
        cell.lock.isHidden = scene[indexPath.row].lockIsHidden
    
        return cell
    }
    
    
}

//MARK:- UITableViewDelegate

extension StyleDetailViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let cellSelected = tableView.cellForRow(at: indexPath) as! DetailTableViewCell
        
        if cellSelected.lock.isHidden == false {
            
            rewardedAd = createAndLoadAds()
            
        } else {
            performSegue(withIdentifier: "goToCameraView", sender: self)
        }
        

    }
}

//MARK:- GADReward

extension StyleDetailViewController : GADRewardedAdDelegate{
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        
        if styleTitle == "Animal" {
            if tableView.indexPathForSelectedRow!.row == 1 {
                userDefaults.setValue(true, forKey: "crocodile")
            } else if tableView.indexPathForSelectedRow!.row == 2 {
                userDefaults.setValue(true, forKey: "dinosour")
            } else if tableView.indexPathForSelectedRow!.row == 4 {
                userDefaults.setValue(true, forKey: "shark")
            }
        } else if styleTitle == "PUBG" {
            if tableView.indexPathForSelectedRow!.row == 0 {
                userDefaults.setValue(true, forKey: "AWM")
            } else if tableView.indexPathForSelectedRow!.row == 2 {
                userDefaults.setValue(true, forKey: "UAZ")
            } else if tableView.indexPathForSelectedRow!.row == 4 {
                userDefaults.setValue(true, forKey: "grenade")
            } else if tableView.indexPathForSelectedRow!.row == 5 {
                userDefaults.setValue(true, forKey: "male")
            } else if tableView.indexPathForSelectedRow!.row == 7 {
                userDefaults.setValue(true, forKey: "parachute")
            }
        } else if styleTitle == "Among Us" {
            if tableView.indexPathForSelectedRow!.row == 0 {
                userDefaults.setValue(true, forKey: "blue")
            } else if tableView.indexPathForSelectedRow!.row == 1 {
                userDefaults.setValue(true, forKey: "red")
            }
        } else if styleTitle == "Glasses" {
            if tableView.indexPathForSelectedRow!.row == 1 {
                userDefaults.setValue(true, forKey: "glasses2")
            } else if tableView.indexPathForSelectedRow!.row == 2 {
                userDefaults.setValue(true, forKey: "glasses3")
            }
        } else if styleTitle == "Mask" {
            if tableView.indexPathForSelectedRow!.row == 2 {
                userDefaults.setValue(true, forKey: "weldingHelmet")
            }
        } else if styleTitle == "Custom" {
            if tableView.indexPathForSelectedRow!.row == 0 {
                userDefaults.setValue(true, forKey: "robot")
            }
        } else if styleTitle == "Sample🔥" {
            if tableView.indexPathForSelectedRow!.row == 0 {
                userDefaults.setValue(true, forKey: "phoenix")
            } else if tableView.indexPathForSelectedRow!.row == 1 {
                userDefaults.setValue(true, forKey: "nezuko")
            } else if tableView.indexPathForSelectedRow!.row == 2 {
                userDefaults.setValue(true, forKey: "inosuke")
            } else if tableView.indexPathForSelectedRow!.row == 3 {
                userDefaults.setValue(true, forKey: "dog")
            } else if tableView.indexPathForSelectedRow!.row == 4 {
                userDefaults.setValue(true, forKey: "venetianmask")
            } else if tableView.indexPathForSelectedRow!.row == 5 {
                userDefaults.setValue(true, forKey: "makomomask")
            }
        } else if styleTitle == "Glimpse" {
            if tableView.indexPathForSelectedRow!.row == 1 {
                userDefaults.setValue(true, forKey: "D2")
            } else if tableView.indexPathForSelectedRow!.row == 2 {
                userDefaults.setValue(true, forKey: "D3")
            }
        }
        
    }
    
    func rewardedAdDidDismiss(_ rewardAd: GADRewardedAd) {
        performSegue(withIdentifier: "goToCameraView", sender: self)
    }
    
}
