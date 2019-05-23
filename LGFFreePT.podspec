
Pod::Spec.new do |s|

s.name        = "LGFFreePT"
s.version     = "0.1.3"
s.summary     = "LGFFreePT"
s.homepage    = "https://github.com/aiononhiii/LGFFreePT.git"
s.license     = { :type => 'MIT', :file => 'LICENSE' }
s.authors     = { "aiononhiii" => "452354033@qq.com" }

s.requires_arc = true
s.platform     = :ios, "8.0"
s.source   = { :git => "https://github.com/aiononhiii/LGFFreePT.git", :tag => s.version }
s.framework  = "UIKit"
s.source_files = 'LGFFreePT/*.{h,m}'
s.resource_bundles = {
  'LGFFreePT' => ['LGFFreePT/*.{xib,storyboard,png}']
}
s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end
