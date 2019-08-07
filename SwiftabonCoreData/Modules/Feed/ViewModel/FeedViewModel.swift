//
//  FeedViewModel.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

protocol FeedViewModeling {
    func viewModel(forIndexPath indexPath: IndexPath) -> FeedTableViewCellViewModel
    var numberOfRecords: Int { get }

    var willChangeContent: (() -> Void)? { get set }
    var didChangeContent: (() -> Void)? { get set }
    var didInsertObject: ((IndexPath) -> Void)? { get set }
    var didRemoveObject: ((IndexPath) -> Void)? { get set }
}

protocol FeedViewModelActioning {
    func add()
    func clear()
    func sync()
    func upload()
    func download()
}

struct FeedViewModel {

    private var model: FeedModeling

    init(with model: FeedModeling, router: Router) {
        self.model = model
    }

    var willChangeContent: (() -> Void)? {
        didSet { model.willChangeContent = willChangeContent }
    }

    var didChangeContent: (() -> Void)?  {
        didSet { model.didChangeContent = didChangeContent }
    }

    var didInsertObject: ((IndexPath) -> Void)? {
        didSet { model.didInsertObject = didInsertObject }
    }

    var didRemoveObject: ((IndexPath) -> Void)? {
        didSet { model.didRemoveObject = didRemoveObject }
    }
}

extension FeedViewModel: FeedViewModeling {

    func viewModel(forIndexPath indexPath: IndexPath) -> FeedTableViewCellViewModel {
        let record = model.record(forIndexPath: indexPath)
        return FeedTableViewCellViewModel(author: record.user?.username, sweet: record.text)
    }

    var numberOfRecords: Int {
        return model.numberOfRecords
    }
}

extension FeedViewModel: FeedViewModelActioning {

    func add() {
        Router.shared.route(to: .addRecord)
    }

    func clear() {
        model.clear()
    }

    func sync() {
        model.sync()
    }

    func upload() {
        model.upload()
    }

    func download() {
        model.download()
    }
}
