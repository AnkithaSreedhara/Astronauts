//
//  AstronautTableViewCell.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import UIKit

class AstronautTableViewCell: UITableViewCell {

    @IBOutlet weak var noResponseLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.layer.cornerRadius = 25
            profileImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {

        profileImageView.image = UIImage(systemName: "nosign")

        super.prepareForReuse()
    }
}
