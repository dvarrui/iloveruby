require "tty-progressbar"
require_relative "rubing/exercise"
require "debug"

module Rubing
  def self.start
    system("clear")
    filenames = Dir.glob("exercises/**/*rb")
    bar = TTY::ProgressBar.new("Rubing progress [:bar]", total: filenames.size)
    exercise = nil
    filenames.each do |filename|
      bar.advance
      exercise = Exercise.new(filename)
      break unless exercise.done?
    end
    exercise.call
  end
end
