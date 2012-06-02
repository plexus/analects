require 'analects/cedict'
require 'analects/cli/progress'

class PopulateCedictTable < ActiveRecord::Migration
  def up
    path = ENV['CEDICT_PATH'] || Analects::CedictLoader::LOCAL
    unless File.exist? path
      puts "-- cedict file not found, downloading"
      Analects::CedictLoader.download!
    end

    if File.exist? path
      f = File.open path
      l = Analects::CedictLoader.new(f)
      puts "-- Inserting CC-CEDICT"
      l.headers.each do |k,v|
        puts "     #{k}=#{v}"
      end
      p = Analects::CLI::Progress.new(Integer(l.headers['entries'])-1, 5000, '   ')
      Cedict.transaction do
        l.each do |traditional, simplified, pinyin, english|
          p.next
          Cedict.create!(
                         :traditional => traditional,
                         :simplified => simplified,
                         :pinyin => pinyin,
                         :english => english
                         )
        end
      end
      f.close
      puts
    else
      raise "CC-Cedict file not found and failed to download"
    end
  end

  def down
    Cedict.delete_all
  end
end
