module CreateHtml

  def html

    content = File.read('index.html')

    File.open('pet_html.html', 'w') do |file|
      content.gsub!('{{animal}}', self.animal)
      content.gsub!('{{name}}', self.name)
      content.gsub!('{{health}}', "#{self.health}")
      content.gsub!('{{bellyful}}', "#{self.bellyful}")
      content.gsub!('{{peppiness}}', "#{self.peppiness}")
      content.gsub!('{{mood}}', "#{self.mood}")
      content.gsub!('{{purity}}', "#{self.purity}")
      content.gsub!('{{toilet}}', "#{self.toilet}")
      content.gsub!('{{response}}', "#{self.response.uniq.join('__')}")
      content.gsub!('__', '<br>')
      content.gsub!('{{emoji}}', "‍#{self.emoji}")
      file.write("#{content}")

    end

    end
  end
