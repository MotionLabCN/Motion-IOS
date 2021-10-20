//
//  mt+Image.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/7.
//

import SwiftUI

extension Image: MTCompatible {
    private func using() {
        _ = Image.mt.load(.Logo)
        _ = Image.mt.load(.Add_circle)
    }
}

//private extension Image {
//    static func source(_ source: MTImageSource) -> Image {
//        Image(source.named)
//    }
//}

public extension MT where Base == Image {
    /// 优先使用 load()
    static func load(_ source: MTImageSource) -> Image {  source.value }
    
    
    static func load(_ source: MTActionIcon) -> Image { source.value }
    static func load(_ source: MTAlertIcon) -> Image { source.value }
    static func load(_ source: MTContentIcon) -> Image { source.value }
    static func load(_ source: MTFinancialIcon) -> Image { source.value }
    static func load(_ source: MTGeneralIcon) -> Image { source.value }
    static func load(_ source: MTMapIcon) -> Image { source.value }
    static func load(_ source: MTNavigationIcon) -> Image { source.value }
    static func load(_ source: MTSocialIcon) -> Image { source.value }
    static func load(_ source: MTDiskIcon) -> Image { source.value }

    
//    static func load(_ source: MTToggleIcon) -> Image { source.value }
    
    static var backImage: Image {
        Image.mt.load(.Chevron_left_On)
//            .renderingMode(.original)
        
    }
}


//MARK: - Image
public protocol MTImageSource {
    var id: String { get }
    var named: String { get }
    var value: Image { get }
}

public extension MTImageSource {
    var id: String { named }
    var value: Image { Image(named).renderingMode(.template) }
    
}

//MARK: - 资源
public enum MTActionIcon: String, CaseIterable, MTImageSource {
    case Add_circle, Bookmark_outline, Bookmark, Build, Cached, Dictation_mic, Done_circle_inactive, Done_circle_outline, Done_circle, Done, Drag_handle, FaceID, Favorites_outline, Favorites, Info_outline, Info, More_outline, More, Plus_outline, Remove, Search, Send_outline, Send, Setting, Visibility_Status_Off, Visibility_Status_On,Comment
    
    public var named: String { rawValue }
}

public enum MTAlertIcon: String, CaseIterable, MTImageSource {
    case Error_outline, Error, Notification_important
    
    public var named: String { rawValue }
}

public enum MTContentIcon: String, CaseIterable, MTImageSource {
    case Add, Copy, Create, Filter_list, Link
    
    public var named: String { rawValue }
}

public enum MTDiskIcon: String, CaseIterable, MTImageSource {
    case Box,Dial_numbers,Group_folders,Selected_file,Money
    
    public var named: String { rawValue }
}

public enum MTFinancialIcon: String, CaseIterable, MTImageSource {
    case ATM, Bank_building, Banknote, Bitcoin, Credit_card, Development, Dicussion, Discount_percent, Doller, Euro, Exchange, Graph, Penny, Pie_chart, Piggy_bank, Pound, Price_tag, Reciept, Savings_bag, Shopper_bag, Transaction, Wallet, Yen
    
    public var named: String { rawValue }
}




public enum MTGeneralIcon: String, CaseIterable, MTImageSource {
    case Cart, Chat, Group, Home, Logo, Mail, Person, Trash
    
    public var named: String { rawValue }
}


public enum MTMapIcon: String, CaseIterable, MTImageSource {
    case Map_default, Map_place
    
    public var named: String { rawValue }
}


public enum MTNavigationIcon: String, CaseIterable, MTImageSource {
    case Apps, Arrow_dropdown_circle, Arrow_dropdown, Arrow_dropup, Arrow_left, Arrow_right, Chevron_left_Off, Chevron_left_On, Chevron_right_Off, Chevron_right_On, Close_circle, Close, Expand_less_Off, Expand_less_On, Expand_more_Off, Expand_more_On, Fullscreen_exit, Fullscreen, Line, Menu, More_horiz, More_vert
    
    public var named: String { rawValue }
}


public enum MTSocialIcon: String, CaseIterable, MTImageSource {
    case Github, Notifications_outline, Notifications, Share_Android, Share_iOS
    
    public var named: String { rawValue }
}




//public enum MTToggleIcon: String, CaseIterable, MTImageSource {
//    case Map_default, Map_place
//
//    public var named: String { rawValue }
//}


//MARK: - 扩展
public extension Image {
    @ViewBuilder
    func mtSize(_ size: CGFloat, foregroundColor: Color? = nil) -> some View {
        if let foregroundColor = foregroundColor {
            resizable()
                .foregroundColor(foregroundColor)
                .frame(width: size, height: size)
        } else {
            resizable()
                .frame(width: size, height: size)
        }
        
    }
}



