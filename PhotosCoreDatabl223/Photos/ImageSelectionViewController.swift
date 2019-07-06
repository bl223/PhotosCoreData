//
//  ImageSelectionViewController.swift
//  Photos
//
//  Created by BryceLigaya on 7/5/19.
//  Copyright © 2019 Bl223LabCPU. All rights reserved.
//

import UIKit
import CoreData

class ImageSelectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectedImageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerController.delegate = self
    }
    
    @IBAction func cameraSelected(_ sender: UIBarButtonItem) {
        takePhotoWithCamera()
        
    }
    
    @IBAction func photoLibrarySelected(_ sender: Any) {
        selectPhotoFromLibrary()
    }
    
    func takePhotoWithCamera() {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            presentAlert(title: "No Camera", message: "This device has no camera.")
        } else {
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
            
        }
    }
    
    func selectPhotoFromLibrary() {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Saving image to core data
    let imageData = image.jpegData(compressionQuality: 1.0)
    let object = MyEntity(context: managedContext)
    object.image = imageData
    
    do {
    try managedContext.save()
    }
    catch let error as NSError {
    print("\(error), \(error.userInfo)")
    }
    (void)imageChanged:(UIImage*)image{
    
    if (self.detailItem) {
    [self.detailItem setValue:UIImagePNGRepresentation(image) forKey:kSignatureImage];
    }
    }
}

