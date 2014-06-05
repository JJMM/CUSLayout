Pod::Spec.new do |s| 
  s.name         = "CUSLayout"
  s.version      = "1.0.2"
  s.summary      = "iOS Auto Layout Manager."
  s.homepage     = "https://github.com/JJMM/CUSLayout"
  s.license      = "Apache License, Version 2.0"
  s.authors      = { "JJMM" => "CUSLayout@163.com" }
  s.source       = { :git => "https://github.com/JJMM/CUSLayout.git", :tag => "#{s.version}" }
  s.frameworks   = 'Foundation','UIKit','CoreGraphics'
  s.platform     = :ios

  s.requires_arc = true

  s.subspec 'core' do |ss|
    ss.source_files = 'CUSLayout/core/*'
  end
  
  s.subspec 'algorithm' do |ss|
    ss.dependency 'CUSLayout/core'
    ss.source_files = 'CUSLayout/algorithm/*'
  end
  
  s.subspec 'extend' do |ss|
    ss.dependency 'CUSLayout/core'
    ss.dependency 'CUSLayout/algorithm'
    ss.source_files = 'CUSLayout/extend/*'
  end
  
  s.subspec 'util' do |ss|
    ss.dependency 'CUSLayout/core'
    ss.dependency 'CUSLayout/algorithm'
    ss.source_files = 'CUSLayout/util/*'
  end
end

