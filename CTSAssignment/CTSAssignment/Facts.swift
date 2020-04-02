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
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Facts, ErrorResult> {
      if  let  title  = dictionary["title"]  as? String,
          let rows = dictionary["rows"] as? [[String:String]] {
        
        let finalRates : [Rows] = rows.compactMap { (dict) -> Rows? in
            return Rows(title: dict["title"] ?? "", description: dict["description"] ?? "", imageHref: dict["imageHref"] ?? "")
        }
      let facts = Facts(title: title, rows: finalRates)
        return Result.success(facts)
      } else {
        return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
      }
    }
    
}

struct Rows {
    let title:String
    let description:String
    let imageHref:String
}

