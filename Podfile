
# platform :ios, '9.0'
inhibit_all_warnings!

target 'QMKKXProduct' do
  use_frameworks!
  pod 'AFNetworking', '4.0.1'
  pod 'SDWebImage', '4.4.8'
  pod 'SDWebImage/GIF', '4.4.8'
  pod 'MJRefresh','3.5.0'
  pod 'MJExtension', '3.2.4'
  pod 'Masonry', '1.1.0'
  pod 'IQKeyboardManager', '6.5.6'#键盘遮挡问题
  pod 'TZImagePickerController', '3.5.8'#图片选择容器，用于用户反馈
  pod 'MBProgressHUD', '1.2.0'
  pod 'lottie-ios','2.5.3'
  pod 'Bugly','2.5.5'#bug反馈
  pod 'JCore','2.1.4-noidfa'
  pod 'JPush','3.2.4-noidfa'
  pod 'FMDB' , '2.7.2'
  
  #高德地图
  pod 'AMapSearch', '7.1.0'
  pod 'AMap2DMap', '5.6.1'
#  pod 'AMap3DMap' 使用起来内存过大，放弃使用
  pod 'AMapLocation', '2.6.4'
  pod 'AMapFoundation', '1.6.2'
end

target 'QMKKXProductDev' do
  use_frameworks!
  pod 'AFNetworking', '4.0.1'
  pod 'SDWebImage', '4.4.8'
  pod 'SDWebImage/GIF', '4.4.8'
  pod 'MJRefresh','3.5.0'
  pod 'MJExtension', '3.2.4'
  pod 'Masonry', '1.1.0'
  pod 'IQKeyboardManager', '6.5.6'#键盘遮挡问题
  pod 'TZImagePickerController', '3.5.8'#图片选择容器，用于用户反馈
  pod 'MBProgressHUD', '1.2.0'
  pod 'lottie-ios','2.5.3'
  pod 'Bugly','2.5.5'#bug反馈
  pod 'JCore','2.1.4-noidfa'
  pod 'JPush','3.2.4-noidfa'
  pod 'FMDB' , '2.7.2'
  
  #高德地图
  pod 'AMapSearch', '7.1.0'
  pod 'AMap2DMap', '5.6.1'
#  pod 'AMap3DMap' 使用起来内存过大，放弃使用
  pod 'AMapLocation', '2.6.4'
  pod 'AMapFoundation', '1.6.2'
end

#消除waring
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end
