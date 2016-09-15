# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blog_refactor_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "blog_refactor_gem"
  spec.version       = BlogRefactorGem::VERSION
  spec.authors       = ["Jeffrey Dugas"]
  spec.email         = ["jedugas@gmail.com"]

  spec.summary       = %q{Accompanies Stelligent blog posts.}
  spec.description   = %q{Used by blog_refactor_php and blog_refactor_nodejs for phase2 blog post.}
  spec.homepage      = "https://github.com/stelligent/blog_refactor_gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  include_files = []
  Dir[File.join(".", "lib/**/*.rb")].each do |f|
    include_files.push(f)
  end
  spec.require_paths = include_files

  spec.add_runtime_dependency "rake", "~> 10.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
