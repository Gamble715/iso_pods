class VisitsController < ApplicationController
  protect_from_forgery with: :null_session

  # before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  # before_action :set_visit, only: [:show, :edit, :update, :destroy]

  # GET /visits
  # GET /visits.json
  def index
    @visits = Visit.all
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
    @code = Visit.find(params[:id]).pod.door_code
  end

  def exit

  end

  def end
    visit = Visit.find(params[:end][:id])


    begin_time = visit.created_at
    end_time = Time.now
    total_time = end_time - begin_time
    minutes = total_time/60
    hours = minutes/60
    @hours = (minutes/60).to_i
    @minutes = (minutes%60).round
    if @minutes < 10
      @minutes = sprintf '%02d', @minutes
    end

    @amount = (hours*2)*10

    if minutes%30 > 5
      @amount+=10
    end

    cents = (@amount*100)

    unless cents = 0
      Stripe::Charge.create(
          :amount => cents, # incents
          :currency => "usd",
          :customer => visit.customer_id
      )
      visit.destroy
    end

  end

  # GET /visits/new
  def new
    @visit = Visit.new
  end

  # GET /visits/1/edit
  def edit
  end

  # POST /visits
  # POST /visits.json
  def create
    @visit = Visit.new(visit_params)
    @visit.pod_id = Pod.last.id

      # Amount in cents
      @amount = 500
      puts params[:stripeToken]

      customer = Stripe::Customer.create(
        :email => params[:email],
        :card  => params[:stripeToken]
      )

      @visit.customer_id = customer.id

      # charge = Stripe::Charge.create(
      #   :customer    => customer.id,
      #   :amount      => @amount,
      #   :description => 'Rails Stripe customer',
      #   :currency    => 'usd'
      # )

    # rescue Stripe::CardError => e
    #   flash[:error] = e.message
    #   redirect_to charges_path
    # end

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: 'Enjoy your quiet time.' }
      else
        # format.html { render :new }
        # format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to @visit, notice: 'Visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { render :edit }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      # params.require(:visit).permit(:user_id, :pod_id)
    end
end
