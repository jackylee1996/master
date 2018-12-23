//
//  imageViewController.swift
//  Campus Walk
//
//  Created by Jackeline Lee on 10/19/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit
import Photos

protocol ImageDelegate {
    func pinIt(indexPath: IndexPath)
}

class imageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UIScrollViewDelegate{

    
    
    @IBOutlet weak var pinIt: UIButton!
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var buildingTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var uploadPhoto: UIBarButtonItem!
    let imagePicker = UIImagePickerController()
    var newPic = UIImage()

    var image = String()
    var imageTitle = String()
    var imageYear = Int()
    var delegate: ImageDelegate?
    var indexNum = IndexPath()
    var isEdited = false
    
    @IBAction func upload(_ sender: UIBarButtonItem) {
        actionSheet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = imageTitle
        configure()
        imagePicker.delegate = self
        
        
    }
    
    func configure(){
        imageInfo.image = UIImage(named: image)
        if image.isEmpty {
            imageInfo.image = UIImage(named: "nophoto")
        }
        if isEdited == true {
            imageInfo.image = newPic
        }
        buildingTitle.text = imageTitle
        year.text = String(imageYear)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func actionSheet(){
        let actionSheet = UIAlertController(title: "Upload Image from...", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take a Photo", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            self.photo()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            self.upload()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func photo(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
    
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        }
        else {
            noCamera()
        }
        
    }
    
    func noCamera(){
        let alert = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera. Try uploading a picture from gallery.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style:.default, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
    func upload(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageInfo.contentMode = .scaleAspectFit
        imageInfo.image = chosenImage
        newPic = chosenImage
        imageInfo.setNeedsDisplay()
        isEdited = true
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
