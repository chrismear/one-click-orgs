profile = Selenium::WebDriver::Firefox::Profile.new
profile.log_file = File.join(Rails.root, 'log', 'selenium_console.log')

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :profile => profile)
end
