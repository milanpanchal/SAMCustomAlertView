Pod::Spec.new do |s|
  s.name         = "SAMAlertView"
  s.version      = "1.0.0"
  s.summary      = "To show custom alertview on UIView/UIWindow"
  s.description  = <<-DESC
                   To show custom alertview on UIView/UIWindow. You can also specify the alert button alignment(Horizontal or vertical)
				   It is recommended to use vertical alignment for more than 3 buttons or title is long
                   DESC

  s.homepage     = "https://github.com/milanpanchal/"
  s.screenshots  = "https://raw.github.com/milanpanchal/SAMCustomAlertView/master/Screenshots/horizontal_alert.png","https://raw.github.com/milanpanchal/SAMCustomAlertView/master/Screenshots/vertical_alert.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Milan Panchal' => 'sam07it22@gmail.com' }
  s.social_media_url   = "http://twitter.com/milan_panchal24"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/milanpanchal/SAMCustomAlertView.git", :tag => s.version.to_s }
  s.source_files = "Source"
  s.resources	 = "Resources"
  s.requires_arc = true
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end
