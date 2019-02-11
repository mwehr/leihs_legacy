module Spec
  module CommonSteps
    step 'I pry' do
      # rubocop:disable Lint/Debugger
      binding.pry
      # rubocop:enable Lint/Debugger
    end

    def wait_until(wait_time = 60, &block)
      begin
        Timeout.timeout(wait_time) do
          sleep(1) until value = block.call
          value
        end

        # rubocop:disable Style/RaiseArgs

        # rubocop:enable Style/RaiseArgs
      rescue Timeout::Error
        fail Timeout::Error.new(block.source)
      end
    end

    def hover_for_tooltip(target)
      page.driver.browser.action.move_to(target.native).perform
      find('.tooltipster-content') # there should be just one
    end

    def type_into_autocomplete(selector, value)
      raise 'please provide a value' if value.size.zero?
      step 'I release the focus from this field'
      find(selector).click
      find(selector).set value
      find('.ui-autocomplete')
    end

    def type_into_and_select_from_autocomplete(selector, value)
      type_into_autocomplete(selector, value)
      within '.ui-autocomplete' do
        find('.ui-menu-item', text: value).click
      end
    end

    step 'I close the flash message if visible' do
      flash = first('#flash')
      flash.find('.fa-times-circle').click if flash
    end

    step 'I release the focus from this field' do
      page.find('body').click # blur all possible focused autocomplete inputs
    end

    step 'I save' do
      find('#save').click
    end

    step 'I accept the confirmation dialog' do
      page.driver.browser.switch_to.alert.accept
    end

    step 'I cancel the confirmation dialog' do
      page.driver.browser.switch_to.alert.dismiss
    end

    step 'I see a success message' do
      find('#flash .success')
    end

    step 'I see an error message' do
      find('#flash .error')
    end

    step 'I see a notification message' do
      find('#flash .notice')
    end

    def rescue_displaced_flash
      begin
        yield
      rescue StandardError
        find('#flash .fa-times-circle').click
        retry
      end
    end

    def rescue_with_pry
      begin
        yield

        # rubocop:disable Lint/Debugger

        # rubocop:enable Lint/Debugger
      rescue StandardError
        binding.pry
      end
    end
  end
end
