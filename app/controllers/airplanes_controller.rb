class AirplanesController < ApplicationController
  before_action :set_airplane, only: [:show, :edit, :update, :destroy]

  # GET /airplanes
  # GET /airplanes.json
  def index
    @airplanes = Airplane.all
  end

  # GET /airplanes/1
  # GET /airplanes/1.json
  def show
  end

  # GET /airplanes/new
  def new
    @airplane = Airplane.new
  end

  # GET /airplanes/1/edit
  def edit
  end

  def flightnew
    @airplane = Airplane.find(params[:airplane_id])
    @flight = @airplane.flights.new
  end


  def flightcreate
    @airplane = Airplane.find(params[:airplane_id])
    @flight = @airplane.flights.new(flight_params)
    @totalfirst = @airplane.firstseat * @airplane.firstrow
        @first = Firstclass.new(seat: @airplane.firstseat,row: @airplane.firstrow,emergency: @airplane.firstemer,price: @airplane.firstprice,total: @totalfirst,availability: @totalfirst)
        @totalbus = @airplane.busseat * @airplane.busrow
        @bus = Business.new(seat: @airplane.busseat,row: @airplane.busrow,emergency: @airplane.busemer,price: @airplane.busprice,total: @totalbus,availability: @totalbus)
        @totaleco = @airplane.ecoseat * @airplane.ecorow
        @eco = Economy.new(seat: @airplane.ecoseat,row: @airplane.ecorow,emergency: @airplane.ecoemer,price: @airplane.ecoprice,total: @totaleco,availability: @totaleco)
      respond_to do |format|
      if (@flight.save)
        @flight.firstclass = @first
        @flight.business = @bus
        @flight.economy = @eco
        puts 'agdkauhdlaieuf'
        if(@first.save)
         
          @x=1
          
        loop do
          if ((@x % @first.seat == 1) && (@x == ((@first.emergency * @first.seat)- @first.seat + 1)))
            @seatf = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'window_emergency',price: ((115*@first.price)/100),flight_id: @flight.id,booking_id: nil)
          elsif (@x % @first.seat == 0)
            @seatf = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'aisle',:price=> @first.price,flight_id: @flight.id,booking_id: nil)
          elsif (@x % @first.seat == 1 && @x % @first.emergency > 0)
            @seatf = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'window',price: @first.price,flight_id: @flight.id,booking_id: nil)
          else
            @seatf = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'normal',price: @first.price,flight_id: @flight.id,booking_id: nil)
          end
          @x+=1
          if(@x>@first.total)
            break
          end
        end
      end
        if (@eco.save)

          @y=1

        loop do
          if ((@y % @eco.seat) == 1 && (@y ==(@eco.emergency*(@eco.seat))- @eco.seat + 1))
            @seate = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @y,seattype: 'window_emergency',price: ((115*@eco.price)/100),flight_id: @flight.id,booking_id: nil)
          elsif ((@y % @eco.seat) == 0)
            @seate = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @y,seattype: 'aisle',:price=> @eco.price,flight_id: @flight.id,booking_id: nil)
          elsif ((@y % @eco.seat == 1)&& (@y % @eco.emergency) > 0)
            @seate = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @y,seattype: 'window',price: @eco.price,flight_id: @flight.id,booking_id: nil)
          else
            @seate = @flight.seats.create(seatclass:'economy',pnr: 0,seatnumber: @y,seattype: 'normal',price: @eco.price,flight_id: @flight.id,booking_id: nil)
          end
          @y+=1
          puts @y
          if(@y>@eco.total)
            break
          end
        end

      end
      if(@bus.save)

        @z=1

        loop do
          if ((@z % @bus.seat) == 1 && (@z ==(@bus.emergency * @bus.seat) - @bus.seat + 1))
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @z,seattype: 'window_emergency',price: ((115*@bus.price)/100),flight_id: @flight.id,booking_id: nil)
          elsif ((@z % @bus.seat) == 0)
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @z,seattype: 'aisle',:price=> @bus.price,flight_id: @flight.id,booking_id: nil)
          elsif ((@z % @bus.seat == 1)&& (@z % @bus.emergency) > 0)
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @z,seattype: 'window',price: @bus.price,flight_id: @flight.id,booking_id: nil)
          else
            @seat = @flight.seats.create(seatclass:'business',pnr: 0,seatnumber: @z,seattype: 'normal',price: @bus.price,flight_id: @flight.id,booking_id: nil)
          end
          @z+=1
          puts @z
          if(@z>@bus.total)
            break
          end

        end
      end
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :new, status: :created, location: @flight }

      else
        format.html { render :flightnew }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end

  end

  # POST /airplanes
  # POST /airplanes.json
  def create
    @airplane = Airplane.new(airplane_params)

    respond_to do |format|
      if @airplane.save
        format.html { redirect_to @airplane, notice: 'Airplane was successfully created.' }
        format.json { render :show, status: :created, location: @airplane }
      else
        format.html { render :new }
        format.json { render json: @airplane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airplanes/1
  # PATCH/PUT /airplanes/1.json
  def update
    respond_to do |format|
      if @airplane.update(airplane_params)
        format.html { redirect_to @airplane, notice: 'Airplane was successfully updated.' }
        format.json { render :show, status: :ok, location: @airplane }
      else
        format.html { render :edit }
        format.json { render json: @airplane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airplanes/1
  # DELETE /airplanes/1.json
  def destroy
    @airplane.destroy
    respond_to do |format|
      format.html { redirect_to airplanes_url, notice: 'Airplane was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airplane
      @airplane = Airplane.find(params[:id])
    end

    def flight_params
      params.require(:flight).permit(:name, :source, :destination, :depart, :arrive, :dateofflight)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def airplane_params
      params.require(:airplane).permit(:name, :typeofplane, :firstseat, :firstemer, :firstprice, :firstrow, :busseat, :busemer, :busprice, :busrow, :ecoseat, :ecoemer, :ecoprice, :ecorow)
    end
end
