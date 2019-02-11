class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  # GET /businesses
  # GET /businesses.json
  def index
    @flight= Flight.find(params[:flight_id])
    @businesses = Business.all
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
  end

  # GET /businesses/new
  def new
    @flight = Flight.find(params[:flight_id])
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @flight = Flight.find(params[:flight_id])
    @business = Business.new(business_params)
  
    respond_to do |format|
      if @business.save

    total = @business.seat * @business.row
    @business.update_attributes(total: total,availability: total)
      @flight.business = @business
     
     @x=1
        loop do
          if ((@x % @business.seat) == 1 && (@x ==(@business.emergency * @business.seat) - @business.seat + 1))
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @x,seattype: 'window_emergency',price: ((115*@business.price)/100),flight_id: @flight.id,booking_id: nil)
          elsif ((@x % @business.seat) == 0)
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @x,seattype: 'aisle',:price=> @business.price,flight_id: @flight.id,booking_id: nil)
          elsif ((@x % @business.seat == 1)&& (@x % @business.emergency) > 0)
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @x,seattype: 'window',price: @business.price,flight_id: @flight.id,booking_id: nil)
          else
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @x,seattype: 'normal',price: @business.price,flight_id: @flight.id,booking_id: nil)
          end
          @x+=1
          if(@x>@business.total)
            break
          end
        end
    
        
        format.html { redirect_to @flight, notice: 'Business Configuration was updated successfully.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:seat, :row, :price, :emergency)
    end
end
