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
      redirect_to admin_coupon_codes_url, flash: { success: 'CouponCode was successfully updated.' }
    else
      render :edit
    end
  end


  private
    def coupon_code_params
      params.require(:coupon_code).permit(:code, :percent, :active_from, :active_to, :active)
    end
end
