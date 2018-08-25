#!/usr/bin/env ruby
#Create a class
class PokerHand

    attr_accessor :content
    
    #Initializes an object and assings the entry list to var @content
    def initialize(content)
        @content = content
    end
    
    #Orders PokerHand content by sorting it and creating a whole string
    def orderAndSortHand
        self.content = self.content.sort.join("")
    end
end


