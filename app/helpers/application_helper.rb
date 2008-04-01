# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def html_for_flash(content)
    temp = content.gsub(/\r\n/, "\n") # Flash hates \r\n, makes 2 linebreaks
    temp = temp.gsub( /<\/*ul>/, '') # removing the UL help at all? questionable
    # temp = temp.gsub( /<\ul>\s*\<\/ul\>/, '') # removing blank ULs
    temp = temp.gsub( /<(\/*)em>/, '<\1i>') # EM tag to I
    temp = temp.gsub( /<(\/*)strong>/, '<\1b>') # STRONG tag to B
    temp = temp.gsub(/\>\s*\<p/, "><br /><p") # removing whitespace between P tags, and inserting a literal break
    temp = temp.gsub(/\s*\<li/, "<li") # removing whitespace before LI tags
    temp = temp.gsub(/style\=\"padding-left\: (\d*)px\;\"/, 'class="indent\1"') # padding-left to class INDENT
    temp = temp.gsub(/style\=\"text-align\: (.*?)\;\"/, 'class="ta\1"') # text-align to class
  end
  
  def strip_html(str, preserve_tags=['a','img','p','br','i','b','u','ul','li'])
    str = str.strip || ''
    preserve_array = preserve_tags.join('|') << '|\/'
    str.gsub(/<(\/|\s)*[^(#{preserve_array})][^>]*>/,'')
  end
  
  def reg_exp_help
    
    # > s = ‘pretty little ponies’
    # > s.gsub(/[^aeiou]/, ‘_’)
    # => “__e_____i___e__o_ie_”
    # But the book Ruby for Rails had an example of passing a block into gsub:
    # > s.gsub(/[^aeiou]/) {|c| c.upcase}
    # => “PReTTY LiTTLe PoNieS”
    
    # Ruby provides Regular Expression replacement via the gsub method of String. For example, if I would like to replace a word I simply need the regex to match the word and the replacement text.
    # irb(main):006:0> "replacing in regex".gsub /\sin\s/, ' is easy in '
    # => "replacing is easy in regex"
    
    # The gsub method also lets you use the regex match in the replacement.
    # irb(main):007:0> "replacing in regex".gsub /\sin\s/, ' is easy\0'
    # => "replacing is easy in regex"
    
    # If you want part of the regex, but not the whole thing you will need to use a capturing group (parenthesis).
    # irb(main):008:0> "replacing in regex".gsub /\si(n)\s/, ' is easy i\1 '
    # => "replacing is easy in regex"
    
    # When using a capturing group that matches multiple times in a single line you can still use \1 to include the match in the result.
    # irb(main):015:0> "1%, 10%, 100%".gsub /(\d+)%/, '0.0\1'
    # => "0.01, 0.010, 0.0100"
    
    # Another important detail to note is that I'm using single quotes in my replacement string. Using double quotes neither works with \0 or \1 since "\0" #=> "\000".
    # irb(main):009:0> "replacing in regex".gsub /\sin\s/, " is easy\0"
    # => "replacing is easy\000regex"
    # irb(main):010:0> "replacing in regex".gsub /\si(n)\s/, " is easy i\1 "
    # => "replacing is easy i\001 regex"
    
  end
  
end
