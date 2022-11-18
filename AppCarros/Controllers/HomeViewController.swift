//
//  HomeViewController.swift
//  AppCarros
//
//  Created by Igor Fernandes on 18/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    private var cars: [CarInfo] = [CarInfo]()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        fetchData()
        configTableView()
    }
    
    func setActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func fetchData() {
        activityIndicator.startAnimating()
        if let user = Keychain.standard.read(service: "token", account: "app", type: User.self) {
            Service.getCarsWith(authorization: user.token) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.cars = success
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.activityIndicator.stopAnimating()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarTableViewCell.nib(), forCellReuseIdentifier: CarTableViewCell.identifier)
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        let alertController = UIAlertController(title: "Attention", message: "Are you sure you want to leave the app?", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive) { action in
            // delete token
            Keychain.standard.delete(service: "token", account: "app")
            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
            home.modalPresentationStyle = .fullScreen
            self.present(home, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier, for: indexPath) as! CarTableViewCell
        DispatchQueue.main.async { [weak self] in
            if let self {
                cell.configure(with: self.cars[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cars = cars[indexPath.row]
        let home = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "details") { coder in
            return DetailsViewController(coder: coder, cars: cars)
        }
        navigationController?.pushViewController(home, animated: true)
    }
}
