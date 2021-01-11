//
//  ViewController.swift
//  Table-App-Demo
//
//  Created by Hassan Mostafa on 7/3/19.
//  Copyright © 2019 Minds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countriesTableView: UITableView!
    var isEditable = false
    
    var countries = ["Egypt", "KSA", "UAE", "USA"]
    let images: [UIImage] = [#imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl"), #imageLiteral(resourceName: "girl")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditable = !isEditable
        sender.title = isEditable == true ? "Done" : "Edit"
        countriesTableView.isEditing = isEditable ? true : false
    }
    
    
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        countries.remove(at: indexPath.row)
        countriesTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let selectedItem = countries[sourceIndexPath.row]
        countries.remove(at: sourceIndexPath.row)
        countries.insert(selectedItem, at: destinationIndexPath.row)
        countriesTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("the index is : \(indexPath.row)")
        if let popUpVC = storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController {
            popUpVC.name = countries[indexPath.row]
            //popUpVC.modalTransitionStyle = .crossDissolve
            present(popUpVC, animated: true, completion: nil)
        }
        
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell {
            cell.countryNameLabel.text = countries[indexPath.row]
            cell.countryImageView.image = images[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
