require "music_xiami2wangyi/version"
require 'active_support/all'
require 'mechanize'
require 'headless'
require 'watir'
require 'nokogiri'


class MusicXiami2wangyi

  def initialize(xiami_user_id)
    @lib_song_url = "http://www.xiami.com/space/lib-song/u/#{xiami_user_id}"
  end

  def page_end_num
    @page_end_num ||= count_page_end_num
  end

  def start_browser
    #headless = Headless.new
    #headless.start
    @browser = Watir::Browser.start("www.xiami.com")
  end

  def close_browser
    @browser.close
    #headless.destroy
  end

  def count_page_end_num
    start_browser

    @browser.goto @lib_song_url
    page = Nokogiri::HTML.parse(@browser.html)

    until page.css(".all_page a.p_num").last.text != "…"
      next_page_num = page.css(".all_page a.p_num").last['href'].split("/").last
      @browser.goto @lib_song_url + "/page/#{next_page_num}"
      page =  Nokogiri::HTML.parse(@browser.html)
    end

    close_browser

    @page_end_num = page.css(".all_page a.p_num").last['href'].split("/").last
  end

  def page_nums
    (0..page_end_num.to_i).to_a
  end

  def songs
    @songs ||= crawl_music_file_names
  end

  def crawl_music_file_names
    files = []

    start_browser
    page_nums.each do |pn|
      url = @lib_song_url + "/page/#{pn}"
      @browser.goto url
      page = Nokogiri::HTML.parse(@browser.html)
      songs = page.css("td.song_name")
      songs.each do |s|
        files << "#{s.css('a.artist_name').text} - #{s.css('a').first.text}.mp3"
      end
    end
    close_browser

    @songs = files
  end

  def time
    @time ||= Time.now.strftime '%y%m%d'
  end

  def xml_songs
    @xml_songs ||= gen_xml_songs
  end

  def gen_xml_songs
    # for test
    # songs = [ "Sound Of Silence - Ania.mp3",
    #           "Coherence - Kristin Øhrn Dyrud.mp3" ]
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.List('ListName' => "虾米红心#{time}") do
        songs.each do |s|
          xml.File { xml.FileName(s) }
        end
      end
    end
    @xml_songs = builder.to_xml
  end

  def gen_xml_file
    File.open("xiami-#{time}.kgl", 'w') { |file| file.write(xml_songs) }
  end

end
