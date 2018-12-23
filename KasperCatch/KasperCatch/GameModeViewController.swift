//
//  GameModeViewController.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/15/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class GameModeViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {

    @IBOutlet weak var characterSelection: UIImageView!
    
    let characters : [String] = ["westie.png", "dalmatian.png","pug.png","shiba.png","poodle.png"]
    var index = 0
    var dogIndex = 0
    let gameModel = itemsModel.sharedInstance
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpConnectivity()
        
        self.characterSelection.image = UIImage(named: characters[0])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rightButton(_ sender: Any) {
        self.index = (self.index >= self.characters.count-1) ? 0 : self.index+1
        self.characterSelection.image = UIImage(named:characters[index])
        dogIndex = index
    }
    
    @IBAction func leftButton(_ sender: UIButton) {
        self.index = (self.index == 0) ? self.characters.count - 1 : self.index-1
        self.characterSelection.image = UIImage(named:characters[index])
        dogIndex = index
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        
    }

    @IBAction func play2PButton(_ sender: UIButton) {
    }
    @IBAction func findPlayer(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Find Player", message: "Do you want to Host or Join a Session?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Host Session", style: .default, handler: { (action: UIAlertAction) in
            self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "player2", discoveryInfo: nil, session: self.mcSession)
            self.mcAdvertiserAssistant.start()
        }))
        actionSheet.addAction(UIAlertAction(title: "Join Session", style: .default, handler: { (action: UIAlertAction) in
            let mcBrowser = MCBrowserViewController(serviceType: "player2", session: self.mcSession)
            mcBrowser.delegate = self
            self.present(mcBrowser, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    
    }
    
    //MARK: Multipeer Connectivity functions
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        default:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            let myDictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSDictionary
            self.gameModel.setOpponentScore(myDictionary.value(forKey: "score") as! Int)
            let tryingScore = myDictionary.value(forKey: "score")
            print("Testing: \(String(describing: tryingScore))")
        }
    }
    
    func sendScore(score: Int){
        print("Sending Score")
        let myScore = gameModel.getPlayerScore()
//        let aData = NSKeyedArchiver.archivedData(withRootObject: myScore)
        if mcSession.connectedPeers.count > 0 {
            let myDictionary = ["score": "\(myScore)"]
            do {
                let data = NSKeyedArchiver.archivedData(withRootObject: myDictionary)
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch let error as NSError {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
    }
    
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion:  nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion:  nil)
        
    }
    func setUpConnectivity(){
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onePlayerScene"{
            let controller = segue.destination  as! OneGameViewController
            let selectedDogName = characters[dogIndex]
            controller.configure(with: selectedDogName)
        }
        if segue.identifier == "twoPlayerScene"{
            let controller = segue.destination  as! TwoGameViewController
            let selectedDogName = characters[dogIndex]
            controller.configure(with: selectedDogName)
        }
        
    }
    
}
