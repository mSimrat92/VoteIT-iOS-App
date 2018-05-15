import UIKit

class QuestionController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var category : Array<Category> = []
    var selectedCategory: String = ""
    var user_id = ""
    
    @IBOutlet weak var txtQuestion: UITextField!
    
    @IBOutlet weak var btnCreateOutlet: UIButton!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func btnCreate(_ sender: UIButton) {
       saveData()
    }
    
    func createData(){
        category.append(Category(acategory: Category.CategoryTypes.Latest))
        category.append(Category(acategory: Category.CategoryTypes.Popular))
        category.append(Category(acategory: Category.CategoryTypes.Trending))
     
    }
    
    func saveData(){
       
        if((selectedCategory.isEmpty) || (txtQuestion.text!.isEmpty)){
            let alert = UIAlertController(title: "All fields are required", message: "Please enter your credentials", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            //Save the new item in the SQLite database
            let d = UIApplication.shared.delegate as! AppDelegate
            let c = d.persistentContainer.viewContext

            let question = Question(context: c)
            question.login_id = UUID(uuidString: user_id)
            question.category = selectedCategory
            question.question = txtQuestion.text
            question.question_id = UUID.init()
            d.saveContext()
            navigationController?.popViewController(animated: true)
        }
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return category.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return category[row].category.rawValue
        case 1:
            return category[row].category.rawValue
        default:
            return category[row].category.rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = category[pickerView.selectedRow(inComponent: 0)].category.rawValue
        lblCategory.text = selectedCategory
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        btnCreateOutlet.layer.cornerRadius = btnCreateOutlet.frame.height / 2
        pickerView.dataSource = self
        pickerView.delegate = self
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
