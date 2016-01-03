Pod::Spec.new do |s|
  s.name             = "TVOAuthCircumventAssistant"
  s.version          = "0.1.0"
  s.summary          = "Set of tools to help with OAuth authentication on tvOS"
  s.homepage         = "https://github.com/bluwave/TVOAuthCircumventAssistant"
  s.license          = 'MIT'
  s.author           = { "G Richards" => "tvoauthcircumventassistant@gmail.com" }
  s.source           = { :git => "https://github.com/bluwave/TVOAuthCircumventAssistant.git", :tag => s.version.to_s }
  s.platform     	 = :tvos, '9.0'
  s.requires_arc 	 = true
  s.source_files = 'Source/*.{h,m,swift}'
  s.dependency 'Alamofire', '~> 3.1'
end
