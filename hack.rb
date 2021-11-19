class Tabelog
  require 'selenium-webdriver'
  require 'pry-byebug'
  require "csv"
  require 'nokogiri'
  require 'capybara'
  require 'capybara/dsl'
  include Capybara::DSL
  load './capybara_config.rb'
  load './capybara_register.rb'

  def find_store(area:, food:)
    shop_name, place, ratio, holiday, shop_list = [".list-rst__rst-name-target", ".list-rst__area-genre", ".c-rating__val", ".list-rst__holiday-text", ".list-rst__wrap"]
    visit "https://tabelog.com"
    find("input[id='sa']").set(area)
    find("input[id='sk']").set(food)
    find("#js-global-search-btn").click
    find(".navi-rstlst__text--rank").click
    target_html_array = page.all(shop_list).map{ |element| Nokogiri::HTML.parse(element['innerHTML'], nil, 'utf-8') }
    shop_info_array = target_html_array.map { |html| {
      shop_name: get_info(html, shop_name),
      place: get_info(html, place),
      ratio: get_info(html, ratio),
      holiday: get_info(html, holiday),
      url: get_info(html, "url") }
    }

    write_csv(shop_info_array)
  end

  private

  def get_info(doc, target)
    return doc.css("a")[0][:href] if target == "url"
    doc.css(target).text.strip
  end

  def write_csv(hash_array)
    CSV.open("./shop_info.csv", "wb") do |csv|
      csv << hash_array[0].keys
      hash_array.each{ |hash| csv << hash.values }
    end
  end
end

area = ARGV[0] || ""
food = ARGV[1] || ""
Tabelog.new.find_store(area: area, food: food)