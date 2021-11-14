require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
include Capybara::DSL

# https://www.rubydoc.info/gems/capybara/Capybara.configure
Capybara.configure do |config|
  config.default_driver = :chrome
  config.javascript_driver = :chrome
  # Rackアプリのサーバーを起動するかの設定
  config.run_server = false
  config.default_selector = :css
  config.default_max_wait_time = 5
  config.ignore_hidden_elements = true
  config.save_path = Dir.pwd
  config.automatic_label_click = false
end


Capybara.register_driver :chrome do |app|

  # ブラウザーを起動する
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
  )
end

visit "https://tabelog.com/tokyo/A1303/A130301/"
# require 'debug'
select "￥2,000", from: "lstcost-sidebar"
find("input[name='sk']").set("焼肉")
# fill_in "input[name='sk']", with: "aaa"
find("button[aria-label='検索']").click