//
//  CarTableViewCell.swift
//  AppCarros
//
//  Created by Igor Fernandes on 18/11/22.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    
    static let identifier: String = "CarTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: CarInfo) {
        guard let carPhoto = model.urlFoto else { return }
        carImage.contentMode = .scaleAspectFill
        carImage.downloaded(from: carPhoto)
        carName.text = model.nome
    }
}
