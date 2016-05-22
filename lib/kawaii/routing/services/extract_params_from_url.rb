module Kawaii
  module Routing
    module Services
      class ExtractParamsFromUrl
        def call(path_pattern, url)
          regexp  = pattern_to_regexp(path_pattern)
          matches = regexp.match(url)
          format_to_hash(matches)
        end

        private

        def format_to_hash(matches)
          Hash[matches.names.zip(matches[1..-1])]
        end

        def pattern_to_regexp(pattern)
          Regexp.new(format_pattern(pattern))
        end

        def format_pattern(pattern)
          Regexp.escape(pattern).gsub(regexp, replacement)
        end

        def regexp
          /:(\w+)/
        end

        def replacement
          '(?<\1>.+?)'
        end
      end
    end
  end
end
