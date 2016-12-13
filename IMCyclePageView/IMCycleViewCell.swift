//
//  IMCycleViewCell.swift
//  IMCyclePageView
//
//  Created by imwallet on 16/12/12.
//  Copyright © 2016年 imWallet. All rights reserved.
//

import UIKit

class IMCycleViewCell: UICollectionViewCell {
    
    var picImageView :UIImageView?
    var titleLabel: UILabel?
    var cycleModel: IMCycleModel? {
        didSet{
            titleLabel?.text = cycleModel?.title
            picImageView?.image = UIImage(named: cycleModel?.picUrl ?? "Img_default")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IMCycleViewCell{
    
    fileprivate func setupSubViews() {
        picImageView = UIImageView(frame: self.bounds)
        picImageView?.backgroundColor = UIColor.white
        addSubview(picImageView!)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 40))
        titleLabel?.textColor = UIColor.red
        titleLabel?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        addSubview(titleLabel!)
    }
}
