Gem::Specification.new do |s|
  s.name            = 'twine-flutter'
  s.version         = '0.1.0'
  s.date            = '2022-08-24'
  s.license         = 'BSD-3-Clause'
  s.summary         = 'Plugin for twine that enables .arb generation for use with Flutter'
  s.description     = s.summary + '.'
  s.authors         = ['Fabio Butti']
  s.email           = ['butti.fabio@tiknil.com']
  s.homepage        = 'https://github.com/tiknil/twine-flutter'

  s.required_ruby_version   = '>= 2.4'

  s.files           = ["README.md", "LICENSE"]
  s.files          += Dir.glob("lib/**/*")
  s.files          += Dir.glob("bin/**/*")
  s.files          += Dir.glob("test/**/*")
  s.test_files      = Dir.glob("test/test_*")

  s.add_runtime_dependency 'twine', '~> 1.1.0'
end