#Strategy Design Pattern
module CRA_logic_deep
   class NoOfLines
      def self.getData(firstParam,secondParam)  
            return firstParam = firstParam.to_i + 1             
      end
   end

   class NoOfMethods
      def self.getData(firstParam,secondParam)  
            return firstParam = firstParam.to_i + 1             
      end
   end

   class CountWord
      def self.getData(firstParam,secondParam)  
            return firstParam.scan(/(?=#{secondParam})/).count           
      end
   end

   class IsUpper
      def self.getData(firstParam,secondParam)  
            return /[[:upper:]]/ =~ firstParam          
      end
   end

   class MethodCallCount
      def self.getData(firstParam,secondParam)  
         firstParam = firstParam.to_s.gsub('.' ,'')
         firstParam = firstParam.to_s.gsub('(' ,'')
         return firstParam         
      end
   end

   class NumberofComments
      def self.getData(firstParam,secondParam)  
         return firstParam = firstParam.to_i + 1             
      end
   end
   
      class NoOfClass
      def self.getData(firstParam,secondParam)  
            return firstParam = firstParam.to_i + 1             
      end
   end
 end