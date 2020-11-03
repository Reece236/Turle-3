//
//  LogInViewController.swift
//  Turtle 3
//
//  Created by Reece Calvin on 5/30/20.
//  Copyright © 2020 Arcie. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
	
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var logInButton: UIButton!
	
	@IBOutlet weak var errorLabel: UILabel!
	
	@IBOutlet weak var backButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
			setUpElements()
		}
		
		func setUpElements(){
			
			//hide error label
			errorLabel.alpha = 0
			
			//style elements
			Utilities.styleTextField(emailTextField)
			Utilities.styleTextField(passwordTextField)
			Utilities.styleFilledButtonBlue(logInButton)
		}
	
	// hide keyboard after click outside
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
		self.view.endEditing(true)
	}


		
		@IBAction func logInTapped(_ sender: Any) {
		
			//Hide keyboard
			self.view.endEditing(true)
					
					// Create cleaned versions of the text field
			let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
					let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			
					// Validate Text Fields
			func validateFields() -> String? {
			if email == "" || password == "" {
				return "Please fill in all fields."
			}
				return nil
			}

					
			
					// Signing in the user
					Auth.auth().signIn(withEmail: email, password: password) { (result, error) in

						if error != nil {
							// Couldn't sign in
							self.errorLabel.text = error!.localizedDescription
							self.errorLabel.alpha = 1
						}
						else {
							
							self.transitionToHome()
							
						}
					}
				}
	
	func transitionToHome() {
		let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
		
		//set email to gloabal variable
		homeViewController?.email = self.emailTextField.text!.lowercased()
		
		//TEMP: first name global variable
		
		view.window?.rootViewController = homeViewController
		view.window?.makeKeyAndVisible()
	}
				
			}
