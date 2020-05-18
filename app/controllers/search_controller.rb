require 'searchingdata'
class SearchController < ApplicationController
  def index
    begin
  	@search=params[:search].split(" ")
  	@searchdone="false"
  	@search.each do |s|
      #binding.pry
  		if (s.downcase.include? "note") && (!s.downcase.include? " ") && (@searchdone.to_s!="note")
  			@searchdone="note"  			
  			@searches=(SearchingData::SearchNote).build_search(current_user.id,params[:search].downcase)
  			puts "Search done on Note level"
  		elsif (s.downcase.include? "project") && (!s.downcase.include? " ") && (@searchdone.to_s!="project") 			
  			@searchdone="project"
  			@searches=(SearchingData::SearchProject).build_search(current_user.id,params[:search].downcase)
  			puts "Search done on Project level"
  		elsif (s.downcase.include? "review") && (!s.downcase.include? " ") && (@searchdone.to_s!="review") 			
  		  	@searchdone="review"
  		  	@searches=(SearchingData::SearchReview).build_search(current_user.id,params[:search].downcase)
  		  	puts "Search done on PrjReview level"
  		 elsif (s.downcase.include? "result") && (!s.downcase.include? " ") && (@searchdone.to_s!="result")
  		 	@searchdone="result"
  		 	@searches=(SearchingData::SearchResult).build_search(current_user.id,params[:search].downcase)
  		 	puts "Search done on Result level"
  		end	      
  	end  	
  		if (@searchdone=="false") && (@searchdone.to_s!="searchdonebysuper") 			
  			@searches=(SearchingData::SearchBuilder).build_search(current_user.id,params[:search].downcase)
  			@searchdone="searchdonebysuper"
  			puts "Search done on Super method"
  		end    
    rescue Exception => e 
      puts ("Exception Found : "+e.to_s)
    end    
  end
end
