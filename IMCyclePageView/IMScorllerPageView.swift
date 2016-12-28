//
//  IMScorllerPageView.swift
//  IMCyclePageView
//
//  Created by imwallet on 16/12/28.
//  Copyright © 2016年 imWallet. All rights reserved.
//

import UIKit



class IMScorllerPageView: UIView, UIScrollViewDelegate{
    
    fileprivate let imageViewMaxCount = 3

    fileprivate var imageViews = Array<UIImageView>()
    fileprivate var titleLabels = Array<UILabel>()
    
    fileprivate var timer: Timer?
    
    weak var delegate: IMScorllerPageViewDelegate?
    
    var images: [IMCycleModel]? {
        didSet{
            pageControl.currentPage = 0
            pageControl.numberOfPages = (images?.count)!
            
            stopTimer()
            startTimer()
            updatePageScrollerView()
        }
    }
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: self.bounds)
        scroll.isPagingEnabled = true
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.delegate = self
        return scroll
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let page = UIPageControl(frame: CGRect(x: self.frame.size.width - 100 - 10, y: self.frame.size.height - 40, width: 100, height: 40))
        page.currentPageIndicatorTintColor = UIColor.orange
        page.pageIndicatorTintColor = UIColor.green
        return page
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        updatePageScrollerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        let width = scrollView.frame.size.width
        let height = scrollView.frame.size.height
        
        for index in 0..<imageViews.count {
            let imageView = imageViews[index]
            let titleLabel = titleLabels[index]
            imageView.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: height)
            titleLabel.frame = CGRect(x: CGFloat(index) * width, y: height - 40, width: width, height: 40)
        }
    }
}

//MARK: - Protocol
protocol IMScorllerPageViewDelegate: NSObjectProtocol {
    func imageViewClick(_ tag: Int)
}

//MARK: - UI
extension IMScorllerPageView{
    
    fileprivate func setupUI() {
        
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        
        scrollViewAddSubViews()
    }
    
    fileprivate func scrollViewAddSubViews() {
        
        for _ in 0..<imageViewMaxCount {
            
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapAction(_:)))
            imageView.addGestureRecognizer(tapRecognizer)
            
            let titleLabel = UILabel()
            titleLabel.textColor = UIColor.red
            titleLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            scrollView.addSubview(titleLabel)
            
            imageViews.append(imageView)
            titleLabels.append(titleLabel)
        }
    }
}

//MARK: - 更新ImageView
extension IMScorllerPageView{
    
    fileprivate func updatePageScrollerView() {
        for i in 0..<imageViews.count {
            
            let imageView = imageViews[i]
            let titleLabel = titleLabels[i]
            var index = pageControl.currentPage
            
            print("pageControl ----- index is \(index)")
            if i == 0 {
                index -= 1
            }else if i == 2 {
                index += 1
            }
            
            if index < 0 {
                index = pageControl.numberOfPages - 1
                
            }else if index > pageControl.numberOfPages - 1{
                index = 0
            }
            
            print("pageControl index is \(index)")
            
            imageView.tag = index
            titleLabel.tag = index
            let cycleModel = images?[index]
            
            imageView.image = UIImage(named: cycleModel?.picUrl ?? "Img_default")
            titleLabel.text = cycleModel?.title
        }
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
    }
    
    @objc fileprivate func imageViewTapAction(_ tapRecognizer: UITapGestureRecognizer) {
        print("imageView tag is \(tapRecognizer.view?.tag)")
        
        delegate?.imageViewClick((tapRecognizer.view?.tag)!)
    }
}

//MARK: - timer
extension IMScorllerPageView{
    fileprivate func startTimer() {
        self.timer = Timer(timeInterval: 3, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    
     fileprivate func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func nextImage() {
        scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.size.width * 2, y: 0), animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension IMScorllerPageView{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var minDistance = MAXFLOAT
        var page = 0
        for i in 0..<imageViews.count {
            let imageView = imageViews[i]
            let distance = fabsf(Float(scrollView.contentOffset.x - imageView.frame.origin.x))
            print("distance is \(distance)")
            if distance < minDistance {
                minDistance = distance
                page = imageView.tag
                print("page is \(page)")
            }
        }
        pageControl.currentPage = page
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageScrollerView()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageScrollerView()
    }
}
