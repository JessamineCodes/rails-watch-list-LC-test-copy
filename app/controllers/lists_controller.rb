class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
  end

  def new
  end

  def create

  end
end
