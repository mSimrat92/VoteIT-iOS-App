import UIKit
import CoreData

class LoginController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLoginOutlet: UIButton!
    @IBOutlet weak var btnSignUpOutlet: UIButton!
    
    
    var logedInUser = ""
    var user_id = ""
    var user : Array<Login> = []
    
    func validateEmail(enterEmail:String) -> Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@",emailFormat)
        return emailPredicate.evaluate(with:enterEmail)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let email = txtEmail.text
        let password = txtPassword.text
        
        if(!(email?.isEmpty)! && !(password?.isEmpty)! ){
            
            if( validateEmail(enterEmail: email!)){
                
                let d = UIApplication.shared.delegate as! AppDelegate
                let c = d.persistentContainer.viewContext
                do{
                    let fr: NSFetchRequest<Login> = Login.fetchRequest()
                    //fr.predicate = NSPredicate(format: "email == %@", email! as CVarArg)
                    
                    let subPredicate1 = NSPredicate(format: "(email = %@)", email! as CVarArg )
                    let subPredicate2 = NSPredicate(format: "(password = %@)", password! as CVarArg)
                    fr.predicate = NSCompoundPredicate(type: .and, subpredicates: [subPredicate1, subPredicate2])
                    
                    user = try c.fetch(fr)
                    
                    if(user.count > 0){
                        if( user[0].email == email  && user[0].password == password){
                            logedInUser = email!
                            performSegue(withIdentifier: "segueMain", sender: nil)
                        }
                        
                    }else{
                        let alert = UIAlertController(title: "Record not found", message: "Please check your credentials", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }catch{
                    
                }
                
            }
            else{
                let alert = UIAlertController(title: "Email is not Valid", message: "Please enter valid email address", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
        }else{
            let alert = UIAlertController(title: "All fields are required", message: "Please enter your credentials", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "segueMain"){
            let destinationVC = segue.destination as! ViewController
            destinationVC.user_id = (user[0].login_id?.uuidString)!
            destinationVC.LogedInUser = logedInUser
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnLoginOutlet.layer.cornerRadius = btnLoginOutlet.frame.height / 2
        btnSignUpOutlet.layer.cornerRadius = btnSignUpOutlet.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
