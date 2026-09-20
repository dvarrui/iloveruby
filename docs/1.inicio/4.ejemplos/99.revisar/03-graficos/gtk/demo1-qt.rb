#!/usr/bin/ruby

# ZetCode Ruby Qt tutorial
# http://zetcode.com/gui/rubyqt/introduction/
# This code shows a tooltip on a window.
#
# author: Jan Bodnar
# website: www.zetcode.com
# last modified: September 2012


require 'Qt'


class QtApp < Qt::Widget

    def initialize
        super

        setWindowTitle "Tooltip"

        setToolTip "This is Qt::Widget"

        resize 250, 150
        move 300, 300

        show
    end
end

app = Qt::Application.new ARGV
QtApp.new
app.exec
