class Admin::CouponCodesController < Admin::ApplicationController
  load_and_authorize_resource
  def index
    @coupon_codes = CouponCode.all.page(params[:page])
  end

  def new
    @coupon_code = CouponCode.new
  end

  def edit
    @coupon_code = CouponCode.find(params[:id])
    @coupon_code.current_step = params[:step] if params[:step]
  end

  def create
    @coupon_code = CouponCode.new(coupon_code_params)
    if @coupon_code.save
      redirect_to admin_coupon_codes_url, flash: { success: 'CouponCode was successfully created.' }
    else
      render :new
    end
  end

  def update
    @coupon_code = CouponCode.find(params[:id])
    if @coupon_code.update(coupon_code_params)
      coupon_code_redirect('CouponCode was successfully updated.')
    else
      render :edit
    end
  end


  private
    def coupon_code_params
      params.require(:coupon_code).permit(:current_step, :code, :percent, :active_from, :active_to, :active, product_ids: [], category_ids: [])
    end

    def coupon_code_redirect(flash)
      if params[:go_to] == 'back'
        @coupon_code.previous_step
      elsif params[:go_to] == 'next'
        @coupon_code.next_step
      end
      redirect_to edit_admin_coupon_code_url(@coupon_code, @coupon_code.current_step), flash: { success: flash }
    end
end
