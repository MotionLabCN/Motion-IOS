//
//  Swizzle.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/7.
//

open class Function {
    /// 方法交换
    open class func swizzled() {
//        UIViewController.doBadSwizzleStuff()
//        UINavigationController.doBadSwizzleStuff()
//        UIView.doBadSwizzleStuff()
//        UITableViewCell.doBadSwizzleStuff()
//        UICollectionViewCell.doBadSwizzleStuff()
//        UIControl.doBadSwizzleControl()
    }
    
    private init() { }
}

/// 方法交换，交换系统已有的方法
///
/// - Parameters:
///   - cls: 交换的类
///   - sels: 交换方法数组，原方法和新方法
public func swizzle<T: NSObject>(_ cls: T.Type, sels: [(Selector, Selector)]) {
    sels.forEach { original, swizzled in
        guard let originalMethod = class_getInstanceMethod(cls, original),
            let swizzledMethod = class_getInstanceMethod(cls, swizzled) else { return }
        
        let didAddViewDidLoadMethod = class_addMethod(
            cls,
            original,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddViewDidLoadMethod {
            class_replaceMethod(
                cls,
                swizzled,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

