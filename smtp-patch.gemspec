
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smtp/patch/version"

Gem::Specification.new do |spec|
  spec.name          = "smtp-patch"
  spec.version       = SmtpPatch::VERSION
  spec.authors       = ["Charles Koyeung"]
  spec.email         = ["cenxky@gmail.com"]

  spec.summary       = "Enhance Ruby net/smtp library to support never interrupted by errors while mail sending to multiple receptions."
  spec.description   = "Enhance Ruby net/smtp library to support never interrupted by errors while mail sending to multiple receptions."
  spec.homepage      = "https://github.com/cenxky/smtp-patch"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
