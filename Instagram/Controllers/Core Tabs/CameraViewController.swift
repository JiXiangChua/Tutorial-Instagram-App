//
//  CameraViewController.swift
//  Instagram
//
//  Created by JI XIANG on 8/8/21.
//

import AVFoundation //we want to build our own camera instead of using imagepicker to access the camera
import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false) //dont want to show the nav bar
        
    }
    
    private func didTapTakePicture() {
        
    }
    


}
