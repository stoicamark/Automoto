//
//  LoginViewController.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 10. 22..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {

    @IBOutlet weak var couponsButton: UIButton!
    
    @IBOutlet weak var capsulesButton: UIButton!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cornerRadius : CGFloat = 12.0

        couponsButton.layer.cornerRadius = cornerRadius
        capsulesButton.layer.cornerRadius = cornerRadius
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.delegate = self
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = cornerRadius
        
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let capsuleTopConstraint = capsulesButton.topAnchor.constraint(equalTo: couponsButton.bottomAnchor, constant: 20.0)
        
        capsuleTopConstraint.isActive = true
        
        let topConstraint = loginButton.topAnchor.constraint(equalTo: capsulesButton.bottomAnchor, constant: 20.0)
        topConstraint.isActive = true
        
        let widthConstraint = loginButton.widthAnchor.constraint(equalToConstant: 200.0)
        widthConstraint.isActive = true
        
        let centerConstraint = loginButton.centerXAnchor.constraint(equalTo:
            view.centerXAnchor)
        centerConstraint.isActive = true
    }
}

extension LoginViewController : LoginButtonDelegate{
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result{
        case .cancelled :
            print("FB login cancelled!")
            break
        case .failed(let error):
            print(error)
            break
        case .success(_, _, _):
            let graphRequest : GraphRequest = GraphRequest(graphPath: "me",
                                                           parameters: ["fields" : "name, email, picture.type(large)"])
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        let picture = responseDictionary["picture"] as! [String : Any]
                        let data = picture["data"] as! [String : Any]
                        let url = data["url"] as! String
                        self.user = User(id: responseDictionary["id"] as! String,
                                    name: responseDictionary["name"] as! String,
                                    email: responseDictionary["email"] as! String,
                                    pictureUrl: url)
                        
                        self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    }
                }
            }
            
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        user = nil
        print("FB user logged out!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? CouponsViewController else{
            return
        }
        destinationVC.user = user
    }
}
