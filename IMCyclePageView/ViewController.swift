//
//  ViewController.swift
//  IMCyclePageView
//
//  Created by imwallet on 16/12/12.
//  Copyright © 2016年 imWallet. All rights reserved.
//

import UIKit

let screentWidth = UIScreen.main.bounds.size.width
let screetHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    var cycleModels :[IMCycleModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        let cycleView = IMCycleView(frame: CGRect(x: 0, y: 100, width: screentWidth, height: screetHeight * 0.3))
        cycleView.cycleModels = cycleModels
        self.view.addSubview(cycleView)
        
        let button = UIButton(type: .contactAdd)
        button.frame.origin = CGPoint(x: screentWidth - 50, y: 30)
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    fileprivate func setupData() {
        for index in 0..<7 {
            let cycleModel = IMCycleModel()
            cycleModel.title = "   这是第\(index + 1)张"
            cycleModel.picUrl = "school_pic\(index + 1)"
            cycleModels.append(cycleModel)
        }
    }
    
    @objc fileprivate func buttonClick(_ button: UIButton) {
        self.present(IMScrollViewController(), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

