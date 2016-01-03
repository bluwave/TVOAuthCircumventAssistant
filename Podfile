xcodeproj 'TVOAuthCircumventAssistant/TVOAuthCircumventAssistant.xcodeproj'
use_frameworks!
workspace 'TVOAuthCircumventAssistant'

target 'TVOAuthCircumventAssistant', :exclusive => true do
	platform :tvos, '9.0'
    xcodeproj 'TVOAuthCircumventAssistant/TVOAuthCircumventAssistant'
    link_with 'TVOAuthCircumventAssistant'
	pod 'Alamofire', '~> 3.1'
end

target 'TVOAuthCircumventAssistantTests', :exclusive => true do
	platform :tvos, '9.0'
    xcodeproj 'TVOAuthCircumventAssistant/TVOAuthCircumventAssistant'
    link_with 'TVOAuthCircumventAssistantTests'
	pod 'Alamofire', '~> 3.1'
	pod 'OHHTTPStubs', '~> 4.7'
end
