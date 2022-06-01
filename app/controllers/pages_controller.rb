class PagesController < ApplicationController
  def home
    @posts = Post.all.accessible_by(current_ability)
  end
end
