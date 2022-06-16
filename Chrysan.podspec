Pod::Spec.new do |spec|
  spec.name          = 'Chrysan'
  spec.version       = '2.0.6'
  spec.license       = { :type => 'MIT' }
  spec.homepage      = 'https://github.com/Harley-xk/Chrysan'
  spec.authors       = { 'Harley-xk' => 'harley.gb@foxmail.com' }
  spec.summary       = 'A status indicator library (HUD) for UIKit'
  spec.source        = { :git => 'https://github.com/Harley-xk/Chrysan.git', :tag => spec.version }
  spec.module_name   = 'Chrysan'
  spec.swift_version = '5.3'

  spec.ios.deployment_target  = '11.0'

  spec.source_files       = 'Chrysan/Sources/**/*'
  spec.framework      = 'UIKit'
  spec.dependency 'SnapKit', '~> 5.0'
end
