//
//  SuggestionView.swift
//  JMXForm
//
//  Created by Jonas Mahiques on 2019-03-07.
//  Copyright © 2019 JonasMx. All rights reserved.
//

import UIKit

class SuggestionView:UIView, UITableViewDelegate, UITableViewDataSource {
    private var tableView = UITableView()
    
    var onDidSelectRowAtIndex:((Int) -> ())?
    var dataSource:SuggestionDataSource?
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        tableView.isHidden = true
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(self.tableView)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        tableView.isHidden = true
        dataSource = nil
        reloadData()
    }
    
    func reloadData() {
        if let dataSource = self.dataSource, dataSource.numberOfRow() > 0 {
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfRow() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource!.cellForRow(at: indexPath.row, of: tableView)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onDidSelectRowAtIndex?(indexPath.row)
    }
}
