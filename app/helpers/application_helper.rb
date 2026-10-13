module ApplicationHelper
  CURRENCY_UNITS = {
    "USD" => "$",
    "EUR" => "€",
    "GBP" => "£",
    "JPY" => "¥",
    "CAD" => "CA$",
    "AUD" => "A$"
  }.freeze

  def budget_money(amount_minor, currency:)
    precision = Money::EXPONENTS.fetch(currency, 2)
    amount = BigDecimal(amount_minor.to_s) / (10**precision)
    unit = CURRENCY_UNITS.fetch(currency, "#{currency} ")

    number_to_currency(amount, unit: unit, precision: precision)
  end
end
