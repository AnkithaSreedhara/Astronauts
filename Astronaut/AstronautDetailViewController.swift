//
//  AstronautDetailViewController.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import UIKit

class AstronautDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageview: UIImageView!{
        didSet{
            profileImageview.layer.cornerRadius = 25
            profileImageview.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    var astrounatId : Int?
    let imageCache = NSCache<NSString, UIImage>()
    private var astronautDetailViewModel : AstronautDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(onView: self.view)
        callToViewModelForUIUpdate()
    }
    func callToViewModelForUIUpdate(){
        guard let astronautID = self.astrounatId else { return }
        self.astronautDetailViewModel = AstronautDetailViewModel(path: Strings.baseURL + "\(astronautID)")
        self.astronautDetailViewModel.bindViewModelToController = { [weak self] in
            if let astronautDetail = self?.astronautDetailViewModel.astronaut{
                DispatchQueue.main.async {
                    self?.nameLabel.text = astronautDetail.name ?? "NOT AVAILABLE"
                    self?.nationalityLabel.text = astronautDetail.nationality ?? "NOT AVAILABLE"
                    self?.dobLabel.text = astronautDetail.date_of_birth ?? "NOT AVAILABLE"
                    self?.bioTextView.text = astronautDetail.bio ?? "NOT AVAILABLE"
                    self?.setImage(for: astronautID, with: astronautDetail.profile_image)
                }
            }else{
                self?.removeSpinner()
            }
        }
    }
    func setImage(for ID: Int, with urlPath: String?){
        if (urlPath != nil)
        {
            DispatchQueue.global(qos: .background).async { [weak self] in
                let url = URL(string: urlPath!)
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                DispatchQueue.main.async {
                    self?.profileImageview.image = image
                }
            }
        }else if let cachedImage = imageCache.object(forKey: "\(ID)" as  NSString) {
            //NOTE : If image is unavailable using the thumb nail image from cache. 
            DispatchQueue.main.async {
                self.profileImageview.image = cachedImage
            }
        }
        self.removeSpinner()
    }
}
