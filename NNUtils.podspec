Pod::Spec.new do |s|

  s.name         = "NNUtils"
  s.version      = "1.3.0"
  s.summary      = "NNUtils是一个项目模板开发组件集合"
  s.description  = "NNUtils是一个项目模板开发组件集合,包含了一些控件封装，工具类等，可提高App开发效率和质量。"

  s.homepage     = "https://github.com/shang1219178163/NNUtils"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "BIN" => "shang1219178163@gmail.com" }
  # s.social_media_url   = "http://twitter.com/BIN"

  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.source       = { :git => "https://github.com/shang1219178163/NNUtils.git", :tag => "#{s.version}" }

  s.source_files = 'NNUtils/*.{h,m}'
  # s.public_header_files = 'NNUtils/*.{h}'
  s.public_header_files = 'NNUtils/NNUtils.{h}'

  s.dependency 'NNGloble'
  s.dependency 'NNCategoryPro'
  s.dependency 'NNCollectionView'
  s.dependency 'NNTableViewCell'
  s.dependency 'NNView'
  s.dependency 'NNViewComplex'


  s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage',
      'CoreLocation','CoreTelephony', 'GLKit','QuartzCore', 'ImageIO','Accelerate',
      'AssetsLibrary', 'MobileCoreServices', 'SystemConfiguration','ImageIO',
      'JavaScriptCore','WebKit'
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto"

  # s.resource  = "icon.png"
  # s.resources = "NNUtils/NNResources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }


end
