//
//  FeedTableViewCell.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var sweet: UILabel!

    func bindWith(viewModel: FeedTableViewCellViewModel) {
        author.text = viewModel.author ?? ""
        sweet.text = viewModel.sweet ?? ""
    }

}

struct FeedTableViewCellViewModel {
    let author: String?
    let sweet: String?
}
