//
//  AchievementProgressCell.swift
//  MacroManager
//
//  Created by Aaron Edwards on 2/21/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class AchievementProgressCell: UITableViewCell {

    @IBOutlet weak var pointValueLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var completionRatioLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        progressView.layer.cornerRadius = 3
        progressView.clipsToBounds = true
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
