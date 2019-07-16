//
//  FeedViewController.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import CoreData
import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: (FeedViewModeling & FeedViewModelActioning)? {
        didSet { bindViewModel() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    private func bindViewModel() {
        guard var viewModel = viewModel else { fatalError("No viewModel") }
        viewModel.willChangeContent = { [weak tableView] in
            tableView?.beginUpdates()
        }
        viewModel.didChangeContent = { [weak tableView] in
            tableView?.endUpdates()
        }
        viewModel.didInsertObject = { [weak tableView] indexPath in
            tableView?.insertRows(at: [indexPath], with: .right)
        }
        viewModel.didRemoveObject = { [weak tableView] indexPath in
            tableView?.deleteRows(at: [indexPath], with: .left)
        }
    }

}

// MARK: Actions

extension FeedViewController {

    @IBAction func addAction(_ sender: Any) {
        viewModel?.add()
    }
    
    @IBAction func clearAction(_ sender: Any) {
        viewModel?.clear()
    }

    @IBAction func syncAction(_ sender: Any) {
        viewModel?.sync()
    }

    @IBAction func uploadAction(_ sender: Any) {
        viewModel?.upload()
    }

    @IBAction func downloadAction(_ sender: Any) {
        viewModel?.download()
    }

}

// MARK: Table Data Source

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { fatalError("Cannot access presenter") }
        return viewModel.numberOfRecords
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftaCell", for: indexPath) as? FeedTableViewCell,
              let cellViewModel = viewModel?.viewModel(forIndexPath: indexPath)
            else { fatalError("Couldn't dequeue a cell.") }
        cell.bindWith(viewModel: cellViewModel)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
