import Foundation
public class VotingResult{
    var result_id: UUID
    var login_id: UUID
    var quesstion_id: UUID
    var response_id: UUID
    var isVoted: Bool
    
    
    init(result_id: UUID, login_id: UUID, quesstion_id: UUID, response_id: UUID, isVoted: Bool ) {
        self.result_id = result_id
        self.login_id = login_id
        self.quesstion_id = quesstion_id
        self.response_id = response_id
        self.isVoted = isVoted
    }
}
