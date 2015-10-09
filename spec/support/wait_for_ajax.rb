module WaitForAjax
  def wait_for_ajax
    sleep(Capybara.default_max_wait_time)
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
