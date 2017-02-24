//
//  CustomMealHeaderCell.swift
//  MacroManager
//
//  Created by Alex Schultz on 2/23/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

protocol CustomMealHeaderCellDelegate {
    func addFavorite(sender: CustomMealHeaderCell)
    func removeFavorite(sender: CustomMealHeaderCell)
}

class CustomMealHeaderCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: CustomMealHeaderCellDelegate?
    var isFavorite: Bool!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatsTextField: UITextField!
    @IBOutlet weak var carbsTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.0)
        nameTextField.delegate = self
        proteinTextField.delegate = self
        fatsTextField.delegate = self
        carbsTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func favoriteButtonClick(_ sender: Any) {
        if !isFavorite{
            self.delegate?.addFavorite(sender: self)
            self.favoriteBtn.setImage(UIImage(named: "favoriteFilled"), for: .normal)
            isFavorite = true
            
        }else{
            self.delegate?.removeFavorite(sender: self)
            self.favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
            isFavorite = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag = textField.tag + 1;
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil && textField.text != ""){
            
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            //CLEAR KEYBOARD AND TRY LOGIN - AJE
            textField.resignFirstResponder()
            print("done with process")        }
        return false
    }

   
    
}
