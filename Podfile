# Uncomment the next line to define a global platform for your project
 platform :ios, '14.1'


target 'Motion' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


  pod 'MotionComponents', :path => './MotionComponents'

  pod 'lottie-ios'
  pod 'Introspect'
  pod 'Kingfisher',  '~> 6.3.1'

  pod 'UMCommon'
  pod 'UMDevice'
  pod 'UMCCommonLog'

end


post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[skd=iphonesimulator*]"] = "arm64"
    end
end
