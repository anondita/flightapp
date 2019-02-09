class FlightsController < ApplicationController
before_action :set_flight, only: [:show, :edit, :update, :destroy]
  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
  end

  def seatmap
    @pnr = params[:pnr]
    @bookings = Booking.where(:pnr => @pnr)
    @booking = @bookings.last
    if (@booking.nil?)
          if (params[:booking_id] == nil)
            
            redirect_to root_path, alert: "Enter a valid pnr number"
            return
          else
              @booking = Booking.find(params[:booking_id])
          end
    end
    @booking.seatofbookings.destroy_all
    puts @booking
    puts @booking.flight.id
      if (@booking.seatclass==='first')
        @seater = @booking.flight.firstclass.seat
        @seats = Seat.where(:flight_id => @booking.flight.id, :seatclass => 'first').order(:seatnumber)
      elsif (@booking.seatclass==='business')
        @seater = @booking.flight.business.seat
        @seats = Seat.where(:flight_id => @booking.flight.id, :seatclass => 'business').order(:seatnumber)
      else
        @seater = @booking.flight.economy.seat
        @seats = Seat.where(:flight_id => @booking.flight.id, :seatclass => 'economy').order(:seatnumber)
      end
    puts @seats
    puts @seater
  end

  def finder
  end

  def finderc
    @date = params[:dateofflight]
    @source = params[:source]
    @dest = params[:destination]

    if((@date === "") && (@source === "") && (@dest === ""))
      @flights = Flight.all
      puts 1
    elsif((@date === "") && (@dest === ""))
      @flights = Flight.where(source: @source)
      puts 5
    elsif((@date === "") && (@source === ""))
      @flights = Flight.where(destination: @dest)
      puts 6
    elsif((@source === "") && (@dest === ""))
      @flights = Flight.where(dateofflight: @date)
      puts 7
    elsif (@date === "")
      @flights = Flight.where(source: @source,destination: @dest)
      puts 1
    elsif(@source === "")
      @flights= Flight.where(dateofflight: @date,destination: @dest)
      puts 2
    elsif(@dest === "")
      @flights= Flight.where(dateofflight: @date,source: @source)
      puts 3
    else
      @flights = Flight.where(dateofflight: @date,source: @source, destination: @dest)
      puts 8
    end
    if (!@flights.exists?)
    redirect_to flights_finder_path, alert: "Sorry no flights available for the given data"
    puts 'hygikujhoik'
    else
      render :book
    end
  end

  def home
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
  end

  def seatcon
    @flight = Flight.find(params[:id])
    puts @flight.id
    @firstclass = Firstclass.where(:flight_id => @flight.id)
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :new, status: :created, location: @flight }
      else
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.require(:flight).permit(:name, :source, :destination, :depart, :arrive, :dateofflight)
    end

    def find_params
      params.permit(:dateofflight,:source,:destination)
    end
end
