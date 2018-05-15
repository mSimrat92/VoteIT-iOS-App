import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let string2 = String(describing: UnicodeScalar(0x1F34E))
   
     var user_Id = ""
     var logedInUser = ""
     var title_arr : Array<String> = []
    
    @IBOutlet weak var menu_tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title_arr = [ " \u{1F3E0}  " + "Welcome to VoteIt", " \u{1F464}  " + logedInUser, "   \u{003F}   " + "Create Question" , " \u{1F4C8}  " + "Result", "        Logout"]
        menu_tableView.dataSource = self
        menu_tableView.delegate = self
        
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = title_arr[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.row {
        case 2:
             performSegue(withIdentifier: "menuToQuestion", sender: nil)
        case 3:
            performSegue(withIdentifier: "menuToResult", sender: nil)
        case 4:
            performSegue(withIdentifier: "menuToLogin", sender: nil)
        default:
            break
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "menuToResult"){
            let destinationVC = segue.destination as! ResultController
            destinationVC.user_id = user_Id
        }
        
        if(segue.identifier == "menuToQuestion"){
            let destinationVC = segue.destination as! QuestionController
            destinationVC.user_id = user_Id
        }
        if(segue.identifier == "menuToLogin"){
            let destinationVC = segue.destination as! LoginController
            destinationVC.user_id = ""
        }
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
