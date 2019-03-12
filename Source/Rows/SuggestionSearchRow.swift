//
//  SuggestionSearchRow.swift
//  JMXForm
//
//  Created by Jonas Mahiques on 2019-03-07.
//  Copyright © 2019 JonasMx. All rights reserved.
//

import UIKit

final class SuggestionSearchRow:Row<SuggestionSearchCell>, RowType {
    var onTextFieldDidBeginEditing:((SuggestionSearchCell, SuggestionSearchRow) -> ())?
    var onTextFieldDidEndEditing:((SuggestionSearchCell, SuggestionSearchRow) -> ())?
    var onTextFieldDidChange:((SuggestionSearchCell, SuggestionSearchRow) -> ())?
    var onDidSearchText:((SuggestionSearchCell, SuggestionSearchRow) -> ())?
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<SuggestionSearchCell>()
        
        cell.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
        cell.textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        cell.textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ sender:UITextField) {
        value = cell.textField.text
        
        if let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            cell.addButton.isEnabled = true
        } else {
            cell.addButton.isEnabled = false
        }
        
        onTextFieldDidChange?(cell, self)
    }
    
    @objc private func textFieldDidEndEditing(_ sender:UITextField) {
        onTextFieldDidEndEditing?(cell, self)
    }
    
    @objc private func textFieldDidBeginEditing(_ sender:UITextField) {
        onTextFieldDidBeginEditing?(cell, self)
    }
    
    @objc func handleAddButton(_ sender:UIButton) {
        onDidSearchText?(cell, self)
    }
    
    func endEditing() {
        cell.addButton.isEnabled = false
        cell.textField.text = nil
        cell.textField.resignFirstResponder()
    }
}

class SuggestionSearchCell:Cell<String>, CellType {
    let textField:UITextField = {
        let tf = UITextField()
        tf.layer.masksToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setContentHuggingPriority(UILayoutPriority(rawValue: 999.0), for: .horizontal)
        return tf
    }()
    
    let addButton:UIButton = {
        let b = UIButton(type: .roundedRect)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Add", for: .normal)
        b.isEnabled = false
        b.setContentHuggingPriority(UILayoutPriority(rawValue: 1000.0), for: .horizontal)
        b.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000.0), for: .horizontal)
        return b
    }()
    
    override open func setup() {
        super.setup()
        
        detailTextLabel?.isHidden = true
        
        contentView.addSubview(textField)
        contentView.addSubview(addButton)
        
        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.0).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0).isActive = true
        addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        textField.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -16.0).isActive = true
    }
}
