# typed: ignore
# typed: ignore
# typed: false
# frozen_string_literal: true

require 'rack/handler/puma'

module Rack::Handler
  def self.default(options = {})
    Rack::Handler::Puma
  end
end
