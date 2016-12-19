#
#  Be sure to run `pod spec lint SimulateIDFA.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SimulateIDFA"
  s.version      = "0.0.1"
  s.summary      = "SimulateIDFA combine many device infos to create an ID that help disambiguate one device from another."
  s.homepage     = "https://github.com/youmi/SimulateIDFA"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform     = :ios, "6.0"
  s.ios.deployment_target =   "6.0"
  s.author       = { "umplus" => "sdk@youmi.net" }
  s.source       = { :git => "https://github.com/youmi/SimulateIDFA.git", :tag => "#{s.version}" }
  s.source_files = '*.{h,m}'
  s.frameworks   = 'CoreTelephony' 

end
