//
//  SWToast.swift
//  support
//
//  Created by SevenWang on 2016/12/17.
//  Copyright © 2016年 SevenWang. All rights reserved.
//

import UIKit
private let DefaultTopMargin:CGFloat = 82.0 //64 + 18
private let DefaultBottomMargin:CGFloat = 67.0 //49 + 18
private let DefaultSpace:CGFloat = 8.0
private let DefaultMargin:CGFloat = 18.0
private let DefaultFont = UIFont.boldSystemFont(ofSize: 13)
private let DefaultBackgroundColor = UIColor.black
private let DefaultTextColor = UIColor.white
private let DefaultAlpha:CGFloat = 0.7
private let DefaultDissmissAlpha:CGFloat = 0
private let DefaultCornerRadius:CGFloat = 6.0
private let DefaultHeightOfImage:CGFloat = 20.0
private let DefaultDuration:TimeInterval = 1.0

public class SWToast: UIView {
    
    //吐司的样式
    public enum SWToastStyle:Int {
        case text = 0 //纯文字的
        case leftImageAndText = 1 //左边图片右边文字
    }
    //吐司竖直方向的位置
    public enum SWToastLongitudinalPosition:Int {
        case center = 0 //竖直居中
        case bottom = 1 //底部居中
        case top = 2 //顶部居中
    }
    
    //MARK:*************property*******************
    
    private var _style:SWToastStyle = .text
    //吐司的样式
    private var style:SWToastStyle{
        set{
            _style = newValue
            switch newValue {
            case .text:
                self.addMainLabelOfTextStyleLabel()
            case .leftImageAndText:
                self.addMainImageViewOfLeftImageAndText()
                self.addMainLabelOfLeftImageAndText()
            }
        }
        get{
            return _style
        }
    }
    private var superView:UIView!
    //吐司上展示文字的Label
    lazy private var mainLabel:UILabel = UILabel.init()
    //吐司上展示图片的imageView
    lazy private var mainImageView:UIImageView = UIImageView.init(frame: CGRect.init())
    
    
    //吐司竖直方向的位置
    public var longitudinalPosition:SWToastLongitudinalPosition = .center
    
    //吐司上展示的文字
    public var text:String = ""{
        didSet{
            self.setSingleLineText(texts: [self.text])
        }
    }
    
    //吐司上展示的文字数组
    public var texts:[String] = []{
        didSet{
            if self.style == .text {
                self.setMultipleLinesText(texts: self.texts)
            }else{
                self.setSingleLineText(texts: self.texts)
            }
        }
    }
    
    //吐司上展示的文字的颜色
    public var textColor:UIColor = DefaultTextColor{
        didSet{
            self.mainLabel.textColor = self.textColor
        }
    }
    
    //吐司的圆角
    public var cornerRadius:CGFloat = DefaultCornerRadius{
        didSet{
            self.setCornerRadius(value: self.cornerRadius)
        }
    }
    
    //吐司展示的时间
    public var duration:TimeInterval = DefaultDuration{
        didSet{
            self.mainLabel.textColor = self.textColor
        }
    }
    
    //吐司展示的图片
    public var image:UIImage? = nil{
        didSet{
            self.mainImageView.image = self.image
        }
    }
    
    //MARK:*************func*******************
    
    public init(style:SWToastStyle) {
        super.init(frame: CGRect.init())
        self.backgroundColor = DefaultBackgroundColor
        self.alpha = DefaultDissmissAlpha
        self.setCornerRadius(value: self.cornerRadius)
        
        self.style = style
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:给吐司设置圆角
    private func setCornerRadius(value:CGFloat) -> () {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
    
    //MARK:给纯文字风格下的toast添加label
    private func addMainLabelOfTextStyleLabel() -> () {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainLabel)
        self.addConstraintOfTextStyleLabel()
    }
    
    //MARK:给纯文字风格下的toast的label添加约束
    private func addConstraintOfTextStyleLabel() -> () {
        
        //上边约束
        let topConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: DefaultMargin)
        mainLabel.superview?.addConstraint(topConstrain) //父视图添加约束
        
        //左边约束
        let leftConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: DefaultMargin)
        mainLabel.superview?.addConstraint(leftConstrain) //父视图添加约束
        
