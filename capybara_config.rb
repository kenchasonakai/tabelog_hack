Capybara.configure do |config|
  config.default_driver = :chrome
  config.javascript_driver = :chrome
  config.run_server = false
  config.default_selector = :css
  config.default_max_wait_time = 5
  config.ignore_hidden_elements = true
  config.save_path = Dir.pwd
  config.automatic_label_click = false
end
