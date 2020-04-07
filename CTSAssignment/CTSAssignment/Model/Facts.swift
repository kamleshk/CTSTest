//
//  Facts.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

struct Facts {
	let title: String
	let rows: [Rows]
}
extension Facts: Parceable {
	
	/// Protocol method for parsing and modeling a  data
	/// - Parameter dictionary: JSON dictionary which we had got from api
	/// - Returns: Result enum
	static func parseObject(dictionary: [String : AnyObject]) -> Result<Facts, ErrorResult> {
		if  let  title  = dictionary["title"]  as? String,
			let rows = dictionary["rows"] as? [[String:AnyObject]] {
			let finalRates : [Rows] = rows.compactMap { (dict) -> Rows? in
				return Rows(title: dict["title"] as? String ?? "NA", description: dict["description"] as? String ?? "NA", imageHref: dict["imageHref"] as? String ?? "")
			}
			let facts = Facts(title: title, rows: finalRates)
			return Result.success(facts)
		} else {
			return Result.failure(ErrorResult.parser(string: "Unable to parse"))
		}
	}
	
}

/// Hold model for each Facts for Dropbox Api
struct Rows {
	let title:String
	let description:String
	let imageHref:String
}

