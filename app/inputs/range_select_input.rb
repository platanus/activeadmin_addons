class RangeSelectInput < NumericRangeFilterInput
  def to_html
    warn "[DEPRECATION] use :numeric_range_filter instead of :range_select"
    super
  end
end
