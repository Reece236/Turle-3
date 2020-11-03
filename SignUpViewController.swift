//
//  SignUpViewController.swift
//  Turtle 3
//
//  Created by Reece Calvin on 5/30/20.
//  Copyright © 2020 Arcie. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class SignUpViewController: UIViewController {
	
	@IBOutlet weak var firstNameTextField: UITextField!
	
	@IBOutlet weak var lastNameTextField: UITextField!
		
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var signUpButton: UIButton!
	
	@IBOutlet weak var errorLabel: UILabel!
	
	@IBOutlet weak var backButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpElements()
    }
	


	
	func setUpElements() {
		
		errorLabel.alpha = 0
		
		Utilities.styleTextField(firstNameTextField)
		Utilities.styleTextField(lastNameTextField)
		Utilities.styleTextField(emailTextField)
		Utilities.styleTextField(passwordTextField)
		Utilities.styleFilledButtonBlue(signUpButton)		 
	}
	//check the fields
	func validateFields() -> String? {
		
		//validate everything is filled in
		if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
				return "Please fill in all fields."
			}

		//check if the email is valid
		let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if Utilities.isEmailValid(cleanedEmail) == false {
			return "Please enter a valid email."
		}
		
		
		return nil
	}
		
	// hide keyboard after click outside
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
		self.view.endEditing(true)
	}

  
	
	@IBAction func signUpTapped(_ sender: Any) {
		
		//hide keyboard
		self.view.endEditing(true)
		
		//validate the fields
		let error = validateFields()
		
		if error != nil {
			
			//there's something wrong
			showError(error!)
			
		}else{
			//create clean versions of data
			 let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			
			
			//create the user
			Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
				//check for errors
				if err != nil {
					//we gt an issue bois
					self.showError("Please enter a password over 8 characters and a unique email")
				}else{
					//we did a bang up job. Now lets store the first and last name
					let db = Firestore.firestore()
					/** Add questions to database
					db.collection("data").document("question").setData(["0": "What were your maternal grandparents' names" ,"1":"What did you call your maternal grandparents","2":"Where did your maternal grandparents meet","3":"How old were you maternal grandparents when they married","4":"What did your maternal grandparents do for a living","5":"What were your paternal grandparents' names","6":"What did you call your paternal grandparents","7":"Where did your paternal grandparents meet","8":"How old were you paternal grandparents when they married","9":"What did your paternal grandparents do for a living","10":"What was your moms name","11":"When was your mom born","12":"Where was your mom born","13":"Where did your mom grow up","14":"Did your mom have any siblings","15":"What were your mom’s siblings names","16":"What were your mom's siblings ages","17":"What was your dads name","18":"When was your dad born","19":"Where was your dad born","20":"Where did your dad grow up","21":"Did your dad have any siblings","22":"What were your dad’s siblings names","23":"What were your dad’s siblings ages","24":"How did your parents meet","25":"When did your parents meet","26":"How old were your parents when they married","27":"What did you parents do for a living","28":"How many cousins did you have","29":"What were your cousins' names","30":"Were your cousins older or younger than you","31":"When were you born","32":"Where were you born","33":"What schools did you go to","34":"What did you study","35":"What was your dream job","36":"Who was your best friend growing up","37":"What were you chores at home","38":"What did you love most about your father","39":"What did you love most about your mother","40":"What did your father teach you","41":"What did your mother teach you","42":"What were your parents strict about","43":"What did you often fight with your parents over","44":"What was your first job","45":"Did you have any pets","46":"What were your pets names","47":"Favorite type of music","48":"Favorite sport","49":"Biggest passion","50":"Favorite thing to do in free time","51":"When did you start dating","52":"When did you go to sleep","53":"Favorite song","54":"Favorite Movie","55":"Favorite vacation","56":"Favorite color","57":"Favorite food","58":"Favorite subject in school","59":"Favorite book","60":"Favorite tv show","61":"Where did you graduate","62":"When did you graduate","63":"What was your job","64":"What did you do on the weekends","65":"When did you meet your spouse","66":"Where did you meet your spouse","67":"What is your spouse’s full name","68":"When was your first date with your spouse","69":"Where was your spouse from","70":"What did your spouse do for a living","71":"What did you like most about your spouse","72":"How long were you dating your spouse before getting engaged","73":"When did you get engaged","74":"How was the proposal","75":"How did your parents react to the engagement","76":"When was the wedding","77":"Where was the wedding","78":"What did you wear at the wedding","79":"Most memorable wedding gift","80":"Best memory of wedding","81":"How did you celebrate the wedding","82":"Where did you go after the wedding","83":"Where did you live after getting married","84":"What was your first home like","85":"What did the both of you do for a living","86":"What did you do for vacation","87":"How many kids did you have","88":"When was each kid born","89":"Where did you live when each kid was born","90":"What were each of your kids like growing up","91":"What religion did you practice","92":"What Holidays did you celebrate","93":"What did you do during those holidays","94":"What is your favorite family recipe","95":"What are some other family traditions","96":"Who did you last vote for president","97":"Why did you vote for this person","98":"What political party are you most affiliated with","99":"What political issues are most important to you"]) { (error) in
					 
					 //Dont store password
					//db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in

						 if error != nil {
							 //show error message
							 self.showError("Error saving user data")
						 }
							 
					 }*/
					//Store password
					//db.collection("users").document(email).setData(["firstname":firstName, "lastname":lastName, "password":password, "question": 0 , "uid": result!.user.uid ]) { (error) in
					
					//Dont store password
					db.collection("users").document(email).setData(["firstname":firstName, "lastname":lastName, "question": 0, "question 0": "", "question 1": "", "question 2": "", "question 3": "", "question 4": "", "question 5": "", "question 6": "", "question 7": "", "question 8": "", "question 9": "", "question 10": "", "question 11": "", "question 12": "", "question 13": "", "question 14": "", "question 15": "", "question 16": "", "question 17": "", "question 18": "", "question 19": "", "question 20": "", "question 21": "", "question 22": "", "question 23": "", "question 24": "", "question 25": "", "question 26": "", "question 27": "", "question 28": "", "question 29": "", "question 30": "", "question 31": "", "question 32": "", "question 33": "", "question 34": "", "question 35": "", "question 36": "", "question 37": "", "question 38": "", "question 39": "", "question 40": "", "question 41": "", "question 42": "", "question 43": "", "question 44": "", "question 45": "", "question 46": "", "question 47": "", "question 48": "", "question 49": "", "question 50": "", "question 51": "", "question 52": "", "question 53": "", "question 54": "", "question 55": "", "question 56": "", "question 57": "", "question 58": "", "question 59": "", "question 60": "", "question 61": "", "question 62": "", "question 63": "", "question 64": "", "question 65": "", "question 66": "", "question 67": "", "question 68": "", "question 69": "", "question 70": "", "question 71": "", "question 72": "", "question 73": "", "question 74": "", "question 75": "", "question 76": "", "question 77": "", "question 78": "", "question 79": "", "question 80": "", "question 81": "", "question 82": "", "question 83": "", "question 84": "", "question 85": "", "question 86": "", "question 87": "", "question 88": "", "question 89": "", "question 90": "", "question 91": "", "question 92": "", "question 93": "", "question 94": "", "question 95": "", "question 96": "", "question 97": "", "question 98": "", "question 99": "", "question 100": "", "question 101": "", "question 102": "", "question 103": "", "question 104": "", "question 105": "", "question 106": "", "question 107": "", "question 108": "", "question 109": "", "question 110": "", "question 111": "", "question 112": "", "question 113": "", "question 114": "", "question 115": "", "question 116": "", "question 117": "", "question 118": "", "question 119": "", "question 120": "", "question 121": "", "question 122": "", "question 123": "", "question 124": "", "question 125": "", "question 126": "", "question 127": "", "question 128": "", "question 129": "", "question 130": "", "question 131": "", "question 132": "", "question 133": "", "question 134": "", "question 135": "", "question 136": "", "question 137": "", "question 138": "", "question 139": "", "question 140": "", "question 141": "", "question 142": "", "question 143": "", "question 144": "", "question 145": "", "question 146": "", "question 147": "", "question 148": "", "question 149": "", "question 150": "", "question 151": "", "question 152": "", "question 153": "", "question 154": "", "question 155": "", "question 156": "", "question 157": "", "question 158": "", "question 159": "", "question 160": "", "question 161": "", "question 162": "", "question 163": "", "question 164": "", "question 165": "", "question 166": "", "question 167": "", "question 168": "", "question 169": "", "question 170": "", "question 171": "", "question 172": "", "question 173": "", "question 174": "", "question 175": "", "question 176": "", "question 177": "", "question 178": "", "question 179": "",  "uid": result!.user.uid ]) { (error) in

						if error != nil {
							//show error message
							self.showError("Error saving user data")
						}
							
					}
					
					//set email to gloabal variable
						func prepare (for segue:UIStoryboardSegue, sender: Any?) {
						
							let HomeController = segue.destination as! HomeViewController
							HomeController.email = self.emailTextField.text!
					}

					//Transtion to the home screen
					self.transitionToHome()
					 
				}
			}
		

		}
	}
	func showError(_ message:String){
		errorLabel.text = message
		errorLabel.alpha = 1

	}
	func transitionToHome() {
		let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
		
		//set email to gloabal variable
		homeViewController?.email = self.emailTextField.text!
		
		//TEMP: first name global variable
		
		view.window?.rootViewController = homeViewController
		view.window?.makeKeyAndVisible()
	}

}
