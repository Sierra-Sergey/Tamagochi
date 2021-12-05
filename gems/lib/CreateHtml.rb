module CreateHtml
  def html
    content = File.read('index.html')

    File.open('pet_html.html', 'w') do |file|
      content.gsub!('{{animal}}', animal)
      content.gsub!('{{name}}', name)
      content.gsub!('{{health}}', health.to_s)
      content.gsub!('{{bellyful}}', bellyful.to_s)
      content.gsub!('{{peppiness}}', peppiness.to_s)
      content.gsub!('{{mood}}', mood.to_s)
      content.gsub!('{{purity}}', purity.to_s)
      content.gsub!('{{toilet}}', toilet.to_s)
      content.gsub!('{{response}}', response.uniq.join('__').to_s)
      content.gsub!('__', '<br>')
      content.gsub!('{{emoji}}', "‍#{emoji}")
      file.write(content.to_s)
    end
  end
end
