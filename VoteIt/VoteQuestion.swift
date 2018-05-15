import Foundation
public class VoteQuestion{
    var question_id: UUID
    var question: String
    var category_id: UUID
    
    init(ques_id: UUID, ques: String, cat_id: UUID ) {
        question_id = ques_id
        question = ques
        category_id = cat_id
    }
}
