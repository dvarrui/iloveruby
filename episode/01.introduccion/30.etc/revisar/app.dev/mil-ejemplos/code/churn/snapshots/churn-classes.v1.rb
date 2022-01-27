#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---

class SubversionRepository
  def date(a_time)
    a_time.strftime("%Y-%m-%d")
  end

  def change_count_for(name, start_date)
    extract_change_count_from(log(name, start_date))
  end

  def extract_change_count_from(log_text)
    lines = log_text.split("\n")
    dashed_lines = lines.find_all do | line |
      line.include?('--------') 
    end
    dashed_lines.length - 1     
  end

  def log(subsystem, start_date)
    timespan = "--revision 'HEAD:{#{start_date}}'"
    root = "svn://rubyforge.org//var/svn/churn-demo"
    
    `svn log #{timespan} #{root}/#{subsystem}`
  end
end

def month_before(a_time)
  a_time - 28 * 24 * 60 * 60
end

def header(a_date)
  "Changes since #{a_date}:"
end

def subsystem_line(subsystem_name, change_count)
  asterisks = asterisks_for(change_count)
  "#{subsystem_name.rjust(14)} #{asterisks} (#{change_count})"
end

def asterisks_for(an_integer)
  '*' * (an_integer / 5.0).round
end


def order_by_descending_change_count(lines)
  lines.sort do | one, another |
    one_count = churn_line_to_int(one)
    another_count = churn_line_to_int(another)
    - (one_count <=> another_count)
  end
end

def churn_line_to_int(line)
  /\((\d+)\)/.match(line)[1].to_i
end


if $0 == __FILE__
  subsystem_names = ['audit', 'fulfillment', 'persistence',
                     'ui', 'util', 'inventory']
  repository = SubversionRepository.new #(1)
  start_date = repository.date(month_before(Time.now)) #(2)

  puts header(start_date)
  lines = subsystem_names.collect do | name |
    subsystem_line(name,
                   repository.change_count_for(name, start_date)) #(3)
  end
  puts order_by_descending_change_count(lines)
end

