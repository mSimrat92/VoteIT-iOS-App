import Foundation
public class Response{
   
    
    enum ResponseTypes: String {
        case Agree,StronglyAgree = "Strongly Agree",Disagree,StronglyDisagree = "Strongly Disagree",NeitherAgreeNorDisagree = "Neither Agree or Nor Disagree"
    }
    
    var response: ResponseTypes!
    
    init(aresponse: ResponseTypes) {
        response = aresponse
    }
}
