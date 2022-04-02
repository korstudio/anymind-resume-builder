//
//  ImageCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit
import RxSwift

protocol ImageCellDelegate: AnyObject {
    func imageCellDidTapOnImageView()
}

class ImageCell: UITableViewCell {
    @IBOutlet private var photoImageView: UIImageView!
    weak var delegate: ImageCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapImageView))
        photoImageView.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(image: UIImage?) {
        photoImageView.image = image
    }

    @objc private func onTapImageView() {
        delegate?.imageCellDidTapOnImageView()
    }
}