# frozen_string_literal: true

require 'is-enum'

require_relative 'is-duration/info'

module IS::Duration

  class Unit < IS::Enum
    define :ns
    define :us
    define :ms
    define :s
    define :m
    define :h
    define :d
    define :w
  end

  class OnEmpty < IS::Enum
    define :force
    define :minor
    define :skip
  end

  class OnZero < IS::Enum
    define :fill
    define :align
    define :single
  end

  class OnMinus < IS::Enum
    define :ignore
    define :error
  end

  class << self

    # @group Singleton Interface

    # @param [String, nil] source
    # @return [Numeric, nil]
    def parse source
      case source
      when nil
        nil
      when Integer, Float
        source
      when Rational
        source.to_f
      when /^\d+$/
        source.to_i
      when /^\d*\.\d*$/
        source.to_f
      when /^(\d+(w|d|h|m|s|ms|us|ns)\s*)+$/
        parse_string source
      else
        raise ArgumentError, "Invalid source value: #{ source.inspect }", caller_locations
      end
    end



    # @param [Numeric, nil] value +Integer+ or +Float+, +Rational+ will be converted to +Float+
    # @param [Hash] opts
    # @option opts [Range<Unit|Symbol>] units _default:_ +(Unit.s .. Unit.d)+
    # @option opts [OnEmpty|Symbol] empty _default:_ +OnEmpty.skip+
    # @option opts [OnZero|Symbol] zeros _default:_ +OnZero.single+
    # @option opts [String] delim +""+ (empty string), +" "+ (space) or other, _default:_ +""+
    # @option opts [OnMinus|Symbol|String|Proc] minus _default:_ +OnMinus.ignore+
    # @return [String, nil]
    def format value, **opts
      return nil if value.nil?
      value = value.to_f if value.is_a?(Rational)
      raise ArgumentError, "Invalid source value: #{ value.inspect }", caller_locations unless value.is_a?(Integer) || value.is_a?(Float)
      units = Unit::from(opts[:units] || (:s .. :d))
      empty = OnEmpty::from(opts[:empty] || :skip)
      zeros = OnZero::from(opts[:zeros] || :single)
      delim = opts[:delim] || ''
      minus = case opts[:minus]
      when OnMinus, String, Proc
        opts[:minus]
      when Symbol
        OnMinus[opts[:minus]]
      when nil
        OnMinus.ignore
      else
        raise ArgumentError, "Invalid option 'minus': #{ opts.minus }", caller_locations
      end
      # TODO: implement
    end

    # @endgroup

    private

    # @private
    def parse_string source
      if source.nil? || source.empty? || source =~ /^(\d+(w|d|h|m|s|ms|us|ns)\s*)+$/
        raise ArgumentError, "Invalid source value: #{ source.inspect }", caller_locations 
      end
      multipliers = {
        'w' => 7 * 24 * 60 * 60,
        'd' => 24 * 60 * 60,
        'h' => 60 * 60,
        'm' => 60,
        's' => 1,
        'ms' => 0.001,
        'us' => 0.000001,
        'ns' => 0.000000001,
      }
      matches = source.scan(/(\d+)(w|d|h|m|s|ms|us|ns)/)
      seconds = 0
      subseconds = 0.0
      has_subseconds = false
      matches.each do |fields|
        num = fields[0].to_i
        unit = fields[1]
        if %w[ms us ns].include?(unit)
          subseconds += num * multipliers[unit]
          has_subseconds = true
        else
          seconds += num * multipliers[unit]
        end
      end
      if has_subseconds
        seconds + subseconds
      else
        seconds
      end
    end

  end

  # @group Include Interface

  # @see .parse
  # @param [String, nil] source
  # @return [Numeric, nil]
  def parse_duration(source) = IS::Duration.parse(source)

  # @see .format
  # @return [String, nil]  
  def format_duration value, **opts
    IS::Duration.format(value, **opts)
  end

  private :parse_duration, :format_duration
  # @endgroup

end
