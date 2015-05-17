#!/usr/bin/env ruby
require 'json'

def convert2seconds (time_str)
  if /^(\d?\d):(\d\d)$/ =~ time_str
    60 * $1.to_i + $2.to_i
  elsif /^(\d+)?:?(\d?\d):(\d\d)$/ =~ time_str
    3600 * $1.to_i + 60 * $2.to_i + $3.to_i
  end
end

STDIN.each{|line|
  if /^(\s*)(\d+)  (\d\d\d\d-\d\d-\d\d) (\d\d:\d\d)  (.*?)  (.*?)$/ =~ line
    id = $2.to_i
    m = {:id => id,
         :date => "#{$3} #{$4} +0900",
         :time => convert2seconds($5),
         :command => $6}
    puts "{ \"index\" : { \"_index\" : \"zsh_history\", \"_type\" : \"command\", \"_id\" : \"#{id}\" } }"
    puts m.to_json
  end
}
