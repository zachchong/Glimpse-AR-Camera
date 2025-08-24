//
//  ViewController.swift
//  ARshirt
//
//  Created by Chong Zhuang Hong on 14/01/2021.
//

import UIKit
import SceneKit
import ARKit
import ARVideoKit
import Photos
import AVFoundation
import GoogleMobileAds

class ViewController: UIViewController, ARSCNViewDelegate, RecordARDelegate, RenderARDelegate {
    
    //From StyleDetailViewController
//    var choseArray : [Scene] = []
    var player: AVAudioPlayer!
    var sound = ""
    var sceneName : String?
    var index = 1
    var isVideo = false
    var videoNode = SKVideoNode()
    
    
    private var interstitialAd : GADInterstitial!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var shootingButton: UIButton!
    
    @IBOutlet weak var flashButton: UIButton!
    
    @IBOutlet var sceneView: ARSCNView!
    
    let recordingQueue = DispatchQueue(label: "recordingThread", attributes: .concurrent)
    let caprturingQueue = DispatchQueue(label: "capturingThread", attributes: .concurrent)

    var recorder:RecordAR?
    
    //MARK:- View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        //shootbutton
        shootingButton.setImage(UIImage(named: "Photo"), for: .normal)
        
        recorder = RecordAR(ARSceneKit: sceneView)
        
        /*----👇---- ARVideoKit Configuration ----👇----*/
        
        // Set the recorder's delegate
        recorder?.delegate = self
        
        // Set the renderer's delegate
        recorder?.renderAR = self
        
        // Configure the renderer to perform additional image & video processing 👁
        recorder?.onlyRenderWhileRecording = false
        
        // Configure ARKit content mode. Default is .auto
        recorder?.contentMode = .aspectFit
        
        //record or photo add environment light rendering, Default is false
        recorder?.enableAdjustEnvironmentLighting = true
        
        // Set the UIViewController orientations
        recorder?.inputViewOrientations = [.landscapeLeft, .landscapeRight, .portrait]
        // Configure RecordAR to store media files in local app directory
        recorder?.deleteCacheWhenExported = false
        
        if sceneName == nil {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                
                self!.instructionLabel.text = "Please Choose Your Style"
                self?.instructionLabel.alpha = 1
                self!.index += 1
                if self!.index > 10 { timer.invalidate() }
                UIView.animate(withDuration: 1) {
                    self?.instructionLabel.alpha = 0
                }
            }
        } else {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                
                self!.instructionLabel.text = "Please Scan Your Shirt Logo"
                self?.instructionLabel.alpha = 1
                self!.index += 1
                if self!.index > 10 { timer.invalidate() }
                UIView.animate(withDuration: 1) {
                    self?.instructionLabel.alpha = 0
                }
            }
        }
        
        //MARK:- Video or 3D model
        
        if sceneName == "D1.mp4" || sceneName == "D2.m4v" || sceneName == "D3.m4v" {
            isVideo = true
        } else {
            isVideo = false
        }
        
        interstitialAd = createAndLoadInterstitial()

    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
      let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3547836528823419/2065580896")
      interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Logo", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 3
            print("Image added")
        }
        
        recorder?.prepare(configuration)
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        videoNode.pause()
        
        if recorder?.status == .recording {
            recorder?.stopAndExport()
        }
        recorder?.onlyRenderWhileRecording = true
        recorder?.prepare(ARWorldTrackingConfiguration())
        
        recorder?.rest()
        
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:- AR Methods
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
//MARK:- Video
            
            let skScene = SKScene(size: CGSize(width: 640, height: 280))
            
            videoNode = SKVideoNode(fileNamed: sceneName ?? "")
            videoNode.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height / 2)
            videoNode.zRotation = CGFloat(-Double.pi)
            videoNode.play()
            
            skScene.addChild(videoNode)
            
