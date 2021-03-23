//
//  ActivityIndicators.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import Foundation
import UIKit
var vSpinner : UIView?

extension UIViewController {
    //NOTE : - Call self.showSpinner(onView: self.view) to show in View controller
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style:  UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    //NOTE : - Call self.removeSpinner() to hide in View controller
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
