//
//  Style1TableViewCell.swift
//  MKSamples
//
//  Created by Mike on 2018/12/3.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

struct Style1CellDataModel {
    var title: String?
    var subTitle: String?
    var thumbnailUrl: String?
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
    
    override func prepareForReuse() {
        self.resetCell()
    }
    
    private func resetCell() {
        self.lblTitle.text = ""
        self.lblSubTitle.text = ""
    }
    
    public func setup(dataModel: Style1CellDataModel?) {
        self.set(title: dataModel?.title)
        self.set(subTitle: dataModel?.subTitle)
        self.set(thumbnailUrl: dataModel?.thumbnailUrl)
    }
    
    private func set(title: String?) {
        guard let title = title else {
            self.lblTitle.text = ""
            return
        }
        self.lblTitle.text = title
    }
    
    private func set(subTitle: String?) {
        guard let subTitle = subTitle else {
            self.lblSubTitle.text = ""
            return
        }
        self.lblSubTitle.text = subTitle
    }
    
    private func set(thumbnailUrl url: String?) {
        guard let url = url else { return }
        self.imgVwThumb.sd_setImage(with: URL(string: url))
    }
    
}
