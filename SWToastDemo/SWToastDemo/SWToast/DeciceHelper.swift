//
//  DeciceHelper.swift
//  support
//
//  Created by SevenWang on 2017/1/24.
//  Copyright © 2017年 SevenWang. All rights reserved.
//

import UIKit

class DeciceHelper: NSObject {
    static func getMainView() -> UIView
    {
        var window = UIApplication.shared.keyWindow
        if (window == nil)
        {
            window = UIApplication.shared.windows[0]
            if (window == nil){
                window = (UIApplication.shared.delegate?.window)!
            }else{
                if (window?.subviews != nil && (window?.subviews.count)! > 0) {
                    return (window?.subviews[0])!
                }else{
                    window = (UIApplication.shared.delegate?.window)!
                }
            }
        }
        return window!
    }
}

