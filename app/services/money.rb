# Money is stored as integers in the currency's smallest unit. Conversion to and
# from decimal strings only happens at the edges (forms, display).
module Money
  EXPONENTS = Hash.new(2).merge(
    "JPY" => 0, "KRW" => 0, "VND" => 0, "CLP" => 0,
    "KWD" => 3, "BHD" => 3, "OMR" => 3, "JOD" => 3, "TND" => 3
  ).freeze

  MAX_MINOR = 10**14

  module_function

  # Parses decimal currency input and returns an integer in minor units.
  # "1,234.56" => 123456. Raises ArgumentError if invalid or out of range.
  def parse_to_minor(value, exponent: 2)
    decimal = BigDecimal(value.to_s.delete(",").strip)
    raise ArgumentError, "amount out of range" unless decimal.finite?

    minor = (decimal * 10**exponent).round.to_i
    raise ArgumentError, "amount out of range" if minor.abs > MAX_MINOR

    minor
  end

  # Formats minor units as an unsigned decimal string with the currency precision.
  # 123456 => "1234.56" (no thousands separator, so it round-trips through parse).
  def format_from_minor(minor, exponent: 2)
    sign = minor.negative? ? "-" : ""
    return "#{sign}#{minor.abs}" if exponent.zero?

    whole, frac = minor.abs.divmod(10**exponent)
    "#{sign}#{whole}.#{frac.to_s.rjust(exponent, '0')}"
  end
end
