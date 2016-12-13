//
//  IMCycleView.swift
//  IMCyclePageView
//
//  Created by imwallet on 16/12/12.
//  Copyright © 2016年 imWallet. All rights reserved.
//

import UIKit

private let CycleCellID = "IMCycleViewCell"

class IMCycleView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    fileprivate lazy var colletionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let colletionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.isPagingEnabled = true
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.register(IMCycleViewCell.self, forCellWithReuseIdentifier: CycleCellID)
        layout.itemSize = colletionView.bounds.size
        return colletionView
    }()
    
    
    fileprivate lazy var pageControl:UIPageControl = {[unowned self] in
        let pageControl = UIPageControl(frame: CGRect(x: self.frame.size.width - 100 - 10, y: self.frame.size.height - 40, width: 100, height: 40))
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.green
        return pageControl
    }()
    
    
    var timer: Timer?
    
    var cycleModels: [IMCycleModel]?{
        didSet{
            colletionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            colletionView.scrollToItem(at: indexPath, at: .left, animated: true)
            removeCycleTimer()
            addCycleTimer()
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

extension IMCycleView{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: CycleCellID, for: indexPath) as! IMCycleViewCell
        cell.cycleModel = cycleModels?[indexPath.row % (cycleModels?.count)!]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cycleModel = cycleModels?[indexPath.row % (cycleModels?.count)!]

        print("collectionView -- didSelectItemAt \(indexPath.row)")
        print("cycleModel : \(cycleModel)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}


extension IMCycleView{
    
    fileprivate func setupSubViews() {
        addSubview(colletionView)
        addSubview(pageControl)
    }
}

extension IMCycleView{
    fileprivate func addCycleTimer() {
        timer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        colletionView.setContentOffset(CGPoint(x: colletionView.contentOffset.x + colletionView.bounds.width, y: 0), animated: true)
    }
}






