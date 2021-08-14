//
//  Extensions.swift
//  Instagram
//
//  Created by JI XIANG on 13/8/21.
//

import UIKit

extension UIView {
    //use these to easily set up and layout your View 
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    public var left: CGFloat {
        return frame.origin.x
    }
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension String {
    func safeDatabaseKey() -> String { //Now any string class can call this function
        return self.replacingOccurrences(of: ".", with: "-").self.replacingOccurrences(of: "@", with: "-")
        //replace all the full stop with dash
        //replace all the @ with dash
    }
}
