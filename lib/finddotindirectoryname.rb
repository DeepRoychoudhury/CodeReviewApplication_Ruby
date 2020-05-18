#Strategy design pattern
class Finddotindirectoryname	 
   def self.find_chars(subject, characters)
            letters = characters.chars
            subject.chars.each do |letter|
            i = letters.index(letter)
            next if i.nil?
               letters.delete_at(i)
               return true if letters.empty?
            end
         false
   end
end