#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint veridflutterplugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'veridflutterplugin'
  s.version          = '1.0.0'
  s.summary          = 'Ver-ID plugin for Applied Recognition platform.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://www.appliedrecognition.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Ver-ID' => 'plugins@appliedrec.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.3'
  s.dependency 'Ver-ID-UI', '~> 1.12.4'
  s.dependency 'Ver-ID-SDK-Identity', '~> 3.0.1'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
