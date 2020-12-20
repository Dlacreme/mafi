# -*- encoding: utf-8 -*-
# stub: reform-rails 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "reform-rails".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2020-11-16"
  s.description = "Automatically load and include all common Reform features for a standard Rails environment.".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "https://github.com/trailblazer/reform-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Automatically load and include all common Rails form features.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<reform>.freeze, [">= 2.3.1", "< 3.0.0"])
    s.add_runtime_dependency(%q<activemodel>.freeze, [">= 5.0"])
  else
    s.add_dependency(%q<reform>.freeze, [">= 2.3.1", "< 3.0.0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 5.0"])
  end
end
