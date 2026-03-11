#!/usr/bin/ruby

class Map
  attr_reader :pages, :basedir, :projectdir, :publicdir

  def initialize(pBasedir)
    @projectdir=File.dirname($0)
    @publicdir=@projectdir+'/public'
    @basedir=pBasedir
    @pages=[]
						
    erbfiles = File.join(@basedir, "**", "*.erb")
    Dir.glob(erbfiles).each do |file|
      s = file[ (@basedir.size+1) .. -1 ]
      s = s[0..-5]
      @pages << s
    end 
    @pages.delete("index")
    @pages.sort!
  end
	
  def head(pageid)
    current=0
    total=@pages.size
    if pageid!='index' then
      current=@pages.index(pageid)+1
    end
      return "#{current.to_i}/#{total.to_i}"
  end
	
	def next(pageid)
		return @pages[0] if pageid=='index'
		i=@pages.index(pageid)
		s=@pages[i+1]
		return s
	end
	
	def previous(pageid)
		return nil if pageid=='index'
		i=@pages.index(pageid)
		return 'index' if i==0
		s=@pages[i-1]
		return s
	end

	def get_file(filename)
		c=File.new(filename).readlines
		s="<pre>"
		c.each { |l| s+=l.to_s }
		s+="</pre>"
	end
end
