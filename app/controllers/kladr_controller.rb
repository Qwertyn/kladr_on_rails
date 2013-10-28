class KladrController < ApplicationController
  def index
    @regions = Kladr.regions
  end

  def show
    @entity = Kladr.find_by_code(params[:code])

    parent = @entity.parent
    while !parent.nil? do
      @parents = [parent] + (@parents || [])
      parent = parent.parent
    end

    @children = @entity.children
    @street = @entity.street
    @doma = @entity.doma
  end
  
  def street
    @entity = Street.find_by_code(params[:code])
    @doma = @entity.doma
  end
  
  def doma
    @entity = Doma.find_by_code(params[:code])
  end

end
