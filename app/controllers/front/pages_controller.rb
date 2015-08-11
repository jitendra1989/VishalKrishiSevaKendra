class Front::PagesController < Front::ApplicationController

	def show
		@page = ContentPage.friendly.find(params[:id])
	end

  def about
  end

  def projects
  end

  def clients
  end

  def contact
  end
end
