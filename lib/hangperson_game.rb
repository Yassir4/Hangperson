class HangpersonGame


  def initialize(word)
    @word = word
    # a for the wrong_guesses and c for the guesses
    @a = []
    @c = []  
    @word_with=[]
    #this var is for counting the nuber of chars made by the user
    @charNum = 0
  end
   attr_accessor :word ,:guesses , :wrong_guesses , :win , :lose , :play
   
  def guess(char)
      char = char.gsub(/[\s,]/ ,"")
    #check if the char is empty or non-char or nil 
     if  char == '' || /[A-Za-z]/ !~ char || char == nil
        raise ArgumentError      
     end
        @charNum += char.chars.count
        t = 0
         #check if the word include the chars
      char.chars.each do |l|
       if @word.include?(l) 
          t +=1
          @c.push(l)
       end
      end

       if t == char.chars.count
         b = @c.count char
         #check if it's already be guessed
          if b >= 1
            @a.push(char)
            @wrong_guesses=@a.last
            false
          else
            @c.push(char)
            @guesses=@c.last
          end
     
           #check if it's already be guessed
       elsif ('A'..'Z') === char || @a.include?(char)
          false
        else
          @a.push(char)
          @wrong_guesses = @a.last
       end
  end

    def word_with_guesses
          @word.chars.each do |l|
            @word_with.push("-")
          end
          a= @word.chars
          b=@c.join.to_s
      #check if the guesses chars match the word chars
      for i in 0..b.size - 1
        for j in 0..@word.size
            if b[i] == a[j]
                @word_with[j] = a[j]
            end
        end
      end
      
        @word_with.join.to_s
    end
        
    def check_win_or_lose
        if word_with_guesses == @word
            :win
        elsif @charNum > @word.chars.count
            :lose
        else
            :play
        end
    end

 


 
  
  
   
  
   
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end

