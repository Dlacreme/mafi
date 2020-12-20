# typed: ignore
# typed: ignore
# frozen_string_literal: true

require "action_view/template/resolver"

module ActionView #:nodoc:
  # Use FixtureResolver in your tests to simulate the presence of files on the
  # file system. This is used internally by Rails' own test suite, and is
  # useful for testing extensions that have no way of knowing what the file
  # system will look like at runtime.
  class FixtureResolver < OptimizedFileSystemResolver
    def initialize(hash = {})
      super("")
      @hash = hash
      @path = ""
    end

    def data
      @hash
    end

    def to_s
      @hash.keys.join(", ")
    end

    private
      def find_candidate_template_paths(path)
        @hash.keys.select do |fixture|
          fixture.start_with?(path.virtual)
        end.map do |fixture|
          "/#{fixture}"
        end
      end

      def source_for_template(template)
        @hash[template[1..template.size]]
      end
  end

  class NullResolver < PathResolver
    def query(path, exts, _, locals, cache:)
      handler, format, variant = extract_handler_and_format_and_variant(path)
      [ActionView::Template.new("Template generated by Null Resolver", path.virtual, handler, virtual_path: path.virtual, format: format, variant: variant, locals: locals)]
    end
  end
end
