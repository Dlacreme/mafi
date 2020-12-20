# typed: ignore
# typed: ignore
# typed: strict
# frozen_string_literal: true

require "rake"

# Load Rails Rakefile extensions
%w(
  framework
  log
  middleware
  misc
  restart
  tmp
  yarn
  zeitwerk
).tap { |arr|
  arr << "statistics" if Rake.application.current_scope.empty?
}.each do |task|
  load "rails/tasks/#{task}.rake"
end
