//
//  ViewController.swift
//  AppCarros
//
//  Created by Igor Fernandes on 17/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.text = "user"
        passwordTextField.text = "123"
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        if Keychain.standard.read(service: "token", account: "app") != nil {
            self.goToHome()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        loginButton.configuration?.showsActivityIndicator = true
        loginButton.configuration?.activityIndicatorColorTransformer = .preferredTint
        loginButton.setTitle("", for: .normal)
        loginButton.isEnabled = false

        if !email.isEmpty && !password.isEmpty {
            Service.login(username: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    self?.goToHome()
                    self?.loginButton.configuration?.showsActivityIndicator = false
                    self?.loginButton.setTitle("Login", for: .normal)
                    self?.loginButton.isEnabled = true
                case .failure(let failure):
                    print(failure)
                    self?.showAlert(title: "Attention!", message: "Wrong credentials!")
                }
            }
        } else {
            self.showAlert(title: "Attention!", message: "You need to fulfill all fields!")
        }
    }
    
    func goToHome() {
        let home = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "home") as! HomeViewController
        let vc = UINavigationController(rootViewController: home)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
    }
}

