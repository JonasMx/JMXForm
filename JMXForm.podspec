Pod::Spec.new do |s|
  s.name = 'JMXForm'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Fork of Eureka Swift, the elegant iOS forms in pure Swift'
  s.homepage = 'https://github.com/JonasMx/JMXForm'
  s.authors = { 'Jonas Mahiques' => 'jonas.mahiques@gmail.com' }
  s.source = { :git => 'https://github.com/JonasMx/JMXForm', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source_files = 'Source/**/*.swift'
  s.resources = 'Source/Resources/JMXForm.bundle'
  s.requires_arc = true
  s.swift_version = '4.2'
end
