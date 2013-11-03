module ApplicationHelper
	def get_rank(x)
      case x
        when 1
          "1"
        when 2
          "2"
        when 3
          "3-4"
        when 4
          "5-8"
        when 5
          "9-16"
        when 6
          "17-20"
        when 7
          "21-24"
        when 8
          "25-32"
        when 9
          "33-40"
        else
          "Uden for rækkevidde"
        end     
    end
end
