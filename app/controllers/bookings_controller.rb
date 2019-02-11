class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    if (!current_user.admin?)
    @user= current_user
    @bookings = @user.bookings.all
  else
    @bookings = Booking.all
  end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  def seatconfirm
    @booking = Booking.find(params[:booking_id])
    if(!Seat.where(:booking_id => @booking.id).exists?)
      price =0
        @booking.seatofbookings.each do |s|
          @seat= Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :seatnumber => s.seatnumber)
          @seat.first.update_attributes(:booking_id => @booking.id, :pnr => @booking.pnr, :available => false)
          if (Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :available => true).size > Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :available => false).size)
          price = price + @seat.first.price
          else
            if (@seat.first.seattype === 'normal')
              price = price + @seat.first.price
            else
              price = price + ((110 * @seat.first.price)/100)
            end
          end
        end
    end
    @booking.update_attributes(:totalprice => price)
    redirect_to booking_path(current_user,@booking.flight,@booking)
  end

  def seatmap
    @booking = Booking.find(params[:booking_id])
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
    if (@booking.seatofbookings.size < @booking.seats)
        if (!@booking.seatofbookings.where(:seatnumber => params[:seatnumber]).exists?)
        @booking.seatofbookings.create(:seatnumber => params[:seatnumber],:booking_id => @booking.id)
        else
        @s = @booking.seatofbookings.where(:seatnumber => params[:seatnumber])
        @s.destroy_all
        end
        if (@price.nil?)
    @price =0
  end 
       @x=0
        @booking.seatofbookings.each do |s|
          @seat= Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :seatnumber => s.seatnumber)
          if ((Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :available => true).size - @x) > (Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :available => false).size + @x))
          @price = @price + @seat.first.price
          elsif((Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :available => true).size - @x) <= (Seat.where(:flight_id => @booking.flight.id, :seatclass => @booking.seatclass, :available => false).size + @x))
            if (@seat.first.seattype === 'normal')
              @price = @price + @seat.first.price
            else
              @price = @price + ((110 * @seat.first.price)/100)
            end
          end
          @x=@x+1
        end
    render '_seatmap'
    elsif (@booking.seatofbookings.size >= @booking.seats)
      flash[:danger]= "Seats are exceeding Booked seats"
    end

  end

  def upgrade
    @booking = Booking.find(params[:booking_id])
  end

  def upgradecreate
    @bookingold = Booking.find(params[:booking_id])
    @booking = @bookingold.user.bookings.new(booking_params)
    respond_to do |format|
      if @booking.save
        @bookingold.destroy
        format.html { redirect_to booking_path(@booking.user,@booking.flight,@booking), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /bookings/new
  def new
    @user = User.find(params[:user_id])
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create

    @user = User.find(params[:user_id])
    @flight = Flight.find(params[:flight_id])
    @booking = @user.bookings.new(booking_params)
    respond_to do |format|
      if @booking.save
        format.html { redirect_to booking_path(current_user,@flight,@booking), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_index_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:pnr, :seats, :seatclass, :dateofjourney, :source, :destination, :flight_id)
    end
end
