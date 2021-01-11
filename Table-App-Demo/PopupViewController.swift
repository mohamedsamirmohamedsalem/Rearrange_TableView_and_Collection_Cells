//
//  PopupViewController.swift
//  Table-App-Demo
//
//  Created by Mohamed Samir on 1/10/21.
//  Copyright © 2021 Minds. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var name: String?
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 20
        self.containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        
        nameLabel.text = name
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToClosePopup))
        
        view.addGestureRecognizer(tap)
    }
    @objc func tapToClosePopup() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }, completion : { (true) in
           self.dismiss(animated: true, completion: nil)
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAnimation()
        
    }
    func setAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
            self.containerView.transform = .identity
        }, completion: nil)
    }
    
}
