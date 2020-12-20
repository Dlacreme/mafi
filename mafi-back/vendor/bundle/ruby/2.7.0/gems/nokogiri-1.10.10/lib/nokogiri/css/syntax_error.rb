# typed: ignore
# typed: ignore
# typed: strict
require 'nokogiri/syntax_error'
module Nokogiri
  module CSS
    class SyntaxError < ::Nokogiri::SyntaxError
    end
  end
end
