Pod::Spec.new do |spec|

  spec.name         = 'FTCTextEntryFormatting'
  spec.version      = '1.0.5'
  spec.license      = { :type => 'FTC' }
  spec.homepage     = 'https://github.com/cft-dev/FTCTextEntryFormatting'
  spec.authors      = { 'Denis Morozov' => 'd.morozov@ftc.ru' }
  spec.summary      = 'Text Entry Formatting.'
  spec.source       = { :git => 'https://github.com/cft-dev/FTCTextEntryFormatting.git', :tag => '1.0.5' }

  spec.prefix_header_contents = '@import Foundation;'
  spec.source_files         = 'Src/**/*.{h,m}'
  spec.private_header_files = 'Src/Categories/*.h', 'Src/Tools/*.h'

  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'

  spec.test_spec 'UnitTests' do |test_spec|
    test_spec.source_files = 'UnitTests/**/*.{h,m}'
  end
end
