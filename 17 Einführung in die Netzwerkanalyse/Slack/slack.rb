require "slack-ruby-client"
require 'csv'

Slack.configure do |config|
  config.token = "############"
end

client = Slack::Web::Client.new
client.auth_test

def read_in_data()
    begin
        puts "Trying to read in data dump channels and users."
        users = Marshal.load(File.binread("users.dump"))
        channels = Marshal.load(File.binread("channels.dump"))
    rescue => e 
        puts "No dump found #{e}"
    end
    if users == nil || channels == nil
        channels = {}
        users = {}
        client.channels_list.channels.each do |channel|
            channels[channel.name] = {:members => channel.members, :created_at => Time.at(channel.created)}
            channel.members.each do |member|
                if users[member] == nil
                    puts "Working on member #{member}"
                    users[member] = client.users_info(user: member)
                end
            end
        end
        File.open("users.dump", 'wb') {|f| f.write(Marshal.dump(users))}
        File.open("channels.dump", 'wb') {|f| f.write(Marshal.dump(channels))}
    end
    return [users,channels]
end

def create_edgelists(users,channels)
    begin
        puts "Trying to read in data dump edgelists."
        user_edgelist = Marshal.load(File.binread("user_edgelist.dump"))
        edgelist = Marshal.load(File.binread("edgelist.dump"))
    rescue => e
        puts "No Dump found: #{e}"
    end

    if edgelist == nil
        edgelist = []
        channels.each do |key,values|
            puts "Working on Channel #{key}. Created #{values[:created_at].strftime("%d.%m.%y")}"
            channels.each do |k,v|
                weight = values[:members] & v[:members]
                if weight != [] && k != key
                    edgelist << {:source => key,:target => k,:weight => weight.count}
                    puts "  Adding edge source: #{key} target: #{k} weight: #{weight.count}}"
                end
            end
        end
        edgelist = File.open("edgelist.dump", 'wb') {|f| f.write(Marshal.dump(edgelist))}
    end

    if user_edgelist == nil
        user_edgelist = []
        users.each do |key,values|
            puts "Working on User #{key}. "
            users.each do |k,v|
                weight = 0
                channels.each do |c,members|
                    if members[:members].include?(k) & members[:members].include?(key)
                        weight += 1
                    end
                end
                if weight > 3 
                    user_edgelist << {:source => key, :target => k, :weight => weight}
                    puts "  Adding edge source: #{key} target: #{k} weight: #{weight}}"
                end
            end
        end
        user_edgelist = File.open("user_edgelist.dump", 'wb') {|f| f.write(Marshal.dump(user_edgelist))}
    end
    return [edgelist,user_edgelist]
end

############## CREATE CHANNEL NETWORK ############
def create_channel_network(channels,edgelist)
    max = channels.count.to_s
    CSV.open("network.gexf", "wb") do |csv|              
      ################## HEADER #################      
      csv << ["<?xml version='1.0' encoding='UTF-8'?>"]
      csv << ["<gexf xmlns='http://www.gexf.net/1.1draft' version='1.1'>"]
      csv << ["<meta lastmodifieddate='"+ Time.now.strftime("%Y-%d-%m") + "'>"]
      csv << ["<creator>plotti@gmx.net</creator>"]
      csv << ["<default>yellow</default>"]
      csv << ["<description>Liip Slack Community</description>"]
      csv << ["</meta>"]
      csv << ["<graph mode='dynamic' defaultedgetype='directed' start='" + 0.to_s + "' end='" + max + "'>"]
      csv << ["<attributes class='node' mode='dynamic'>"]
      csv << ["<attribute id='0' title='time' type='string'/>"]  
      csv << ["</attributes>"]
      csv << ["<attributes class='node' mode='static'>"]
      csv << ["<attribute id='1' title='facebookid' type='string'/>"]
      csv << ["</attributes>"]   
      ################## NODES #################
      csv << ["<nodes>"]
      j = 0
      processed_nodes = []
      channels.sort{|a,b| a[1][:created_at] <=> b[1][:created_at]}.each do |channel|
        if !processed_nodes.include?(channel[1])
          j+= 1
          puts "Creating node #{j}"
          csv << ["<node id='" + channel[0] + "' label='" + channel[0] + " (" + channel[1][:created_at].strftime("%d.%m.%y") + ")' start='" + j.to_s + "' end='" + max + "' >"]          
          csv << ["<attvalues>"]
          csv << ["<attvalue for='0' value='" + channel[1][:created_at].to_s + "'/>"]
          csv << ["<attvalue for='1' value='""'/>"]
          csv << ["</attvalues>"]
          csv << ["</node>"]
          processed_nodes << channel[1]
          puts "Adding #{channel[1]}"
        end
      end
      csv << ["</nodes>"]
      ################## EDGES #################      
      csv << ["<edges>"]  
      i = 1
      edgelist.each do |edge|
        csv<< ["<edge id='" + i.to_s + "' source='" + edge[:source] + "' target='" + edge[:target] + "' weight='" + edge[:weight].to_s + "' />"]
          puts "Creating  #{edge[:source]} to #{edge[:target]}: #{edge[:weight].to_s}"
        i += 1
      end
      ################## FOOTER #################
      csv << ["</edges>"]
      csv << ["</graph>"]
      csv << ["</gexf>"]
    end
end

############## CREATE USER NETWORK ############

def create_user_network()
    CSV.open("user_network.gexf", "wb") do |csv|                   
      ################## HEADER #################
      csv << ["<?xml version='1.0' encoding='UTF-8'?>"]
      csv << ["<gexf xmlns='http://www.gexf.net/1.1draft' version='1.1'>"]
      csv << ["<meta lastmodifieddate='"+ Time.now.strftime("%Y-%d-%m") + "'>"]
      csv << ["<creator>plotti@gmx.net</creator>"]
      csv << ["<default>yellow</default>"]
      csv << ["<description>Liip Slack User Community</description>"]
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
      processed_nodes = []
      user_edgelist.each do |edge|                    
        # SOURCES
        if !processed_nodes.include? edge[:source]
          j+= 1
          puts "Creating node #{j}"
          csv << ["<node id='" + edge[:source] + "' label='" + users[edge[:source]]["user"]["profile"].real_name_normalized.gsub(/[^0-9a-z ]/i, '').to_s +  "' >"]          
          csv << ["</node>"]
          processed_nodes << edge[:source]
        end        
        #TARGETS
        if !processed_nodes.include? edge[:target]
          j+= 1
          puts "Creating node #{j}"
          csv << ["<node id='" + edge[:target] + "' label='" + users[edge[:target]]["user"]["profile"].real_name_normalized.gsub(/[^0-9a-z ]/i, '').to_s + "' >"]          
          csv << ["</node>"]
          processed_nodes << edge[:target]
        end
      end
      csv << ["</nodes>"]
      ################## EDGES #################
      csv << ["<edges>"]  
      i = 1
      user_edgelist.each do |edge|
        if edge[:weight] > 3
            csv<< ["<edge id='" + i.to_s + "' source='" + edge[:source] + "' target='" + edge[:target] + "' weight='" + edge[:weight].to_s + "' />"]
            puts "Creating  #{edge[:source]} to #{edge[:target]}: #{edge[:weight].to_s}"
            i += 1
        end
      end
      ################## FOOTER #################
      csv << ["</edges>"]
      csv << ["</graph>"]
      csv << ["</gexf>"]
    end
end

################# MAIN #################

users, channels = read_in_data
channel_edgelist, user_edgelist = create_edgelists(users,channels)
create_channel_network(channels,channel_edgelist)
