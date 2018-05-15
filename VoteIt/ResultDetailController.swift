import UIKit
import CoreData;
class ResultDetailController: UIViewController {

   
    var questions : Array<Question> = []
    var index = -1
    var result : Array<Result> = []
    var stronglyAgree : Array<Result> = []
    var agree : Array<Result> = []
    var notAgreeNorDisagree : Array<Result> = []
    var disagree : Array<Result> = []
    var stronglyDisagree : Array<Result> = []
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblStonglyAgree: UILabel!
    
    @IBOutlet weak var lblAgree: UILabel!
    @IBOutlet weak var lblNotAgreeNorDisagree: UILabel!
    @IBOutlet weak var lblDisagree: UILabel!
    @IBOutlet weak var lblStronglyDisagree: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
        lblQuestion.text = questions[index].question
        lblQuestion.numberOfLines = 2
        lblCategory.text = questions[index].category
        lblStonglyAgree.text = String(stronglyAgree.count)
        lblAgree.text = String(agree.count)
        lblNotAgreeNorDisagree.text = String(notAgreeNorDisagree.count)
        lblDisagree.text = String(disagree.count)
        lblStronglyDisagree.text = String(stronglyDisagree.count)
    }

    func loadData(){
        let question_id = questions[index].question_id
        let d = UIApplication.shared.delegate as! AppDelegate
        let c = d.persistentContainer.viewContext
        do{
            let fr: NSFetchRequest<Result> = Result.fetchRequest()
            fr.predicate = NSPredicate(format: "question_id == %@", question_id! as CVarArg)
            result = try c.fetch(fr)
            }catch{
            }
        filterData()
    }
    
    func filterData(){
        for i in 0..<result.count{
            if(result[i].response == Response.ResponseTypes.StronglyAgree.rawValue){
                stronglyAgree.append(result[i])
            }else if(result[i].response == Response.ResponseTypes.Agree.rawValue){
                agree.append(result[i])
            }else if(result[i].response == Response.ResponseTypes.NeitherAgreeNorDisagree.rawValue){
                notAgreeNorDisagree.append(result[i])
            }else if(result[i].response == Response.ResponseTypes.Disagree.rawValue){
                disagree.append(result[i])
            }else{
                stronglyDisagree.append(result[i])
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
