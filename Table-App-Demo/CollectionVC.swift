//
//  CollectionVC.swift
//  Table-App-Demo
//
//  Created by Mohamed Samir on 1/10/21.
//  Copyright © 2021 Minds. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {

    @IBOutlet weak var countryCollectionView: UICollectionView!
    var iscolEditing: Bool = false
    var longPress: UILongPressGestureRecognizer!
    var countries = ["Egypt", "KSA", "UAE", "USA", "France", "Germany", "Algeria", "USA"]
    var images: [UIImage] = [#imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        countryCollectionView.addGestureRecognizer(longPress)
    }
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedItemIndexpath = countryCollectionView.indexPathForItem(at: gesture.location(in: countryCollectionView)) else { return }
            countryCollectionView.beginInteractiveMovementForItem(at: selectedItemIndexpath)
        case .changed:
            countryCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: countryCollectionView))
        case .ended:
            countryCollectionView.endInteractiveMovement()
        default:
            countryCollectionView.cancelInteractiveMovement()
        }
    }
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        iscolEditing = !iscolEditing
        sender.title = iscolEditing ? "Done" : "Edit"
    }
}
extension CollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let country = countries.remove(at: sourceIndexPath.item)
        countries.insert(country, at: destinationIndexPath.item)
    }
   
}
extension CollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as? CountryCollectionViewCell {
            cell.countryNameLabel.text = countries[indexPath.item]
            cell.countryImageView.image = images[indexPath.item]
            cell.deleteClosure = {
                self.countries.remove(at: indexPath.item)
                self.images.remove(at: indexPath.item)
                self.countryCollectionView.reloadData()
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
extension CollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (view.frame.width / 2) - 15, height: 200)
        return cellSize
        
    }
}
