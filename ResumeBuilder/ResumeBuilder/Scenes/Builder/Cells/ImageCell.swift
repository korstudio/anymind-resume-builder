//
//  ImageCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit
import RxSwift

protocol ImageCellDelegate: AnyObject {
    func imageCell(cell: ImageCell, didSelectImage image: UIImage?)
}

class ImageCell: UITableViewCell {
    @IBOutlet private var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let gesture = UITapGestureRecognizer()
//        photoImageView.rx.gesture(gesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(image: UIImage?) {
        photoImageView.image = image
    }
}

extension ImageCell: UIGestureRecognizerDelegate {
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        super.gestureRecognizer(gestureRecognizer, shouldReceive: touch)
    }
}