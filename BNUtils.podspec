Pod::Spec.new do |s|

  s.name         = "BNUtils"
  s.version      = "1.2.4"
  s.summary      = "BNUtils是一个项目模板开发工具包"
  s.description  = "BNUtils是一个项目模板开发工具包,包含了一些控件封装，工具类等，可加快开发速度。"

  s.homepage     = "https://github.com/shang1219178163/BNUtils"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "BIN" => "shang1219178163@gmail.com" }
  # s.social_media_url   = "http://twitter.com/BIN"

  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.source       = { :git => "https://github.com/shang1219178163/BNUtils.git", :tag => "#{s.version}" }

  s.source_files = 'BNUtils/*.{h,m}'
  # s.public_header_files = 'BNUtils/*.{h}'
  s.public_header_files = 'BNUtils/BNUtils.{h}'

  s.dependency 'BNKit'
  s.dependency 'BNGloble'
  s.dependency 'BNCategory'
  s.dependency 'BNCollectionView'
  s.dependency 'BNTableViewCell'
  s.dependency 'BNView'
  s.dependency 'BNViewHeight'


  s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage',
      'CoreLocation','CoreTelephony', 'GLKit','QuartzCore', 'ImageIO','Accelerate',
      'AssetsLibrary', 'MobileCoreServices', 'SystemConfiguration','ImageIO',
      'JavaScriptCore','WebKit'
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto"

  # s.resource  = "icon.png"
  # s.resources = "BNUtils/BNResources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }


end
