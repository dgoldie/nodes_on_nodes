
# frozen_string_literal: true
require 'json'

# The coolest program
class CoolProgram
  attr_reader :data
  def initialize
    @data = init_data()
    @total_count = Hash.new(0)
    @share_count = Hash.new(0)
  end

  def init_data
    raw_data = File.read('./data/nodes.json')
    JSON.parse(raw_data)
  end

  def execute
    calculate
    report
  end

  def calculate
    @data.each do | node |
      add_to_total_count(node["id"])
      process_children(node["child_node_ids"])
    end
  end

  def report 
    puts "Debug"
    puts @total_count
    puts @share_count
    puts "\nResults"
    puts "1. Total unique nodes is #{unique_count}"
    puts "1. Node id most shared is #{most_shared_node}"
  end

  private

  def add_to_total_count(id)
    @total_count[id] += 1
  end

  def add_to_share_count(id)
    @share_count[id] += 1
  end

  def process_children(ids)
    ids.each do |id|
      add_to_total_count(id)
      add_to_share_count(id)
    end
  end

  def unique_count
    @total_count.count
  end

  def most_shared_node
    @share_count.sort_by(&:last)[-1][0]
  end

end



CoolProgram.new.execute
 