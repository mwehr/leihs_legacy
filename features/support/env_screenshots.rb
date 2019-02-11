def take_screenshot
  @screenshot_dir ||= Rails.root.join('tmp', 'capybara')
  begin
    Dir.mkdir @screenshot_dir
  rescue StandardError
    nil
  end
  path = @screenshot_dir.join("screenshot_#{Time.zone.now.iso8601.gsub(/:/, '-')}.png")
  case Capybara.current_driver
  when :selenium_firefox
    begin
      page.driver.browser.save_screenshot(path)
    rescue StandardError
      nil
    end
  else
    Rails.logger.warn "Taking screenshots is not implemented for #{Capybara.current_driver}."
  end
end

After { |scenario| take_screenshot if scenario.failed? }

AfterStep do |scenario|
  if t = scenario.instance_eval { @tags }
    take_screenshot if t.tags.map(&:name).include? '@take_screenshots'
  end
end