        //下边约束
        let bottomConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: DefaultMargin * -1)
        mainLabel.superview?.addConstraint(bottomConstrain) //父视图添加约束
        
        //右边约束
        let rightConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: DefaultMargin * -1)
        mainLabel.superview?.addConstraint(rightConstrain) //父视图添加约束
        
    }
    
    //MARK:给左边图片右边文字风格下的toast添加imageview
    private func addMainImageViewOfLeftImageAndText() -> () {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageView)
        self.addConstraintToMainImageViewOfLeftImageAndText()
    }
    
    //MARK:给左边图片右边文字风格下的toast的imageview添加约束
    private func addConstraintToMainImageViewOfLeftImageAndText() -> () {
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //左边约束
        let leftConstrain = NSLayoutConstraint.init(item: mainImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: DefaultMargin)
        mainImageView.superview?.addConstraint(leftConstrain) //父视图添加约束
        
        //竖直方向的约束
        let centerY = NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        mainImageView.superview?.addConstraint(centerY) //父视图添加约束
        
        let hConstrain = NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: DefaultHeightOfImage)
        mainImageView.addConstraint(hConstrain)
        
        let wConstraib = NSLayoutConstraint.init(item: mainImageView, attribute: .width, relatedBy: .equal, toItem: mainImageView, attribute: .height, multiplier: 1.0, constant: 0)
        mainImageView.addConstraint(wConstraib)
    }
    
    //MARK:给左边图片右边文字风格下的toast添加label
    private func addMainLabelOfLeftImageAndText() -> () {
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainLabel)
        self.addConstraintToMainLabelOfLeftImageAndText()
    }
    
    //MARK:给左边图片右边文字风格下的toast的label添加约束
    private func addConstraintToMainLabelOfLeftImageAndText() -> () {
        
        //上边约束
        let topConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: DefaultMargin)
        mainLabel.superview?.addConstraint(topConstrain) //父视图添加约束
        
        //左边约束
        let leftConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .leading, relatedBy: .equal, toItem: mainImageView, attribute: .trailing, multiplier: 1.0, constant: DefaultSpace)
        mainLabel.superview?.addConstraint(leftConstrain) //父视图添加约束
        
        //下边约束
        let bottomConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: DefaultMargin * -1)
        mainLabel.superview?.addConstraint(bottomConstrain) //父视图添加约束
        
        //右边约束
        let rightConstrain = NSLayoutConstraint.init(item: mainLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: DefaultMargin * -1)
        mainLabel.superview?.addConstraint(rightConstrain) //父视图添加约束
        
    }
    
    //MARK:设置单行文字内容
    private func setSingleLineText(texts:[String]) -> () {
        self.mainLabel.font = UIFont.systemFont(ofSize: 13)
        self.mainLabel.numberOfLines = 1
        self.mainLabel.textColor = DefaultTextColor
        self.mainLabel.text = texts[0]
        self.mainLabel.sizeToFit()
    }
    
    //MARK:设置多行文字内容
    private func setMultipleLinesText(texts:[String]) -> () {
        self.mainLabel.font = UIFont.systemFont(ofSize: 13)
        self.mainLabel.numberOfLines = 0
        self.mainLabel.textColor = DefaultTextColor
        var content:String = ""
        for (index , value) in texts.enumerated() {
            if index == 0 {
                content.append(value)
            }else{
                content.append("\n\(value)")
            }
        }
        self.mainLabel.text = content
        self.mainLabel.sizeToFit()
    }
    
    //MARK:不是纯文字风格下却没有没有给图片的情况下更新约束
    private func updateConstraintsOfOtherViewIsNuil() -> () {
        self.addConstraintOfTextStyleLabel()
    }
    
    //MARK:展示
    public func show(){
        self.addSelfToMainView()
        weak var weakSelf = self
        UIView.animate(withDuration: self.duration, animations: {
            weakSelf?.alpha = DefaultAlpha
        }, completion: {(compled:Bool) in
            weakSelf?.dissmiss()
        })
    }
    
    //MARK:把吐司添加到window上
    private func addSelfToMainView(){
        if (self.style == .leftImageAndText && self.image == nil) {
            //更新约束
            self.updateConstraintsOfOtherViewIsNuil()
        }
        superView = DeciceHelper.getMainView()
        superView.addSubview(self)
        self.addConstraintToSelf()
    }
    
    //MARK:给吐司添加约束
    private func addConstraintToSelf(){
        switch self.longitudinalPosition {
        case .center:
            //竖直方向的约束
            let centerY = NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superView, attribute: .centerY, multiplier: 1.0, constant: 0)
            self.superView?.addConstraint(centerY) //父视图添加约束
        case .bottom:
            //下边约束
            let bottomConstrain = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superView, attribute: .bottom, multiplier: 1.0, constant: DefaultBottomMargin * -1)
            self.superView.addConstraint(bottomConstrain) //父视图添加约束
        case .top:
            //上边约束
            let topConstrain = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.superView, attribute: .top, multiplier: 1.0, constant: DefaultTopMargin)
            self.superView.addConstraint(topConstrain) //父视图添加约束
        }
        
        //水平方向的约束
        let centerX = NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superView, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.superView?.addConstraint(centerX) //父视图添加约束
        
        //宽度的约束
        let wConstraint = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self.superView, attribute: .width, multiplier: 1.0, constant: DefaultMargin * -1)
        self.superView.addConstraint(wConstraint)
        
        //高度的约束
        let hConstraint = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self.superView, attribute: .height, multiplier: 1.0, constant: (DefaultTopMargin + DefaultBottomMargin) * -1)
        self.superView.addConstraint(hConstraint)
        
    }
    
    //MARK:消失
    public func dissmiss(){
        weak var weakSelf = self
        UIView.animate(withDuration: self.duration * 0.1, animations: {
            weakSelf?.alpha = DefaultDissmissAlpha
        }, completion: {(compled:Bool) in
            weakSelf?.removeSelfFromMainView()
        })
    }
    
    //MARK:移除所有子视图
    private func removeSelfFromMainView(){
        for (_,value) in self.subviews.enumerated() {
            value.removeFromSuperview()
        }
        self.removeFromSuperview()
    }
    
    
}

