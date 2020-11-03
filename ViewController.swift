//
//  ViewController.swift
//  Turtle 3
//
//  Created by Reece Calvin on 5/30/20.
//  Copyright © 2020 Arcie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var signUpButton: UIButton!
	
	@IBOutlet weak var logInButton: UIButton!
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		setUpElements()
		

	}
	
	func setUpElements(){
		Utilities.styleFilledButtonBlue(signUpButton)
		Utilities.styleHollowButton(logInButton)
	}
	
}

