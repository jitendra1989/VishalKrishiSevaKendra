class Admin::ContentPagesController < Admin::ApplicationController
  before_action :set_content_page, only: [:edit, :update, :destroy]
  authorize_resource

  def index
    @content_pages = ContentPage.all
  end

  def new
    @content_page = ContentPage.new
  end

  def edit
  end

  def create
    @content_page = ContentPage.new(content_page_params)
    if @content_page.save
      redirect_to admin_content_pages_url, flash: { success: 'ContentPage was successfully created.' }
    else
      render :new
    end
  end

  def update
    if @content_page.update(content_page_params)
      redirect_to admin_content_pages_url, flash: { success: 'ContentPage was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @content_page.destroy
    redirect_to admin_content_pages_url, flash: { info: 'ContentPage was successfully deleted.' }
  end

  private
    def content_page_params
      params.require(:content_page).permit(:title, :image, :content, :slug, :menu, :link_text)
    end

    def set_content_page
      @content_page = ContentPage.friendly.find(params[:id])
    end
end
