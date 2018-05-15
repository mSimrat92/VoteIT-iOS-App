import Foundation
public class Account{
    var login_Id: UUID
    var email: String
    var password: String
    
    
    init(id: UUID, Email: String, pswrd: String) {
        login_Id = id
        email = Email
        password = pswrd
    }
}
