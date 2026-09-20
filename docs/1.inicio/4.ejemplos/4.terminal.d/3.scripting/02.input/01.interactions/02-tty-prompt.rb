#!/usr/bin/env ruby 

require "tty-prompt"
prompt = TTY::Prompt.new

prompt.ask("What is your name?", default: ENV["USER"])
# => What is your name? (piotr)

prompt.yes?("Do you like Ruby?")
# => Do you like Ruby? (Y/n)

prompt.mask("What is your secret?")
# => What is your secret? ••••

prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))
# =>
# Choose your destiny? (Use ↑/↓ arrow keys, press Enter to select)
# ‣ Scorpion
#   Kano
#   Jax

choices = %w(vodka beer wine whisky bourbon)
prompt.multi_select("Select drinks?", choices)
# =>
#
# Select drinks? (Use ↑/↓ arrow keys, press Space to select and Enter to finish)"
# ‣ ⬡ vodka
#   ⬡ beer
#   ⬡ wine
#   ⬡ whisky
#   ⬡ bourbon

choices = %w(emacs nano vim)
prompt.enum_select("Select an editor?", choices)
# =>
#
# Select an editor?
#   1) emacs
#   2) nano
#   3) vim
#   Choose 1-3 [1]:

choices = [
  { key: "y", name: "overwrite this file", value: :yes },
  { key: "n", name: "do not overwrite this file", value: :no },
  { key: "a", name: "overwrite this file and all later files", value: :all },
  { key: "d", name: "show diff", value: :diff },
  { key: "q", name: "quit; do not overwrite this file ", value: :quit }
]
prompt.expand("Overwrite Gemfile?", choices)
# =>
# Overwrite Gemfile? (enter "h" for help) [y,n,a,d,q,h]

# If you wish to collect more than one answer use collect:

result = prompt.collect do
  key(:name).ask("Name?")

  key(:age).ask("Age?", convert: :int)

  key(:address) do
    key(:street).ask("Street?", required: true)
    key(:city).ask("City?")
    key(:zip).ask("Zip?", validate: /\A\d{3}\Z/)
  end
end
# =>
# {:name => "Piotr", :age => 30, :address => {:street => "Street", :city => "City", :zip => "123"}}


