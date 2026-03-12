#!/usr/bin/env ruby

require_relative 'lib/list_of_type_lib'

class Demo
  include ListOfType

  def with_integers
    puts "\n* With Integers"
    int_list = ListOf_Integer(3, -1)

    puts int_list.to_s
    puts int_list[0].class
  end

  def with_strings
    puts "\n* With Strings"
    str_list = ListOf_String(5, 'demo')
    
    puts str_list.to_s
    puts str_list[0].class
  end

  def with_type_error
    puts "\n* With Type Error"
    list = ListOf_Integer(10, 'david')

    puts list.to_s
  end

end

d = Demo.new
d.with_integers
d.with_strings
d.with_type_error


