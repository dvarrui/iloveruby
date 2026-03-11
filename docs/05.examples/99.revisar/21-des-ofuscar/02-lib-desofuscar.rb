

module Desofuscador
  def self.run(filepath)
    project = { filepath: filepath}
    project.merge! pre_process(File.readlines(filepath))
    show project
  end

  def self.pre_process(content)
    names = ('a'..'z').to_a
    ugly_vars = []
    content.each do |i|
      line = i.chop
      if line.start_with? '#'
        next
      elsif line.include? ' = '
        ugly_vars << (line.split(' = ')[0].strip)
        next
      end
    end
    vars = {}
    ugly_vars.uniq!.each do |i|
      vars[i] = "#{names[0]}#{i.size}"
      names.delete_at 0
    end

    return { vars: vars, lines_number: content.count }
  end

  def self.show(project)
    puts "[INFO] Desofuscating..."
    puts "  * Filepath      : #{project[:filepath]}"
    puts "  * Lines number  : #{project[:lines_number]}"
    puts "  * Vars detected : #{project[:vars].size}"
    project[:vars].each_pair { |k,v| puts "      #{v} -> #{k}" }
  end
end
