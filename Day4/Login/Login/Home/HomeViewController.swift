//
//  HomeViewController.swift
//  Login
//
//  Created by Bayu Yasaputro on 06/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    
    var data: [String] = [
        "Satu", "Dua", "Tiga", "Empat", "Lima", "Enam", "Tujuh", "Delapan", "Sembilan", "Nol"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let control = UIRefreshControl()
        tableView.addSubview(control)
        control.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.refreshControl = control
    }
    
    
    func delete(at indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: "Delete", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Delete Cell", style: .destructive, handler: { action in
            self.data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }))
        actionSheet.addAction(UIAlertAction(title: "Reload Data", style: .destructive, handler: { action in
            self.data.remove(at: indexPath.row)
            self.tableView.reloadData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func refresh(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.data = [
                "Satu", "Dua", "Tiga", "Empat", "Lima", "Enam", "Tujuh", "Delapan", "Sembilan", "Nol"
            ]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.navigateToLogin()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic_cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = "Row Selected"
        let message = "Row \(indexPath.row + 1): \(data[indexPath.row])"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            delete(at: indexPath)
            
        default:
            break
        }
    }
}


// MARK: - Extensions
extension UIViewController {
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "rootHome")
        
        let window = UIApplication.shared.windows.first
        window?.rootViewController = viewController
    }
}
