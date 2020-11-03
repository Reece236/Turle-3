import UIKit
import FirebaseFirestore
import Firebase

//import GoogleMobileAds

class HomeViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var mainText: UILabel!
	
//	@IBOutlet weak var bannerView: GADBannerView!
	
	
	var email = String()
	var message = String()
	var firstName = String()
	var question = Int()
	
	//Read database
	var ref: DatabaseReference!

	//ref = Database.database().reference()
	
	let db = Firestore.firestore()
	let storage = Storage.storage()

	
	//let storage = Storage.storage()
	override func viewDidLoad() {
		
	
		//Set Up Ad
		//test ad
		//	bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"

		
		//real ad
		//bannerView.adUnitID = "ca-app-pub-5799206644054988/6777005307"
		//bannerView.rootViewController = self
		//bannerView.load(GADRequest())

		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		//adding a doc

	let docRef = db.collection("users").document(email)

	docRef.getDocument { (document, error) in
		if let document = document, document.exists {
		let myDocument = document.data()
			self.firstName = myDocument?["firstname"] as! String
			print (self.firstName)
			self.mainText.text = "Welcome \(self.firstName)"

			
		}
		
		
	}
		
	docRef.getDocument { (document, error) in
		print(self.email)
		if let document = document, document.exists {
		let myDocument = document.data()
			self.question = myDocument?["question"] as! Int
			
				firstQViewController().counter = self.question

		}
		
		}
		
		print ("Name is \(firstName)")
		print ("Email is \(email)")
		firstQViewController().email = self.email
		firstQViewController().counter = self.question


	}
	@IBAction func writeHit(_ sender: Any) {
		
		print("Well... \(email)")
		
		performSegue(withIdentifier: "write", sender: self )
		
	}
	
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
					
		let vc = segue.destination as! firstQViewController
		vc.email = email
	}
}


