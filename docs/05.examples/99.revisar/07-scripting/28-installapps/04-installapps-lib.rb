
def execute(command, debug)
  if debug
    puts "[DEBUG] \'#{command}\'"
  else
    ok = system(command)
    puts "[ERROR] \'#{command}\'" unless ok
  end
end

def install(packages, debug)
  execute "zypper refresh", debug

  names = packages.split().sort
  names.each do |package|
    execute("zypper install -y #{package}", debug)
  end
end
