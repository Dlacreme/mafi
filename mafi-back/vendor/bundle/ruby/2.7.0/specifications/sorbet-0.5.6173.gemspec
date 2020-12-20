# -*- encoding: utf-8 -*-
# stub: sorbet 0.5.6173 ruby lib

Gem::Specification.new do |s|
  s.name = "sorbet".freeze
  s.version = "0.5.6173"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "source_code_uri" => "https://github.com/sorbet/sorbet" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stripe".freeze]
  s.date = "2020-12-19"
  s.description = "The main entrypoint for using Sorbet".freeze
  s.email = "sorbet@stripe.com".freeze
  s.executables = ["srb-rbi".freeze, "srb".freeze]
  s.files = ["bin/srb".freeze, "bin/srb-rbi".freeze]
  s.homepage = "https://sorbet.run".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.post_install_message = "\n  Thanks for installing Sorbet! To use it in your project, first run:\n\n    bundle exec srb init\n\n  which will get your project ready to use with Sorbet.\n  After that whenever you want to typecheck your code, run:\n\n    bundle exec srb tc\n\n  For more docs see: https://sorbet.org/docs/adopting\n".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A Typechecker for Ruby".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<sorbet-static>.freeze, ["= 0.5.6173"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.11"])
    s.add_development_dependency(%q<mocha>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<sorbet-static>.freeze, ["= 0.5.6173"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.11"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
