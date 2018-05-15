import UIKit
import CoreData;
class ResultController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user_id = ""
    var questions : Array<Question> = []
    var selectedIndex = -1
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //lblTitle.text = user_id
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
        
        
        if(questions.count > 0){
            lblTitle.text = "Question posted by you"
        }else{
            lblTitle.text = "You have not posted any question"
        }
       
    }
    func loadData(){
        let d = UIApplication.shared.delegate as! AppDelegate
        let c = d.persistentContainer.viewContext
        do{
            let fr: NSFetchRequest<Question> = Question.fetchRequest()
            fr.predicate = NSPredicate(format: "login_id == %@", user_id as CVarArg)
            questions = try c.fetch(fr)
            
        }catch{
            
        }
    }

   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = questions[indexPath.row].question
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = "Result"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor.blue
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "resultToResultDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "resultToResultDetail"){
            
            let destinationVC = segue.destination as! ResultDetailController
            destinationVC.index = selectedIndex
            destinationVC.questions = questions
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
