import UIKit
import CoreData;
class VoteController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
    
  
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var lblSelectedOption: UILabel!
    
    @IBOutlet weak var btnVoteOutlet: UIButton!
    
    var selectedOption: String = ""
    
    var questions : Array<Question> = []
    var options: Array<Response> = []
    var selecteduserid = ""
    var selectedQuesId = ""
    var selectedQuestion = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblQuestion.text = selectedQuestion//questions[index].question
        lblQuestion.numberOfLines = 2;
        btnVoteOutlet.layer.cornerRadius = btnVoteOutlet.frame.height / 2
        createData()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func saveData(){
           //Save the new item in the SQLite database
            let d = UIApplication.shared.delegate as! AppDelegate
            let c = d.persistentContainer.viewContext
            
            let result = Result(context: c)
            result.result_id = UUID.init()
            result.login_id = UUID(uuidString: selecteduserid)
            result.question_id =  UUID(uuidString: selectedQuesId)//questions[index].question_id
            result.voted = true
            result.response = selectedOption
           
            d.saveContext()
            navigationController?.popViewController(animated: true)
        
    }
    
     func checkedVoted()-> Bool{
        var userResult: Array<Result> = []
        var checkVoted: Bool = true
        let user_id = selecteduserid //questions[index].login_id
        let question_id = selectedQuesId
        let d = UIApplication.shared.delegate as! AppDelegate
        let c = d.persistentContainer.viewContext
        do{
            let fr: NSFetchRequest<Result> = Result.fetchRequest()
            
            
            let subPredicate1 = NSPredicate(format: "(login_id = %@)", user_id as CVarArg )
            let subPredicate2 = NSPredicate(format: "(question_id = %@)", question_id as CVarArg)
            fr.predicate = NSCompoundPredicate(type: .and, subpredicates: [subPredicate1, subPredicate2])
            
          
            userResult = try c.fetch(fr)
            if(userResult.count > 0 && userResult[0].voted == true){
                let alert = UIAlertController(title: "Alert", message: "You have already voted.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                checkVoted = false
            }
            else{
                checkVoted = true
            }
        }catch{
        }
        return checkVoted
    }
    
    func createData(){
        options.append(Response(aresponse:Response.ResponseTypes.Agree))
        options.append(Response(aresponse:Response.ResponseTypes.StronglyAgree))
        options.append(Response(aresponse:Response.ResponseTypes.NeitherAgreeNorDisagree))
        options.append(Response(aresponse:Response.ResponseTypes.Disagree))
        options.append(Response(aresponse:Response.ResponseTypes.StronglyDisagree))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return options[row].response.rawValue
        case 1:
            return options[row].response.rawValue
        default:
            return options[row].response.rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options[pickerView.selectedRow(inComponent: 0)].response.rawValue
        lblSelectedOption.text = selectedOption
    }
    
    @IBAction func btnVote(_ sender: UIButton) {
        if(checkedVoted()){
            
            if((selectedOption.isEmpty)){
                let alert = UIAlertController(title: "All fields are required", message: "Please enter your credentials", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else
            {
                 saveData()
            }
            
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
