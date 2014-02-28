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

def CJKString(str)
  if str.is_a? CJKString
    return str
  elsif str.respond_to? :to_cjk
    str = str.to_cjk
  end
  CJKString.new(str.freeze)
end
