class Admin::PagesController < Admin::ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy]
  authorize_resource :content_page, parent: false
  def index
    @pages = ContentPage.all
  end

  def new
    @page = ContentPage.new
  end

  def edit
  end

  def create
    @page = ContentPage.new(page_params)
    if @page.save
      redirect_to admin_pages_url, flash: { success: 'Page was successfully created.' }
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to admin_pages_url, flash: { success: 'Page was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_url, flash: { info: 'Page was successfully deleted.' }
  end

  private
    def page_params
      params.require(:content_page).permit(:title, :slug, :image, :content, :menu, :link_text)
    end

    def set_page
      @page = ContentPage.friendly.find(params[:id])
    end
end
