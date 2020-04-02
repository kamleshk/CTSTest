//
//  Facts.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

struct Facts {
    let title:String
    let rows:[Rows]
}
extension Facts : Parceable {
    // parsing the response which we had got from api
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Facts, ErrorResult> {
      if  let  title  = dictionary["title"]  as? String,
          let rows = dictionary["rows"] as? [[String:AnyObject]] {
        
        let finalRates : [Rows] = rows.compactMap { (dict) -> Rows? in
            return Rows(title: dict["title"] as? String ?? "", description: dict["description"] as? String ?? "", imageHref: dict["imageHref"] as? String ?? "")
        }
      let facts = Facts(title: title, rows: finalRates)
        return Result.success(facts)
      } else {
        return Result.failure(ErrorResult.parser(string: "Unable to parse"))
      }
    }
    
}

struct Rows {
    let title:String
    let description:String
    let imageHref:String
}

