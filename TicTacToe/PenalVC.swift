//
//  penalcellCollectionViewCell.swift
//  TicTacToe
//
//  Created by DCS on 29/06/21.
//  Copyright © 2021 HRK. All rights reserved.
//

import UIKit

class PenalVC: UICollectionViewCell {
    
    private let imageview:UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        return imgv
    }()
    
    func setupcell(with status:Int){
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 40
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(imageview)
        imageview.frame = CGRect(x: 15, y: 15, width: 50, height: 50)
        
        let name = status == 0 ? "tickblack" : status == 1 ? "x" : ""
        
        imageview.image = UIImage(named: name)
    }
}
