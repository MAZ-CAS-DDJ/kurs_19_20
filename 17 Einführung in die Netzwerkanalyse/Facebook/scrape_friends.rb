require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'csv'
require 'json'

class Scrape
    include Capybara::DSL
    Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :phantomjs_logger => File.open(File::NULL, "w")})
    end
    Capybara.default_driver = :poltergeist
end

USERNAME = "xxx@xxx.net"
PASSWORD = "xxxx"
MY_SLUG = "xxxx"

def login(s)
    puts "Logging into FB"
    s.visit("http://facebook.com")
    if s.page.title != "Facebook"
        s.fill_in("email", :with => USERNAME)
        s.fill_in("pass", :with => PASSWORD)
        s.click_button("Anmelden")
        begin
          s.click_button("OK")
        rescue
          puts "OK button not present."
        end
    end
end

def scrape_friends(s)
    login(s)
    #s.page.save_screenshot("login.png",:full => true)

    #Scrape my friends
    s.visit("https://www.facebook.com/#{MY_SLUG}/friends")
    30.times do 
        puts "scrolling...and...waiting"
        s.page.execute_script('window.scroll(0,100000);')
        sleep(1)
    end
    #s.page.save_screenshot("out1.png",:full => true)
    doc = Nokogiri::HTML(s.page.body)
    friends = doc.css(".fcb a")
    puts "Scraping #{friends.count} friends"
    CSV.open("friends.csv", "w") do |csv|
        csv << ["Friend ID", "Friend Name"]
        friends.each do |friend|
          begin
            friend_name = friend.children.text
            friend_id = JSON.parse(friend.attributes["data-gt"].value)["engagement"]["eng_tid"]
            csv << [friend_id, friend_name]
          rescue
            puts "Problems obtaining #{friend}"
          end
        end
    end
end

def scrape_mutual_friends(s)
    login(s)
    edgelist = []

    #Get FriendsIDs
    friendslist = CSV.open("friends.csv",:headers => true).to_a

    #Get my Id
    s.visit("http://facebook.com/#{MY_SLUG}")
    html = Nokogiri::HTML(s.page.body)
    my_id = html.at("body").text.match(/profile_id:(\d*)/).to_a[1]    
    puts "My ID: #{my_id}"

    friendslist.each do |friends|
        puts "Visiting friend: #{friends[1]}"
        s.visit("https://www.facebook.com/browse/mutual_friends/?uid=#{my_id}&node=#{friends[0]}")
        mutual_friends = Nokogiri::HTML(s.page.body).css(".fcb a")
        puts "Found #{mutual_friends.count} mutual friends"
        mutual_friends.each do |friend|
            edgelist << [friends[0],JSON.parse(friend.attributes["data-gt"].value)["engagement"]["eng_tid"]]
        end
    end
    CSV.open("network.csv", "w") do |csv|
        edgelist.each do |edges|
            csv << [edges[0],edges[1]]
        end
    end
end

def create_user_network()
    network = CSV.open("network.csv",:headers => false).to_a
    details = Hash[*CSV.parse(File.read('friends.csv')).to_a.flatten]

    CSV.open("user_network.gexf", "wb") do |csv|                   
      ################## HEADER #################
      csv << ["<?xml version='1.0' encoding='UTF-8'?>"]
      csv << ["<gexf xmlns='http://www.gexf.net/1.1draft' version='1.1'>"]
      csv << ["<meta lastmodifieddate='"+ Time.now.strftime("%Y-%d-%m") + "'>"]
      csv << ["<creator>plotti@gmx.net</creator>"]
      csv << ["<default>yellow</default>"]
      csv << ["<description>Facebook My Friends</description>"]
      csv << ["</meta>"]
      csv << ["<graph mode='static' defaultedgetype='directed' >"]
      csv << ["<attributes class='node' mode='dynamic'>"]
      csv << ["<attribute id='0' title='time' type='string'/>"]  
      csv << ["</attributes>"]
      csv << ["<attributes class='node' mode='static'>"]
      csv << ["<attribute id='1' title='facebookid' type='string'/>"]
      csv << ["</attributes>"]   
      ################## NODES #################
      csv << ["<nodes>"]
      j = 0
      network.flatten.uniq.each do |node|
          j+= 1
          puts "Creating node #{j}"
          csv << ["<node id='" + node + "' label='" + details[node].to_s.gsub("'","") +  "' >"]          
          csv << ["</node>"]
      end
      csv << ["</nodes>"]
      ################## EDGES #################
      csv << ["<edges>"]  
      i = 1
      network.each do |edgepair|
        csv<< ["<edge id='" + i.to_s + "' source='" + edgepair[0] + "' target='" + edgepair[1] + "' weight='1' />"]
        puts "Creating  #{edgepair[0]} to #{edgepair[1]}."
        i += 1
      end
      ################## FOOTER #################
      csv << ["</edges>"]
      csv << ["</graph>"]
      csv << ["</gexf>"]
    end
end

s = Scrape.new
scrape_friends(s)
scrape_mutual_friends(s)
create_user_network