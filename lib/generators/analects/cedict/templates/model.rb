class Cedict < ActiveRecord::Base
  attr_accessible :simplified, :traditional, :pinyin, :english
end
