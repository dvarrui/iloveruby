require "debug"

class Bottles
  def verse(number)
    return verse_2 if number == 2
    return verse_1 if number == 1
    return verse_0 if number == 0

    expected = <<-VERSE
%d bottles of beer on the wall, %d bottles of beer.
Take one down and pass it around, %d bottles of beer on the wall.
VERSE
   format(expected, number, number, number - 1)
  end

  def verses(max, min)
    index = max
    output = [ verse(index) ]
    while(index > min)
      index = index - 1
      output << verse(index)
    end
    output.join("\n")
  end

  def song
    verses(99,0)
  end

  private

  def verse_2
    expected = <<-VERSE
2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.
VERSE
  end

  def verse_1
  expected = <<-VERSE
1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
VERSE
  end

  def verse_0
    expected = <<-VERSE
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
VERSE
  end

end
