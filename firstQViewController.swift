//
//  firstQViewController.swift
//  Turtle 3
//
//  Created by Reece Calvin on 8/22/20.
//  Copyright © 2020 Arcie. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
//import GoogleMobileAds

class firstQViewController: UIViewController {
	
//	@IBOutlet weak var bannerView: GADBannerView!
	var email = String()
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var answerText: UITextField!
	@IBOutlet weak var currentAnswerLabel: UILabel!
	@IBOutlet weak var currentLabel: UILabel!
	
	
	var counter = Int()
	var counterAndOne = Int()
	var answer = String()
	@IBOutlet weak var submit: UIButton!
	@IBOutlet weak var confirm: UIButton!
	var question = String()
	var max = Int()
	
	
	//Read database
	var ref: DatabaseReference!
		
	//ref = Database.database().reference()
	
	let db = Firestore.firestore()
	
	//let storage = Storage.storage()


    override func viewDidLoad() {
		
		
		let docRef = db.collection("data").document("question")
		
		func updateQuestion() {
		docRef.getDocument { (document, error) in
			if let document = document, document.exists {
			let myDocument = document.data()
				self.question = myDocument?["\(self.counter)"] as! String
				print (self.counter)
				print (self.question)
				print ("\(self.question)?")
				self.questionLabel.text = "\(self.question)?"

				
			} else {
				
				self.counter = 0
				
				updateQuestion()
			}
			
			let docRef = self.db.collection("users").document(self.email)

			docRef.getDocument { (document, error) in
				if let document = document, document.exists {
				let myDocument = document.data()
					print(self.counter)
					self.counterAndOne = self.counter + 1
					let currentAnswer = myDocument?["question \(self.counter)"] as! String
					print (self.counter)
					self.currentLabel.text = currentAnswer
					
					if currentAnswer == "" {
						
						self.currentAnswerLabel.isHidden = true
						self.currentLabel.isHidden = true
						
					} else {
						
						self.currentAnswerLabel.isHidden = false
						self.currentLabel.isHidden = false
						
					}
					
				}
				
				
			}

			
			
		}
			
		}
		
		updateQuestion()
		
		let docRefUser = db.collection("users").document(email)

		docRefUser.getDocument { (document, error) in
			if let document = document, document.exists {
			let myDocument = document.data()
				self.counter = myDocument?["question"] as! Int
				print (self.counter)
				
			}
			
			
		}
		
		submit.isHidden = false
		confirm.isHidden = true

		
		//Set Up Ad
		//test ad
		//bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"

		
		//real ad
		//bannerView.adUnitID = "ca-app-pub-5799206644054988/6777005307"
		//bannerView.rootViewController = self
		//bannerView.load(GADRequest())

        super.viewDidLoad()
		


        // Do any additional setup after loading the view.
		print ("COUNT IS \(counter)")
		print ("EMAIL is \(email)")
		print ("\(email) AHHHHHHHH")


		
	}
	
	@IBAction func submit(_ sender: Any) {
		
		submit.isHidden = true
		confirm.isHidden = false
		
	}
	
	@IBAction func confirm(_ sender: Any) {
		
		if answerText.text == "" {
			
			answerText.placeholder = "TYPE ANSWER HERE!!"
			
		} else {
			
			answer = answerText.text!
			
			print (answer)
			
			print(email)
			
			let db = Firestore.firestore()
		
			db.collection("users").document(email).setData(["question \(counter)":answer], merge: true)
					
			let docRefUser = db.collection("data").document("question")

			docRefUser.getDocument { (document, error) in
				if let document = document, document.exists {
				let myDocument = document.data()
					self.max = myDocument?["totalQuestions"] as! Int
					if self.counter == self.max {
						
						self.counter = 0

						
					} else {
						
						self.counter += 1

						
					}
					print (self.counter)
					
				}
				
				
			}
		
			db.collection("users").document(email).setData(["question":counter], merge: true)
				
			answerText.text = ""
			
			
			db.collection("data").document("question").getDocument { (document, error) in
				if let document = document, document.exists {
				let myDocument = document.data()
					self.question = myDocument?["\(self.counter)"] as! String
					print (self.counter)
					print (self.question)
					print ("\(self.question)?")
					self.questionLabel.text = "\(self.question)?"

					
				}
				
				
			}
			
			let docRef = self.db.collection("users").document(self.email)
			docRef.getDocument { (document, error) in
				if let document = document, document.exists {
				let myDocument = document.data()
					self.counterAndOne = self.counter + 1
					let currentAnswer = myDocument?["question \(self.counterAndOne)"] as! String
					print (self.counter)
					self.currentLabel.text = currentAnswer
					
					if currentAnswer == "" {
						
						self.currentAnswerLabel.isHidden = true
						self.currentLabel.isHidden = true
						
					} else {
						
						self.currentAnswerLabel.isHidden = false
						self.currentLabel.isHidden = false
						
					}
					
				}
				
				
			}


			submit.isHidden = false
			confirm.isHidden = true
						
		}
			
	}
	
