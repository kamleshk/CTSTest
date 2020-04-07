//
//  ListDataSource.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import UIKit

class GenericDataSource<T>: NSObject {
	var data: DynamicValue<[T]> = DynamicValue([])
}

class ListDataSource: GenericDataSource<Rows> {
}
extension ListDataSource: UITableViewDataSource {
	
	/// Tableview datasource methods
	/// - Parameter tableView: listtableview
	/// - Returns: number of section as integer value
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.value.count
	}
	
	/// Method responsible for creating each cell and populating data to each cell
	/// - Parameters:
	///   - tableView: own tableView
	///   - indexPath: indexpath for each cell
	/// - Returns: uitableview cell ie ListTableviewCell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
		cell.rowModel = self.data.value[indexPath.row]
		return cell
	}
}
