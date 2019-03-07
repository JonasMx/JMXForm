//
//  SuggestionDataSource.swift
//  JMXForm
//
//  Created by Jonas Mahiques on 2019-03-07.
//  Copyright © 2019 JonasMx. All rights reserved.
//

import Foundation

public protocol SuggestionDataSource {
    func numberOfRow() -> Int
    func cellForRow(at index:Int, of tableView:UITableView) -> UITableViewCell
}
