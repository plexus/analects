class CJKString < DelegateClass(String)
  def cjk_chars
    @cjk_chars ||= scan(Analects::Models::Zi::REGEXP)
  end

  def one_cjk?
    cjk_chars.length == 1
  end

  def all_cjk?
    length == cjk_chars.length
  end

  def any_cjk?
    cjk_chars.length > 1
  end
end

class CJKChar < DelegateClass(String)
  def unicode_range
    Analects::Models::Zi::RANGES.each do |name, info|
      return name if info[:range].include? codepoint
    end
  end

  def unicode_range_name
    Analects::Models::Zi::RANGES[unicode_range][:name]
  end

  def codepoint
    codepoints.first
  end
end

def CJKChar(str)
  return str if str.is_a? CJKChar

  if str.length > 1
    if str =~ /^(U\+)?([0-9A-Fa-f]+)/
      str = [$2].pack('U')
    else
      raise ArgumentError, 'CJKChar must have length one'
    end
  end

  CJKChar.new(str)
end

def CJKString(str)
  if str.is_a? CJKString
    return str
  elsif str.respond_to? :to_cjk
    str = str.to_cjk
  end
  CJKString.new(str.freeze)
end
