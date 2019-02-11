class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seat, only: [:show, :edit, :update, :destroy]

  # GET /seats
  # GET /seats.json
  def indexfirst
    @flight = Flight.find(params[:flight_id])
    @first = @flight.firstclass
    @seats = Seat.where(flight_id: params[:flight_id], seatclass: 'first').order(:seatnumber)
  end

  def indexeconomy
     @flight = Flight.find(params[:flight_id])
     @economy = @flight.economy
    @seats = Seat.where(flight_id: params[:flight_id], seatclass: 'economy').order(:seatnumber)
  end

  def indexbusiness
     @flight = Flight.find(params[:flight_id])
     @business= @flight.business
    @seats = Seat.where(flight_id: params[:flight_id], seatclass: 'business').order(:seatnumber)
  end

  # GET /seats/1
  # GET /seats/1.json
  def show
  end

  # GET /seats/new
  def new
    @seat = Seat.new
  end

  def createeco
    @flight= Flight.find(params[:flight_id])
    @economy = @flight.economy
    puts @economy.seat
     
        redirect_to seat_path(@flight)
  end

  # GET /seats/1/edit
  def edit
  end

  # POST /seats
  # POST /seats.json
  # PATCH/PUT /seats/1
  # PATCH/PUT /seats/1.json
  # DELETE /seats/1
  # DELETE /seats/1.json
  def destroy
    @seat.destroy
    respond_to do |format|
      format.html { redirect_to seats_url, notice: 'Seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seat
      @seat = Seat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seat_params
      params.require(:seat).permit(:seatclass, :pnr, :seatnumber, :seattype, :price)
    end
end
