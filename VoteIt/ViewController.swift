import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menu_vc: MenuViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var menuOutlet: UIBarButtonItem!
    
    var user_id = ""
    var question_id = ""
    var question = ""
    var selectedUserId = ""
    var LogedInUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menu_vc.user_Id = user_id
        menu_vc.logedInUser = LogedInUser
        menuOutlet.title = "\u{2630}"
        
    }
    
    
    
    @IBAction func menuIconAction(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool{
            show_menu()
        }else{
            close_menu()
        }
    }
    
    func show_menu(){
        UIView.animate(withDuration: 0.3){ ()->Void in
            
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.addChildViewController(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
        }
        
        
    }
    func close_menu(){
        UIView.animate(withDuration: 0.3, animations: { ()->Void in
            self.menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }){(finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        
        AppDelegate.menu_bool = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        filterData()
        tableView.reloadData()
        
        let backgroundImage = UIImage(named: "Winter-iphone.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        //self.tableView.backgroundColor = UIColor.white
        self.tableView.alpha = 0.95
    }
    
    // MARK: - Table view data source
    
    var questions : Array<Question> = []
    var latest : Array<Question> = []
    var popular : Array<Question> = []
    var trending : Array<Question> = []
    
    var myIndex = 0
    
    func loadData(){
        //Load the data
        
        let d = UIApplication.shared.delegate as! AppDelegate
        let c = d.persistentContainer.viewContext
        
        do{
            questions = try c.fetch(Question.fetchRequest())
        }
        catch{
        }
        
    }
    
    func filterData(){
        
        if(questions.count > 0){
            latest.removeAll()
            popular.removeAll()
            trending.removeAll()
            for i in 0..<questions.count{
                if(questions[i].category == Category.CategoryTypes.Latest.rawValue){
                    latest.append(questions[i])
                }else if(questions[i].category == Category.CategoryTypes.Popular.rawValue){
                    popular.append(questions[i])
                }else{
                    trending.append(questions[i])
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(questions.count > 0){
            return 3;
        }else{
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return latest.count
        case 1:
            return popular.count
        default:
            return trending.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header")
        if(questions.count > 0){
            switch section {
            case 0:
                if(latest.count > 0){
                    header?.textLabel?.text = "Latest"
                    header?.textLabel?.font = UIFont(name: "Futura", size: 18)!
                    header?.textLabel?.textColor = UIColor.white
                    header?.textLabel?.textAlignment = NSTextAlignment.center
                   
                }else{
                    header?.backgroundColor = UIColor.white
                    
                }
            case 1:
                if(popular.count > 0){
                    header?.textLabel?.text = "Popular"
                    header?.textLabel?.font = UIFont(name: "Futura", size: 18)!
                    header?.textLabel?.textColor = UIColor.white
                    header?.textLabel?.textAlignment = NSTextAlignment.center
                   
                }else{
                    header?.backgroundColor = UIColor.white
                }
            default:
                if(trending.count > 0){
                    header?.textLabel?.text = "Trending"
                    header?.textLabel?.font = UIFont(name: "Futura", size: 18)!
                    header?.textLabel?.textColor = UIColor.white
                    header?.textLabel?.textAlignment = NSTextAlignment.center
                  
                }else{
                    header?.backgroundColor = UIColor.white
                }
            }
            
            
            
        }else{
            header?.textLabel?.font = UIFont(name: "Futura", size: 20)!
            header?.textLabel?.textColor = UIColor.white
            header?.textLabel?.textAlignment = NSTextAlignment.center
            header?.textLabel?.text = "No Reocrds Found."
           
        }
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = latest[indexPath.row].question
            cell.textLabel?.numberOfLines = 2
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.text = "Vote"
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.textColor = UIColor.blue
            return cell;
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = popular[indexPath.row].question
            cell.textLabel?.numberOfLines = 2
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.text = "Vote"
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.textColor = UIColor.blue
            return cell;
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = trending[indexPath.row].question
            cell.textLabel?.numberOfLines = 2
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.text = "Vote"
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.textColor = UIColor.blue
            return cell;
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            question_id = (latest[indexPath.row].question_id?.uuidString)!
            question =  latest[indexPath.row].question!
            selectedUserId = user_id
        case 1:
            question_id = (popular[indexPath.row].question_id?.uuidString)!
            question =  popular[indexPath.row].question!
            selectedUserId = user_id
        default:
            question_id = (trending[indexPath.row].question_id?.uuidString)!
            question =  trending[indexPath.row].question!
            selectedUserId = user_id
        }
        myIndex = indexPath.row
        performSegue(withIdentifier: "segueVoteScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueVoteScreen"){
            
            let voteScreen: VoteController = segue.destination as! VoteController
            voteScreen.index = myIndex
            voteScreen.questions = questions
            voteScreen.selectedQuesId = question_id
            voteScreen.selectedQuestion = question
            voteScreen.selecteduserid = selectedUserId
        }
        
        if(segue.identifier == "segueQuestion"){
            let destinationVC = segue.destination as! QuestionController
            destinationVC.user_id = user_id
        }
    }
    
    
    
}

