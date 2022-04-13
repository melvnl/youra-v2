//
//  historyTableViewCell.swift
//  Youra
//
//  Created by Hansel Matthew on 13/04/22.
//

import UIKit

class historyTableViewCell: UITableViewCell {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
//        self.backgroundColor = .clear
        
        let cellBg = UIImage(named: "reminderBackground.png")
        self.backgroundView = UIImageView(image: cellBg)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
