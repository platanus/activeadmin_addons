module CapybaraHelpers
  def on_input_ctx(input_id, &block)
    within("li##{input_id}_input") do
      block.call
    end
  end

  def click_filter_btn
    page.execute_script("document.getElementsByClassName('filter_form')[0].submit()")
  end

  def expect_text(text)
    expect(page).to have_text(text)
  end

  def not_expect_text(text)
    expect(page).not_to have_text(text)
  end

  def expect_css(css)
    expect(page).to have_css(css)
  end

  # Select 2 helpers

  def select2_options_container
    find(".select2-container")
  end

  def select2_input
    find(".select2-search__field")
  end

  def open_select2_options
    select2_options_container.click
  end

  def fill_select2_input(item_text)
    open_select2_options
    select2_input.set(item_text)
  end

  def fill_select2_input_and_press_return(item_text)
    fill_select2_input(item_text)
    select2_input.native.send_keys(:return)
  end

  def pick_select2_entered_option(item_text, display_name = nil)
    display_name = item_text unless display_name
    fill_select2_input(item_text)
    click_select2_option(display_name)
  end

  def click_select2_option(display_name)
    page.find(:xpath, "//li[text()='#{display_name}']").click
  end

  def expect_select2_data_option(option, value)
    expect(page).to have_xpath("//select[@data-#{option}='#{value}']")
  end

  def expect_select2_selection(text)
    expect(page).to have_css(".select2-selection__rendered", text: /#{text}/)
  end

  def expect_select2_empty_selection
    expect(page).not_to have_css(".select2-selection__rendered")
  end

  def expect_select2_choices_count_to_eq(count)
    expect(page).to have_css("li.select2-selection__choice", count: count)
  end

  def expect_select2_options_count_to_eq(count)
    expect(page).to have_css("select.select2-hidden-accessible option", count: count)
  end

  def expect_select2_result_text_to_eq(result_number, text)
    expect(page).to have_css(
      "li.select2-results__option:nth-child(#{result_number})", text: /#{text}/
    )
  end

  def expect_select2_results_count_to_eq(count)
    klass = "li.select2-results__option"
    no_results = "No results found"

    if count.zero?
      expect(page).to have_css(klass, count: 1)
      expect(page).to have_content(no_results)
    else
      expect(page).to have_css(klass, count: count)
      expect(page).not_to have_content(no_results)
    end
  end

  def click_add_nested
    find("a.has_many_add").click
  end

  def on_nested_ctx(resource_number, &block)
    within("li.has_many_container fieldset:nth-child(#{resource_number + 1}) ") do
      block.call
    end
  end

  def expect_nested_select2_result_text_to_eq(result_number, text)
    expect(page).to have_css(
      "li.nested_level:nth-child(#{result_number})", text: /#{text}/
    )
  end
end
