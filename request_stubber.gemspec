# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{request_stubber}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eloy Duran"]
  s.date = %q{2009-08-28}
  s.description = %q{A simple Rails plugin to delay responses or return specific response codes. (Needs a new name.)}
  s.email = %q{eloy.de.enige@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "Rakefile",
    "VERSION.yml",
    "lib/request_stubber.rb",
    "rails/init.rb",
    "test/request_stubber_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Fingertips/request_stubber}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple Rails plugin to delay responses or return specific response codes. (Needs a new name.)}
  s.test_files = [
    "test/request_stubber_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
