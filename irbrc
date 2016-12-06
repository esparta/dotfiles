#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 10000000
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
#
# IRB.conf[:PROMPT_MODE] = :SIMPLE
#
# IRB.conf[:AUTO_INDENT] = true

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  def find_me
    User.find_by_email 'esparta@gmail.com'
  end
end
