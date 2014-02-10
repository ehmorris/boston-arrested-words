class CrimesController < ApplicationController
  def show
    @crime = Crime.all
  end
end
