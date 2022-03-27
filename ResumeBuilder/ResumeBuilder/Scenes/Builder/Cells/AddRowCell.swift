//
//  AddRowCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 28/3/22.
//  Copyright © 2022 Methas Tariya. All rights reserved.
//

import UIKit

protocol AddRowCellDelegate: AnyObject {
    func addRowButtonDidTap(for section: Builder.Section)
}

class AddRowCell: UITableViewCell {
    @IBOutlet private var addButton: UIButton!
    
    var section: Builder.Section = .info
    weak var delegate: AddRowCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onAddRowTapped() {
        delegate?.addRowButtonDidTap(for: section)
    }
}
