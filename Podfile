# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Avatar world city life mod' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Applio'
  pod 'Blurberry'
  pod 'MBProgressHUD'
  pod 'RealmSwift'
  pod 'Realm'
  pod 'SwiftyDropbox'
  pod 'IQKeyboardManager'
  pod 'lottie-ios'
  pod 'ReachabilitySwift'
  pod 'SnapKit'

  # Pods for Avatar world city life mod

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
#        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        
      end
  end
end
