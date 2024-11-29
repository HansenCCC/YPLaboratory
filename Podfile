platform :ios, '12.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'YPLaboratory' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YPLaboratory

  use_frameworks!
  
  pod 'YPUIKit-ObjC', :git => 'https://github.com/HansenCCC/YPUIKit-ObjC.git', :branch => 'master'
  pod 'LookinServer', :configurations => ['Debug']
  pod 'MJRefresh', '3.7.5'
  pod 'AFNetworking', '4.0.1'
  pod 'MJExtension', '3.4.1'
  pod 'SDWebImage', '5.15.6'
  pod 'FLAnimatedImage', '1.0.17'
  pod 'Bugly', '2.5.93'
  pod 'Masonry', '1.1.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
            end
            config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
        end
    end
end
