//
//  SkinCancerVC.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import CoreML
import Vision
class SkinCancerVC : UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.allowsEditing = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image.image = userImage
            guard let clImage = CIImage(image: userImage) else {
                fatalError("Image not converted")
            }
            detect(image: clImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        if context != nil {
            return context.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
    
    func detect(image:CIImage){
        guard let model = try? VNCoreMLModel(for: SkinCancer().model) else {
            fatalError("Model Failed")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            let classification = request.results?.first as? VNClassificationObservation
            self.navigationItem.title = classification?.identifier.capitalized
            print(classification)
        }
        if let sendImage = convertCIImageToCGImage(inputImage: image){
        let handler = VNImageRequestHandler(cgImage: sendImage)
        do{
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
}
