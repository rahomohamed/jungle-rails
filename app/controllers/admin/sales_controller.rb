class Admin::SalesController < ApplicationController
  def index
    @sales = Sale.all
  end
end
