class HomeController < ApplicationController

  def index
  	@data=[]
  	Order.data_count.each_with_index do|d,idx|
   	@data<<[d[:name],d[:count]]
  	end
  end

end