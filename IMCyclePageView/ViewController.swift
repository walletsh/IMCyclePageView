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
        // Do any additional setup after loading the view, typically from a nib.
        
        let cycleView = IMCycleView(frame: CGRect(x: 0, y: 100, width: screentWidth, height: screetHeight * 0.3))
        cycleView.cycleModels = cycleModels
        self.view.addSubview(cycleView)
    }
    
    
    func setupData() {
        for index in 0..<7 {
            let cycleModel = IMCycleModel()
            cycleModel.title = "   这是第\(index + 1)张"
            cycleModel.picUrl = "school_pic\(index + 1)"
            cycleModels.append(cycleModel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

