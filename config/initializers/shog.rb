if Rails.env.development?
  Shog.configure do
    match /\s*Rendered\s+(?<view>[^\s]+)\s(within\s(?<layout>[^\s]+)\s)?\((?<time>.*)\)/ do |msg, match|
      parts = ["  Rendered #{ match["view"].bold }".blue]
      parts << "within ".blue + match["layout"].blue.bold if match['layout']
      parts << format_time( match['time'].blue, 50 )
      parts.join " "
    end
  end
end
