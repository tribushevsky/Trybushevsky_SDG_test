platform :ios, '11.0'

target 'Trybushevsky_SDG_test' do
  use_modular_headers!
  
  pod 'RxSwift', '= 6.1'
  pod 'RxCocoa', '= 6.1'
  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
                        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
          end
        end
        
        if ['TapticEngine'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
 end