	@IBAction func skipHit(_ sender: Any) {
				
				let db = Firestore.firestore()
		
				let docRefUser = db.collection("data").document("question")

				docRefUser.getDocument { (document, error) in
					if let document = document, document.exists {
					let myDocument = document.data()
						self.max = myDocument?["totalQuestions"] as! Int

						print (self.counter)
						
					}
					
					
				}
		
		if self.counter >= self.max {
			
			self.counter = 0
			
		} else {
			
			self.counter += 1
			
		}

				db.collection("users").document(email).setData(["question": counter], merge: true)
		
				answerText.text = ""
				
				
				db.collection("data").document("question").getDocument { (document, error) in
					if let document = document, document.exists {
					let myDocument = document.data()
						self.question = myDocument?["\(self.counter)"] as! String
						print (self.counter)
						print (self.question)
						print ("\(self.question)?")
						self.questionLabel.text = "\(self.question)?"

						
						
					}
					
					
				}
		
		let docRef = self.db.collection("users").document(self.email)

		docRef.getDocument { (document, error) in
			if let document = document, document.exists {
			let myDocument = document.data()
				self.counterAndOne = self.counter + 1
				let currentAnswer = myDocument?["question \(self.counter)"] as! String
				print (self.counter)
				self.currentLabel.text = currentAnswer
				
				if currentAnswer == "" {
					
					self.currentAnswerLabel.isHidden = true
					self.currentLabel.isHidden = true
					
				} else {
					
					self.currentAnswerLabel.isHidden = false
					self.currentLabel.isHidden = false
					
				}
				
			}
			
			
		}


		submit.isHidden = false
		confirm.isHidden = true
		
		
	}
	
	@IBAction func back(_ sender: Any) {
				
				let db = Firestore.firestore()
		
				let docRefUser = db.collection("data").document("question")

				docRefUser.getDocument { (document, error) in
					if let document = document, document.exists {
					let myDocument = document.data()
						self.max = myDocument?["totalQuestions"] as! Int

						print (self.counter)
						
					}
					
					
				}
		
		if self.counter <= 0 {
			
			self.counter = self.max
			
		} else {
			
			self.counter -= 1
			
		}

				db.collection("users").document(email).setData(["question": counter], merge: true)
		
				answerText.text = ""
				
				
				db.collection("data").document("question").getDocument { (document, error) in
					if let document = document, document.exists {
					let myDocument = document.data()
						self.question = myDocument?["\(self.counter)"] as! String
						print (self.counter)
						print (self.question)
						print ("\(self.question)?")
						self.questionLabel.text = "\(self.question)?"

						
						
					}
					
					
				}
		
		let docRef = self.db.collection("users").document(self.email)

		docRef.getDocument { (document, error) in
			if let document = document, document.exists {
			let myDocument = document.data()
				self.counterAndOne = self.counter + 1
				let currentAnswer = myDocument?["question \(self.counter)"] as! String
				print (self.counter)
				self.currentLabel.text = currentAnswer
				
				if currentAnswer == "" {
					
					self.currentAnswerLabel.isHidden = true
					self.currentLabel.isHidden = true
					
				} else {
					
					self.currentAnswerLabel.isHidden = false
					self.currentLabel.isHidden = false
					
				}
				
			}
			
			
		}


		submit.isHidden = false
		confirm.isHidden = true
		
		
	}

	
	
}
