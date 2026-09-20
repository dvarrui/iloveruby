#!/usr/bin/ruby

class Robot
  def self.saludar( veces = 5)
    veces.times { puts " => ¡Hola! Soy un #{self.class}" }
  end

  def self.me_presento
    puts "Mis ancestros son #{self.ancestors.join(', ')}"
  end
end

Robot.saludar
Robot.me_presento
pp Robot
