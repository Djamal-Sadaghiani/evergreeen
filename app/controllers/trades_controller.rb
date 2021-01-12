# frozen_string_literal: true

class TradesController < ApplicationController
  before_action :set_trade, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[show index]
  # GET /trades
  # GET /trades.json
  def index
    @trades = Trade.paginate(page: params[:page], per_page: 100)
  end

  # GET /trades/1
  # GET /trades/1.json
  def show; end

  # GET /trades/new
  def new
    @trade = Trade.new
    @product = Product.find_by_id(params["trade"][:product_id])
    @trade.product_id = params["trade"][:product_id].to_i
    @trade.user_id = current_user.id
    @trade.trade_uuid = SecureRandom.uuid
  end

  # GET /trades/1/edit
  def edit; end

  # POST /trades
  # POST /trades.json
  def create
    @trade = Trade.new(trade_params)
    @trade.user = current_user

    respond_to do |format|
      if @trade.save!
        format.html { redirect_to @trade, notice: 'Trade was successfully created.' }
        format.json { render :show, status: :created, location: @trade }
      else
        format.html { render :new }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: 'Trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1
  # DELETE /trades/1.json
  def destroy
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url, notice: 'Trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trade
    @trade = Trade.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trade_params
    params.require(:trade).permit(:trade_uuid, :isin, :name, :time, :price, :amount, :transaction_cost, :investment_hypothesis, :product_id, :user_id)
  end
end
