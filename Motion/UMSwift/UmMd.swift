//
//  UmMd.swift
//  TimeMachine
//
//  Created by Liseami on 2021/10/2.
//

import Foundation


class UmMd {
    
    
    static let share = UmMd()
    enum MDtype {
        
        case Add(things)
        case Delet(things)
        case Edit(things)
        enum things {
            case friend
            case enent
            case tag
        }
    }
    
    public func MD(type : MDtype){
        DispatchQueue.global().async {
            switch type {
            case .Add(let things):
                //        let trackname = "添加"
                
                switch things {
                case .friend :
                    //UMAnalyticsSwift.event(eventId: "1", attributes: Dictionary<String, Any>)
                    UMAnalyticsSwift.event(eventId: "1")
                    print("添加人物")
                case .enent :
                    //UMAnalyticsSwift.event(eventId: "1", attributes: <#T##Dictionary<String, Any>#>)
                    //UMAnalyticsSwift.event(eventId: "2")
                    print("添加事件")
                case .tag :
                    
                    print("添加标签")
                }
            case .Delet(let things):
                switch things {
                case .friend :
                    
                    print("")
                case .enent :
                    print("")
                case .tag :
                    print("")
                }
            case .Edit(let things):
                switch things {
                case .friend :
                    
                    print("")
                case .enent :
                    print("")
                case .tag :
                    print("")
                }
            }
        }
    }
}
