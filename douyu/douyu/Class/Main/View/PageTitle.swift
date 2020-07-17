//
//  PageTitle.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
protocol PageTitleDelegate: class {
    func pageTitleView(titleView:PageTitle,selectIndex index: Int)
}
private let kScrollLineH : CGFloat = 2
private let titleCount : CGFloat = 5
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
class PageTitle: UIView {
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate :PageTitleDelegate?
    private lazy var titleLabs : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        let scrollViewW = frame.width / (titleCount < CGFloat(titles.count) ? titleCount : CGFloat(titles.count)) * CGFloat(titles.count)
        scrollView.contentSize = CGSize(width: scrollViewW, height: 0)
        return scrollView
        
    }()
    private lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitle {
    private func setUpUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setUpLabels()
        setUpScrollLine()
    }
    private func setUpLabels() {
        let labW : CGFloat = frame.width / (titleCount < CGFloat(titles.count) ? titleCount : CGFloat(titles.count) )
        let labH : CGFloat = frame.height - kScrollLineH
        let labY :CGFloat = 0
        for (index,title) in titles.enumerated() {
            let lab = UILabel()
            lab.text = title
            lab.tag = index
            lab.textAlignment = .center
            lab.font = UIFont.systemFont(ofSize: 17)
            lab.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            let labX :CGFloat = labW * CGFloat(index)
            lab.frame = CGRect(x: labX, y: labY, width: labW, height: labH)
            scrollView.addSubview(lab)
            titleLabs.append(lab)
            lab.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleClick(tapGes:)))
            lab.addGestureRecognizer(tapGes)
        }
    }
    private func setUpScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let fristLab = titleLabs.first else {return}
        fristLab.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: fristLab.bounds.origin.x, y: frame.height - kScrollLineH, width: fristLab.bounds.size.width, height: kScrollLineH)
        
    }
}

extension PageTitle {
    @objc private func titleClick(tapGes:UITapGestureRecognizer){
        guard let lab = tapGes.view as? UILabel else {return}
        if currentIndex == lab.tag {
            return
        }
        let oldLab = titleLabs[currentIndex]
        currentIndex = lab.tag
       
        lab.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLab.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
              
        let scrollLineX = CGFloat(lab.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}
extension PageTitle {
    func setTitleWithProgress(progress:CGFloat,sourceInde:Int, targetIndex:Int) {
        let sourceLab = titleLabs[sourceInde]
        let targetLab = titleLabs[targetIndex]
       let moveTotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLab.frame.origin.x + moveX
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        sourceLab.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        targetLab.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
        
        
    }
}
