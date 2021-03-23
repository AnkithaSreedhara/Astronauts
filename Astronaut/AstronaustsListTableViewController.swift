//
//  AstronaustsListTableViewController.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import UIKit

class AstronaustsListTableViewController: UITableViewController {
    
    @IBOutlet weak var sortButton: UIButton!
    
    private var astronautViewModel : AstronautViewModel!
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(onView: self.view)
        callToViewModelForUIUpdate()
    }
    func callToViewModelForUIUpdate(){
        self.astronautViewModel = AstronautViewModel()
        self.astronautViewModel.bindViewModelToController = { [weak self] in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.removeSpinner()
            }
            
        }
    }
    
    // MARK: - Actions
    @IBAction func clickSortByName(_ sender: Any) {
        if self.sortButton.image(for: .normal) == UIImage(systemName: "chevron.down") {
            sortButton.setImage( UIImage(systemName: "chevron.up"), for: .normal)
            self.astronautViewModel.sortByNameWithOrder(ascending: true)
        }else{
            sortButton.setImage( UIImage(systemName: "chevron.down"), for: .normal)
            self.astronautViewModel.sortByNameWithOrder(ascending: false)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = astronautViewModel.astronauts?.count else{ return 1 }
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AstronautTableViewCell", for: indexPath) as! AstronautTableViewCell
        guard let results = astronautViewModel.astronauts else{
            //Showing an label to notify the user when there are no astronauts fetched. 
            cell.noResponseLabel.isHidden = false
            return cell
        }
        if indexPath.row == results.count - 1 { // last cell
            if astronautViewModel.totalItems > results.count { // more items to fetch
                if let nextURL = astronautViewModel.nextURL {
                    astronautViewModel.callFuncToGetAstronauts(path: nextURL)
                }
            }
        }else{
            cell.nameLabel.text = results[indexPath.row].name
            cell.nationalityLabel.text = results[indexPath.row].nationality
            if let cachedImage = imageCache.object(forKey: "\(results[indexPath.row].id!)" as  NSString) {
                cell.profileImageView.image = cachedImage
            }
            else
            {
                if (results[indexPath.row].profile_image_thumbnail != nil)
                {
                    DispatchQueue.global(qos: .background).async {
                        let url = URL(string: results[indexPath.row].profile_image_thumbnail!)
                        let data = try? Data(contentsOf: url!)
                        let image: UIImage = UIImage(data: data!)!
                        DispatchQueue.main.async {
                            self.imageCache.setObject(image, forKey: "\(results[indexPath.row].id!)" as  NSString)
                            cell.profileImageView.image = image
                            cell.setNeedsLayout()
                        }
                    }
                }
            }
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToDetail", let destination = segue.destination as? AstronautDetailViewController{
            if let cell = sender as? AstronautTableViewCell, let indexPath = tableView.indexPath(for: cell) {
                destination.astrounatId = astronautViewModel.astronauts?[indexPath.row].id // Sending the ID to destination view controller.
            }
        }
    }
}
