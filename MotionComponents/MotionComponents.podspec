#
# Be sure to run `pod lib lint MotionComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 框架的名称
  s.name             = 'MotionComponents'
  # 框架的版本号
  s.version          = '0.1.0'
  # 框架的简单介绍
  s.summary          = '天天数链SwiftUI组件'

  # 框架的详细描述(详细介绍，要比简介长)
  s.description      = <<-DESC
                      天天数连组件：
                      分类扩展
                       DESC
  # 框架的主页
  s.homepage         = 'https://github.com/LZRight123/MotionComponents'

  # 证书类型
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '快乐的小梁同学' => '350442340@qq.com' }
  s.source           = {
    :git => 'https://github.com/LZRight123/MotionComponents.git',
    :tag => s.version.to_s,
    :submodules => true
  }

  s.ios.deployment_target = '14.0'

  s.swift_version = '5.3'
  # s.frameworks = 'Combine', 'SwiftUI'
  # 框架要求ARC环境下使用
  s.requires_arc = true
  
  # 每次都参与编译方便修改时
  s.static_framework = true
  
  # 设置 podspec 的默认 subspec
  s.default_subspecs = 'Extensions', 'Networking', 'Tools'
  
  # 二级目录（根目录是s，使用s.subspec设置子目录，这里设置子目录为ss）
  s.subspec 'Extensions' do |ss|
    ss.source_files = 'MotionComponents/Extensions/**/*.swift'
    # 框架包含的资源包
    # ss.resources  = 'MotionComponents/MotionComponents/MotionComponents.bundle'
    ss.dependency "SwifterSwift/SwiftStdlib"
    ss.dependency "SwifterSwift/Foundation"
    ss.dependency "SwifterSwift/Dispatch"
  end
  
  
  # 网络请求 数据解析
  s.subspec 'Networking' do |ss|
    ss.source_files = 'MotionComponents/Networking/**/*.swift'

#    ss.dependency "Moya"
    ss.dependency "Moya/Combine", '~> 15.0'
    ss.dependency "KakaJSON"
    ss.dependency "SwiftyJSON"
  end
  
  s.subspec 'Tools' do |ss|
    ss.source_files = 'MotionComponents/Tools/**/*.swift'
    
    ss.dependency "MotionComponents/Extensions"
  end
  
end
