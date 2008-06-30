class PagesController < ApplicationController
  def show
    @page = Page.find_by_name(params[:id])
    raise ActiveRecord::RecordNotFound, "Couldn't find Page with NAME = #{params[:id]}" if @page.nil?
  end
end
