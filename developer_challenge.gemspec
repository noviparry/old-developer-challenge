# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "developer_challenge"
  spec.version       = "1.0"
  spec.authors       = ["Parry"]
  spec.email         = ["parry.my@gmail.com"]

  spec.summary       = 'Code test for NoviCap'
  spec.description   = 'https://github.com/noverloop/challenge'
  spec.homepage      = "https://github.com/parrydotmy/developer_challenge"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ''
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.executables << 'developer_challenge'

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec",  "~> 2.0", ">= 2.0.0"
end
