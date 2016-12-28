//
//  IMScrollViewController.swift
//  IMCyclePageView
//
//  Created by imwallet on 16/12/28.
//  Copyright © 2016年 imWallet. All rights reserved.
//

import UIKit

class IMScrollViewController: UIViewController, IMScorllerPageViewDelegate{

    var cycleModels :[IMCycleModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .contactAdd)
        button.frame.origin = CGPoint(x: 30, y: 30)
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        let scrollPageView = IMScorllerPageView(frame: CGRect(x: 0, y: 200, width: screentWidth, height: screetHeight * 0.3))
        scrollPageView.images = cycleModels
        scrollPageView.delegate = self
        view.addSubview(scrollPageView)
        
    }
    
    @objc fileprivate func buttonClick(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupData() {
        for index in 0..<7 {
            let cycleModel = IMCycleModel()
            cycleModel.title = "   这是第\(index + 1)张"
            cycleModel.picUrl = "school_pic\(index + 1)"
            cycleModels.append(cycleModel)
        }
    }
    
    func imageViewClick(_ tag: Int) {
        print("imageView title is \(cycleModels[tag].title)")
        print("imageView image is \(cycleModels[tag].picUrl)")

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
