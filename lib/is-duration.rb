# frozen_string_literal: true

require_relative 'is-duration/info'

module IS::Duration

  class << self

    # @group Singleton Interface

    # @param [String, nil] source
    # @return [Numeric, nil]
    def parse source
      # TODO: implement
    end

    # @param [Numeric, nil] value
    # @param [Boolean] leading_zeroes
    # @param [Symbol, nil] fractional
    #   `:ms`, `:us`, `:ns` or `nil`
    # @return [String, nil]
    def format value, leading_zeroes: true, fractional: nil
      # TODO: implement
    end

    # @endgroup

    private

    # @private
    def parse_string source
      # TODO: implement
    end

  end

  # @group Include Interface

  # @see .parse
  # @param [String, nil] source
  # @return [Numeric, nil]
  def parse_duration(source) = self.class.parse(source)

  # @see .format
  # @param [Numeric, nil] value
  # @param [Boolean] leading_zeroes
  # @param [Symbol, nil] fractional
  # @return [String, nil]  
  def format_duration(value, leading_zeroes: true, fractional: nil) = self.class.format(value, leading_zeroes: leading_zeroes, fractional: fractional)

  private :parse_duration, :format_duration

  # @endgroup
end
