module CapybaraHelpers
  def wait_until
    require "timeout"
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end

  # @param [String] el_selector
  def double_click(el_selector)
    page.execute_script("$('#{el_selector}').trigger('dblclick')")
  end
end
