class StaticPagesController < ApplicationController
	
  def home
  end

  def help
  end

  def about
  end

  def high_break
  	p = Player.where('id IN (SELECT DISTINCT(player_id) FROM high_breaks)')
  	@players = p.sort! { |a,b| a.high_break.order('break DESC').first.break <=> 
  		b.high_break.order('break DESC').first.break }.reverse

  end

end
