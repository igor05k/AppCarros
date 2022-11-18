//
//  DetailsTableViewCell.swift
//  AppCarros
//
//  Created by Igor Fernandes on 18/11/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier: String = "DetailsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: CarInfo) {
        guard let photoCar = model.urlFoto else { return }
        carImage.downloaded(from: photoCar)
        carName.text = model.nome
        carType.text = model.tipo
        descriptionLabel.text = model.descricao
    }
}
