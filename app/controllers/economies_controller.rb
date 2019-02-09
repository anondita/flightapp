class EconomiesController < ApplicationController
  before_action :set_economy, only: [:show, :edit, :update, :destroy]

  # GET /economies
  # GET /economies.json
  def index
    @flight= Flight.find(params[:flight_id])
    @economies = Economy.all
  end

  # GET /economies/1
  # GET /economies/1.json
  def show
  end

  # GET /economies/new
  def new
        @flight = Flight.find(params[:flight_id])
    @economy = Economy.new
  end

  # GET /economies/1/edit
  def edit
  end

  # POST /economies
  # POST /economies.json
  def create
    @flight = Flight.find(params[:flight_id])
    @economy = Economy.new(economy_params)

        respond_to do |format|
      if @economy.save
      
    total = @economy.seat * @economy.row
    @economy.update_attributes(total: total,availability: total)
    @flight.economy = @economy

    @x=1
        loop do
          if ((@x % @economy.seat) == 1 && (@x ==(@economy.emergency*(@economy.seat))- @economy.seat + 1))
            @seat = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @x,seattype: 'window_emergency',price: ((115*@economy.price)/100),flight_id: @flight.id,booking_id: nil)
          elsif ((@x % @economy.seat) == 0)
            @seat = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @x,seattype: 'aisle',:price=> @economy.price,flight_id: @flight.id,booking_id: nil)
          elsif ((@x % @economy.seat == 1)&& (@x % @economy.emergency) > 0)
            @seat = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @x,seattype: 'window',price: @economy.price,flight_id: @flight.id,booking_id: nil)
          else
            @seat = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @x,seattype: 'normal',price: @economy.price,flight_id: @flight.id,booking_id: nil)
          end
          @x+=1
          if(@x>@economy.total)
            break
          end
        end


        format.html { redirect_to @flight, notice: 'Economy Configuration was updated successfully.' }
        format.json { render :show, status: :created, location: @economy }
      else
        format.html { render :new }
        format.json { render json: @economy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /economies/1
  # PATCH/PUT /economies/1.json
  def update
    respond_to do |format|
      if @economy.update(economy_params)
        format.html { redirect_to @economy, notice: 'Economy was successfully updated.' }
        format.json { render :show, status: :ok, location: @economy }
      else
        format.html { render :edit }
        format.json { render json: @economy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /economies/1
  # DELETE /economies/1.json
  def destroy
    @economy.destroy
    respond_to do |format|
      format.html { redirect_to economies_url, notice: 'Economy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_economy
      @economy = Economy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def economy_params
      params.require(:economy).permit(:seat, :row, :price, :emergency)
    end
end
