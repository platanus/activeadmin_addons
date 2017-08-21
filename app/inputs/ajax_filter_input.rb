class AjaxFilterInput < SearchSelectFilterInput
  def to_html
    warn "[DEPRECATION] use :search_select_filter instead of :ajax_filter"
    super
  end
end
