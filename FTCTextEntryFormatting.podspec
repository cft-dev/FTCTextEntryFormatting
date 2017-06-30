Pod::Spec.new do |spec|

  spec.name         = 'FTCTextEntryFormatting'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'FTC' }
  spec.homepage     = 'https://stash.ftc.ru/projects/UPCMC/repos/ftctextentryformatting/browse'
  spec.authors      = { 'Denis Morozov' => 'd.morozov@ftc.ru' }
  spec.summary      = 'Text Entry Formatting.'
  spec.source       = { :git => 'https://stash.ftc.ru/scm/upcmc/ftctextentryformatting.git', :tag => '1.0.0' }

  spec.source_files         = 'Src/**/*.{h,m}'
  spec.private_header_files = 'Src/Categories/*.h', 'Src/Tools/*.h'

  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
end