//MARK:- Video end
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            let planeNode = SCNNode(geometry: plane)
            
            if isVideo == true {
                plane.firstMaterial?.diffuse.contents = skScene
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            } else {
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0)
                if  imageAnchor.referenceImage.name == "Glimpse2" || imageAnchor.referenceImage.name == "Glimpse" {
                    if let Scene = SCNScene(named: sceneName ?? ""){
                            if let ObjectNode = Scene.rootNode.childNodes.first {

                                ObjectNode.position = SCNVector3(planeNode.position.x  , planeNode.position.y , planeNode.position.z)
                                
                                if sceneName == "art.scnassets/Mask/weldingMask.scn" || sceneName == "art.scnassets/Animal/dog2.scn" || sceneName == "art.scnassets/Animal/cat2.scn" || sceneName == "art.scnassets/Animal/crocodile.scn" {
                                    ObjectNode.eulerAngles.y = .pi / 2
                                }
                                else if sceneName == "art.scnassets/Sample/phoenixBird.scn"{
                                    ObjectNode.eulerAngles.y = -.pi / 2
                                }
                                

                                planeNode.addChildNode(ObjectNode)
                            }
                        
                        }
                    
                } else if imageAnchor.referenceImage.name == "sample" {
                    if let Scene = SCNScene(named: sceneName ?? "") {
                        if sceneName == "art.scnassets/Sample/phoenixBird.scn" {
                            if let ObjectNode = Scene.rootNode.childNodes.first {
                                ObjectNode.position = SCNVector3(planeNode.position.x  , planeNode.position.y , planeNode.position.z)
                                print(planeNode.position.x)
                                
                                if sceneName == "art.scnassets/Sample/phoenixBird.scn" {
                                    ObjectNode.eulerAngles.y = -.pi / 2
                                }
                                
                                planeNode.addChildNode(ObjectNode)
                            }
                        } else if sceneName == "art.scnassets/Animal/dog1.scn"{
                            if let ObjectNode = Scene.rootNode.childNodes.first {
                                ObjectNode.position = SCNVector3(planeNode.position.x  , planeNode.position.y , planeNode.position.z)
                                print(planeNode.position.x)
                                
                                planeNode.addChildNode(ObjectNode)
                            }
                        } else if sceneName == "art.scnassets/Mask/venetianMask.scn" {
                            if let ObjectNode = Scene.rootNode.childNodes.first {
                                ObjectNode.position = SCNVector3(planeNode.position.x  , planeNode.position.y , planeNode.position.z)
                                print(planeNode.position.x)
                                
                                planeNode.addChildNode(ObjectNode)
                            }
                        } else if sceneName == "art.scnassets/Mask/makomosMask.scn" {
                            if let ObjectNode = Scene.rootNode.childNodes.first {
                                ObjectNode.position = SCNVector3(planeNode.position.x  , planeNode.position.y , planeNode.position.z)
                                print(planeNode.position.x)
                                
                                planeNode.addChildNode(ObjectNode)
                            }
                        }
                       
                    }
                    
                }
            }
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            
        }
        
        return node
        
    }

    // MARK: - Hide Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Exported UIAlert present method
    func exportMessage(success: Bool, status:PHAuthorizationStatus) {
        if success {
            let alert = UIAlertController(title: "Exported", message: "Media exported to camera roll successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Take Again", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if status == .denied || status == .restricted || status == .notDetermined {
            let errorView = UIAlertController(title: "Exporting Failed", message: "Please allow access to the photo library in order to save this media file.", preferredStyle: .alert)
            let settingsBtn = UIAlertAction(title: "Open Settings", style: .cancel) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(URL(string:UIApplication.openSettingsURLString)!)
                    }
                }
            }
            errorView.addAction(UIAlertAction(title: "Later", style: UIAlertAction.Style.default, handler: {
                (UIAlertAction)in
            }))
            errorView.addAction(settingsBtn)
            self.present(errorView, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Exporting Failed", message: "There was an error while exporting your media file.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- Segmented Control
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            shootingButton.setImage(UIImage(named: "Photo"), for: .normal)
        }
        else if sender.selectedSegmentIndex == 1 {
            shootingButton.setImage(UIImage(named: "Video"), for: .normal)
        }
    }
    
    //MARK:- Flashlight
    
    @IBAction func flash(_ sender: UIButton) {
        if flashButton.currentImage == UIImage(named:"flashlight") {
            flashButton.setImage(UIImage(named: "FlashDisable"), for: .normal)
            toggleOff()
        } else {
            flashButton.setImage(UIImage(named: "flashlight"), for: .normal)
            toggleOn()
        }
    }
    
    
    func toggleOn() {
        
        if let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch {
            
            do{
                try device.lockForConfiguration()
                device.torchMode = .on
                device.unlockForConfiguration()
            }
            catch {
                print("Error")
            }
        }
    }
    
    func toggleOff() {
        
        if let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch {
            
            do{
                try device.lockForConfiguration()
                device.torchMode = .off
                device.unlockForConfiguration()
            }
            catch {
                print("Error")
            }
        }
    }
    
    //MARK:- Shooting Button
    
    
    @IBAction func shootingClickButton(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "Photo") {
            print("Shoot Photo")
            
            sound = "shutter"
            
            if recorder?.status == .readyToRecord {
                let image = self.recorder?.photo()
                self.recorder?.export(UIImage: image) { saved, status in
                    DispatchQueue.main.async {
                        // Inform user photo has exported successfully
                            self.exportMessage(success: saved, status: status)
                    }
                }
            }
            
            //Reduces the sender's (the button that got pressed) opacity to half.
            sender.alpha = 0.5
            //Code should execute after 0.2 second delay.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                //Bring's sender's opacity back up to fully opaque.
                sender.alpha = 1.0
               
            }
            
            let x = Int.random(in: 0..<10)
            if x % 2 == 0 {
                
                if self.interstitialAd?.isReady == true {
                    self.interstitialAd?.present(fromRootViewController: self)
                } else {
                    print("Ad wasn't ready")
                }
            }
            
        } else if sender.currentImage == UIImage(named: "Video") {
            
            sound = "record"
            
            shootingButton.setImage(UIImage(named: "Stoprecord"), for: .normal)
            print("Start Recording")
            if recorder?.status == .readyToRecord {
                recordingQueue.async {
                    self.recorder?.record()
                }
            }
            
            
        } else if sender.currentImage == UIImage(named: "Stoprecord") {
            
            sound = "stoprecord"
            
            shootingButton.setImage(UIImage(named: "Video"), for: .normal)
            print("Stop Recording")
            recorder?.stop() { path in
                self.recorder?.export(video: path) { saved, status in
                    DispatchQueue.main.sync {
                        self.exportMessage(success: saved, status: status)
                    }
                }
            }
        }
        
        playSound(soundName: sound)
        
        
    }
    //MARK:- Shooting shutter sound
    
    func playSound(soundName: String) {
        print(soundName)
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    

}

//MARK: - ARVideoKit Delegate Methods
extension ViewController {
    
    func recorder(didEndRecording path: URL, with noError: Bool) {
        
    }
    
    func recorder(didFailRecording error: Error?, and status: String) {
        
    }
    
    func frame(didRender buffer: CVPixelBuffer, with time: CMTime, using rawBuffer: CVPixelBuffer) {
        
    }
    
    func recorder(willEnterBackground status: RecordARStatus) {
        // Use this method to pause or stop video recording. Check [applicationWillResignActive(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) for more information.
        if status == .recording {
            recorder?.stopAndExport()
        }
    }
}

//MARK:- GADInterstitialDelegate

extension ViewController : GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitialAd = createAndLoadInterstitial()
    }
}



