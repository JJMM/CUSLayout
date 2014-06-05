Pod::Spec.new do |s| 
  s.name         = "CUSLayout"
  s.version      = "1.0.2"
  s.summary      = "iOS Auto Layout Manager."
  s.homepage     = "https://github.com/JJMM/CUSLayout"
  s.license      = "Apache License, Version 2.0"
  s.authors      = { "JJMM" => "CUSLayout@163.com" }
  s.source       = { :git => "https://github.com/JJMM/CUSLayout.git", :tag => "#{s.version}" }
  s.frameworks   = 'Foundation','UIKit'
  s.platform     = :ios, '5.0'
  s.source_files = 'CUSLayout/*'
  s.source_files = 'CUSLayout/core/*'
  s.source_files = 'CUSLayout/algorithm/*'
  s.source_files = 'CUSLayout/extend/*'
  s.requires_arc = true
end
