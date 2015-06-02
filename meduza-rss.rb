require 'open-uri'
require 'json'
require 'nokogiri'

$meduza = 'https://meduza.io'
$meduza_rss = $meduza + '/rss/%s'
$meduza_api = $meduza + '/api/v3/%s'

$feeds = %w(all news fun)

class Meduza
  def Meduza.start
    @cached = {}
    Thread.new do
      while true do
        $feeds.each do |feed|
          @cached[feed] = Meduza.generate(feed)
          sleep 10
        end
        sleep 30*60
      end
    end
  end

  def Meduza.rss(feed = 'all')
    if @cached[feed].nil?
      puts 'generating new feed'
      Meduza.generate(feed)
    else
      puts 'getting a feed from the cache'
      @cached[feed]
    end
  end

  private

  def Meduza.generate(feed)
    doc = Nokogiri::XML(open($meduza_rss % feed))

    doc.xpath('/rss/channel/item').each do |item|
      post_id = item.xpath('link').inner_text.gsub(/^#{$meduza}\//, '')
      json = JSON::parse(open($meduza_api % post_id).read)
      item.search('description').each do |description|
        description.content = json['root']['content']['body'].gsub('src="/image/', 'src="//meduza.io/image/')
      end
    end

    doc.to_xml
  end
end

Meduza.start

__END__
10.times do
  Meduza.rss
  Meduza.rss('news')
  Meduza.rss('fun')
end
