import UIKit

class AccountController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtCnfrmPassword: UITextField!
    @IBOutlet weak var btnSignUpOutlet: UIButton!
    
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        signUp()
    }
    
    func signUp(){
        // Create New Entity Record
       
        let email = txtEmail.text
        let password = txtPassword.text
        let cnfrmPassword = txtCnfrmPassword.text
        let login_id = UUID.init()
        
        if(!(email?.isEmpty)! && !(password?.isEmpty)! && !(cnfrmPassword?.isEmpty)! ){
           
            if(validateEmail(enterEmail: email!)){
                
           
            
         if(password == cnfrmPassword){
            //Save the new item in the SQLite database
            let d = UIApplication.shared.delegate as! AppDelegate
            let c = d.persistentContainer.viewContext
            
            let newUser = Login(context: c)
            newUser.login_id = login_id
            newUser.email = email
            newUser.password = password
            d.saveContext()
            
            navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Password field should match", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
                }}else{
                let alert = UIAlertController(title: "Email is not valid", message: "Please enter valid email address", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "All fields are required", message: "Please enter your credentials", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
      
    }
    
    func validateEmail(enterEmail:String) -> Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@",emailFormat)
        return emailPredicate.evaluate(with:enterEmail)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnSignUpOutlet.layer.cornerRadius = btnSignUpOutlet.frame.height / 2
        
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
