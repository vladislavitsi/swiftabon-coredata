//
//  AddRecordViewController.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import UIKit

class AddRecordViewController: UITableViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var textField: UITextView!

    var viewModel: AddRecordViewModeling?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.keyboardDismissMode = .interactive
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss()
    }

    @IBAction func saveAction(_ sender: Any) {
        let username = usernameField.text
        let text = textField.text
        let record = Record(id: UUID(), user: User(username: username), text: text, date: Date())
        viewModel?.add(record: record)
        dismiss()
    }

    private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
