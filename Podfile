platform :ios, '13.0'

target 'MeetPAT' do

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MeetPAT

  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Storage'
  pod 'IQKeyboardManagerSwift'

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end
