require_relative ('clown_list.rb')

class Clown
  attr_reader :pos, :color, :correct

  def initialize(opts)
    @pos = opts[:position]
    @correct = true
    @clowns_line = opts[:clowns_line]
    @color = opts[:color]
    
	@ahead_reds = 0
	@ahead_blues = 0
	@red = true
  end

  def say_answer
    answer = figure_what_answer_to_say
    @correct = @color == answer
    {color_spoken: answer, correct: @correct, position: @pos}
  end

  def hear_answer_result(heard_answer)
    #This is also where algorithm code would go!

    @pos_last_heard_answer = heard_answer[:position]
    @last_speaker_correct = heard_answer[:correct]
    @color_last_speaker_said = heard_answer[:color_spoken]	

	if @pos_last_heard_answer==0
		if @color_last_speaker_said == :red
			@red = true
		else
			@red = false
		end
	elsif @color_last_speaker_said == :red
		if @red == true
			@red = false
		else
			@red = true
		end
	end
  end

  private

  def figure_what_answer_to_say
    #This is where you put your algorithm!!
    #Make an algorithm that will save the maximum amount of people for sure
	count_hats_ahead
	if pos==0
		if @ahead_reds%2 == 0
			@red=true
			:red
		else
			@red=false
			:blue
		end
		#@ahead_reds%2 == 0 ? :red : :blue
	elsif @red == true
		if @ahead_reds%2 == 0
			:blue
		else
			:red
		end
	else
		if @ahead_reds%2 == 0
			:red
		else
			:blue
		end
	end
  end

  def count_hats_ahead
	@ahead_reds=0
	@ahead_blues=0
    i = pos + 1
    while i < @clowns_line.length
      seen_color = @clowns_line[i].color
      if seen_color == :red
        @ahead_reds += 1
      else
        @ahead_blues += 1
      end
      i += 1
    end
  end

end
