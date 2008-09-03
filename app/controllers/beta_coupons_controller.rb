class BetaCouponsController < ApplicationController
  
  before_filter :login_required, :admin_required
  
  # GET /beta_coupons
  # GET /beta_coupons.xml
  def index
    @beta_coupons = BetaCoupon.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beta_coupons }
    end
  end

  # GET /beta_coupons/1
  # GET /beta_coupons/1.xml
  def show
    @beta_coupon = BetaCoupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beta_coupon }
    end
  end

  # GET /beta_coupons/new
  # GET /beta_coupons/new.xml
  def new
    @beta_coupon = BetaCoupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beta_coupon }
    end
  end

  # GET /beta_coupons/1/edit
  def edit
    @beta_coupon = BetaCoupon.find(params[:id])
  end

  # POST /beta_coupons
  # POST /beta_coupons.xml
  def create
    @beta_coupon = BetaCoupon.new(params[:beta_coupon])

    respond_to do |format|
      if @beta_coupon.save
        flash[:notice] = 'BetaCoupon was successfully created.'
        format.html { redirect_to(@beta_coupon) }
        format.xml  { render :xml => @beta_coupon, :status => :created, :location => @beta_coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @beta_coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beta_coupons/1
  # PUT /beta_coupons/1.xml
  def update
    @beta_coupon = BetaCoupon.find(params[:id])

    respond_to do |format|
      if @beta_coupon.update_attributes(params[:beta_coupon])
        flash[:notice] = 'BetaCoupon was successfully updated.'
        format.html { redirect_to(@beta_coupon) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beta_coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_coupons/1
  # DELETE /beta_coupons/1.xml
  def destroy
    @beta_coupon = BetaCoupon.find(params[:id])
    @beta_coupon.destroy

    respond_to do |format|
      format.html { redirect_to(beta_coupons_url) }
      format.xml  { head :ok }
    end
  end
end
