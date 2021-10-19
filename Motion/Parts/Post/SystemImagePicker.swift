//
//  ChatImagePicker.swift
//  RoadsidePicnic
//
//  Created by cwcw on 2021/6/3.
//

import SwiftUI
import PhotosUI

struct SystemImagePicker: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) var persentationMode
    
    var selectionLimit: Int
    @Binding var show : Bool
    @Binding var isloading : Bool
    var action :  (_ uiimages : [UIImage])-> Void
   
    
    func makeUIViewController(context: Context) -> some PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: SystemImagePicker
        
        init(parent: SystemImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if results.isEmpty {
                self.parent.show.toggle()
            }else{
                self.parent.isloading.toggle()
                imageLogic(results: results) { uiimages in
                    self.parent.isloading.toggle()
                    self.parent.show.toggle()
                    self.parent.action(uiimages)
                }
            }
        }
        
        func imageLogic(results : [PHPickerResult],completion : @escaping  ([UIImage])->() ){
                //异步函数
            DispatchQueue.global().async {
                var uiimages : [UIImage] = []
                for result in results {
                    if result.itemProvider.canLoadObject(ofClass: UIImage.self){
                        result.itemProvider.loadObject(ofClass: UIImage.self) { result, error in
                            guard let image = result else {return}
                                let uiimage = image as! UIImage
                            uiimages.append(uiimage)
                            print("添加了一张照片到数组🪐")
                            
                            if uiimages.count == results.count{
                                DispatchQueue.main.async {
                                    completion(uiimages)
                                }
                            }
                        }
                    }else{
                        
                    }
                }
                
                    
                
            }
        }
    }
}
