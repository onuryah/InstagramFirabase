//
//  UploadVC.swift
//  InstagramApp
//
//  Created by Ceren Çapar on 8.10.2021.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectImage.isUserInteractionEnabled = true
        let imageTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImaged))
        selectImage.addGestureRecognizer(imageTabRecognizer )
    }
    @objc func selectImaged() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func makeAllert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let uuid = UUID().uuidString
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = selectImage.image?.jpegData(compressionQuality: 0.5){
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAllert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
//DATABASE
                            
        let firestoreDataBase = Firestore.firestore()
        var firestoreReference : DocumentReference? = nil
        let firestorePosts = ["imageUrl" : imageUrl!, "PostedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentTextField.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
        firestoreReference = firestoreDataBase.collection("Posts").addDocument(data: firestorePosts, completion: { error in
        if error != nil {
            self.makeAllert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
        }else{
            self.selectImage.image = UIImage(named: "select")
            self.commentTextField.text = ""
            self.tabBarController?.selectedIndex = 0
        }
                            })
                            
                            
                            
                        }
                    }
                }
            }
            
        }
         
    }




}
