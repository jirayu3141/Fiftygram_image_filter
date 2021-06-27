//
//  ViewController.swift
//  Fiftygram
//
//  Created by Jirayu Sirivorawong on 2/6/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CIContext()       // context for filter
    @IBOutlet var sepiaFilter: UIButton!
    @IBOutlet var imageView: UIImageView!
    var original: UIImage?
    
    
    // action that happens after clicking "Sepia button"
    @IBAction func applySepia() {
        print("applying Sepia")
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")  // creating filter instance
        filter?.setValue(0.5, forKey: kCIInputIntensityKey) // setting intensity
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)    // setting the image to filter
        let output = filter?.outputImage
        //convert output to the correct type and setting the image
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    @IBAction func applyNoir() {
        print("applying Noir")
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectNoir")  // creating filter instance
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)    // setting the image to filter
        let output = filter?.outputImage
        //convert output to the correct type and setting the image
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    
    @IBAction func choosePhoto() {
        print("test")
        // check if picker of photo library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()  // create picker
            picker.delegate = self                  // delegate picker so we have the info later
            picker.sourceType = .photoLibrary       // selct source as photo library
            navigationController?.present(picker, animated: true, completion: nil)   // display photo library
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //dismiss
        dismiss(animated: true, completion: nil)
        // map user selection to imageView
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
        
    }
    
}

