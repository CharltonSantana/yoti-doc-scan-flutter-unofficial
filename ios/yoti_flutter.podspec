#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint yoti_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'yoti_flutter'
  s.version          = '0.0.7'
  s.summary          = 'Flutter plugin to dridge to Yoti native SDKS..'
  s.description      = <<-DESC
  Flutter plugin to dridge to Yoti native SDKS..
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Charlton Santana' => 'me@charltonsantana.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'YotiSDKIdentityDocument'
  s.dependency 'YotiSDKDocument'
  s.dependency 'YotiSDKFaceTec'
  s.dependency 'YotiSDKFaceCapture'
  
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
