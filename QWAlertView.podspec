
Pod::Spec.new do |s|
  s.name             = 'QWAlertView'
  s.version          = '0.1.0'
  s.summary          = '一个封装的弹窗'
  s.description      = '简单的一个弹窗 只负责弹出和移除 5种弹出方式 内容自己定'
  s.homepage         = 'https://github.com/qingweiiOS/QWAlerView.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qingweiiOS' => '772053795@qq.com' }
  s.source           = { :git => 'https://github.com/qingweiiOS/QWAlerView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'QWAlertView/*.{h,m}'
  s.resources    = 'QWAlertView/QWAlertView.bundle'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
