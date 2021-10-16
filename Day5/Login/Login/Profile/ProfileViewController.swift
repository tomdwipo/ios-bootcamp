//
//  ProfileViewController.swift
//  Login
//
//  Created by Bayu Yasaputro on 09/10/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let data: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

}

// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count //min(4, data.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as! ProfileViewCell
        
        // Configure cell data
        let item = data[indexPath.item] //data[(data.count - 4) + (indexPath.item)]
        cell.label.text = "\(item)"
        cell.label.backgroundColor = UIColor.lightGray
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = "Item Selected"
        let message = "Item \(indexPath.item + 1)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item == 0 {
//            return CGSize(width: 300, height: 300)
//        }
//        else {
//            return CGSize(width: 120, height: 120)
//        }
        
        let width = UIScreen.main.bounds.width
        let space: CGFloat = 16 * 4
        let cellWidth = floor((width - space) / 3)
        return CGSize(width: cellWidth, height: indexPath.item % 2 == 0 ? cellWidth : cellWidth * 3/2)
    }
}
