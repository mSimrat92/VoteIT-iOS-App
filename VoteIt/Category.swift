import Foundation
public class Category : NSObject{
    
    enum CategoryTypes : String{
         case  Latest,Popular,Trending
    }
    
    var category: CategoryTypes
    
    init(acategory:CategoryTypes) {
        category = acategory
        
    }
    
}
