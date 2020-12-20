# typed: ignore
# typed: ignore
# typed: true
module Nokogiri
  module XML
    class CDATA < Nokogiri::XML::Text
      ###
      # Get the name of this CDATA node
      def name
        '#cdata-section'
      end
    end
  end
end
