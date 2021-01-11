//
//  CountryCollectionViewCell.swift
//  Table-App-Demo
//
//  Created by Hassan Mostafa on 7/8/19.
//  Copyright © 2019 Minds. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    var deleteClosure: (()->())?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.clipsToBounds = true
    }
    @IBAction func deleteButtonPressed(_ sender: Any) {
        deleteClosure?()
    }
}
