#Strategy Design Pattern
module CRA_logic_shraddha
   class CheckNumPresent
      def self.getData(firstParam,secondParam)  
      if firstParam =~ /\d+/
         return true
      else
         return false  
      end           
      end
   end

   class ParamCntInMethod
      def self.getData(firstParam,secondParam) 
         firstParam = firstParam.to_s.scan(/\(.*?\)/)
         firstParam = firstParam.to_s.gsub('(' ,'')
         firstParam = firstParam.to_s.gsub(')' ,'')
         return firstParam.split(',').count.to_i
      end
   end

   class CheckEncoding
      def self.getData(firstParam,secondParam)  
            return "File encoding is - " + firstParam.encoding.to_s           
      end
   end

   class CharCountPerLine
      def self.getData(firstParam,secondParam)  
            return firstParam.length          
      end
   end

   class SpaceAfterLineEnd
      def self.getData(firstParam,secondParam)  
      if  firstParam =~ /\s^/
         return 1
      else
         return 0
      end     
      end
   end

   class QueriesInFile
      def self.getData(firstParam,secondParam)
         @qkeywords = ""
         if firstParam.downcase.include? "select"
            @qkeywords = @qkeywords + "select,"
         end
         if firstParam.downcase.include? "where"
            @qkeywords = @qkeywords + "where,"
         end
         if firstParam.downcase.include? "join"
            @qkeywords = @qkeywords + "join,"
         end
         if firstParam.downcase.include? "inner join"
            @qkeywords = @qkeywords + "inner join,"
         end
         if firstParam.downcase.include? "left join"
            @qkeywords = @qkeywords + "left join,"
         end
         if firstParam.downcase.include? "right join"
            @qkeywords = @qkeywords + "right join,"
         end
         if firstParam.downcase.include? "outer join"
            @qkeywords = @qkeywords + "outer join,"
         end
         if firstParam.downcase.include? "create"
            @qkeywords = @qkeywords + "create,"
         end
         if firstParam.downcase.include? "drop"
            @qkeywords = @qkeywords + "drop,"
         end
         if firstParam.downcase.include? "alter"
            @qkeywords = @qkeywords + "alter,"
         end
         if firstParam.downcase.include? "table"
            @qkeywords = @qkeywords + "table,"
         end
         return @qkeywords
      end
   end

 end