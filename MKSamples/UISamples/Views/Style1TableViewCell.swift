//
//  Style1TableViewCell.swift
//  MKSamples
//
//  Created by Mike on 2018/12/3.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

protocol TableViewCellBehavior {
    var title: String { get set }
    var subTitle: String { get set }
    var thumbnailUrl: String { get set }
}

struct TableViewCell: TableViewCellBehavior {
    var title: String
    var subTitle: String
    var thumbnailUrl: String
}

class Style1TableViewCell: UITableViewCell {
    
    static let IDENTIFIER = "Style1TableViewCell"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgVwThumb: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setup(viewModel: TableViewCellBehavior?) {
        guard let viewModel = viewModel else { return }
        
        self.lblTitle.text = viewModel.title
        self.lblSubTitle.text = viewModel.subTitle
        self.imgVwThumb.sd_setImage(with: URL(string: viewModel.thumbnailUrl))

    }
}
