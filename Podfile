source 'https://github.com/CocoaPods/Specs.git'
source 'git@gitlab.tech.lastmile.com:ios/private-pods.git'

platform :ios, '8.0'

use_frameworks!

pod 'Blockly', '0.1.0-beta'
pod 'SnapKit', '~> 0.12'
pod 'SwiftyJSON', '~> 2.2.0'
pod 'Alamofire', '~> 1.2'

target 'codeforlife-iosTests' do
    pod 'KIF', '~> 3.0', :configurations => ['Debug']
    pod 'Quick', '~> 0.3.0'
    pod 'Nimble', '~> 1.0.0'
end

link_with "codeforlife-ios"
link_with "codeforlife-iosTests"