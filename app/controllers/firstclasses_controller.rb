class FirstclassesController < ApplicationController
  before_action :set_firstclass, only: [:show, :edit, :update, :destroy]

  # GET /firstclasses
  # GET /firstclasses.json
  def index
    @flight= Flight.find(params[:flight_id])
    @firstclasses = Firstclass.all
  end

  # GET /firstclasses/1
  # GET /firstclasses/1.json
  def show
  end

  # GET /firstclasses/new
  def new
        @flight = Flight.find(params[:flight_id])
    @firstclass = Firstclass.new
  end

  # GET /firstclasses/1/edit
  def edit
  end

  # POST /firstclasses
  # POST /firstclasses.json
  def create
     @flight = Flight.find(params[:flight_id])
     @firstclass = Firstclass.new(firstclass_params)

     respond_to do |format|
      if @firstclass.save
     total = @firstclass.seat * @firstclass.row
    @firstclass.update_attributes(total: total,availability: total)
         @flight.firstclass = @firstclass
     
      @x=1
        loop do
          if ((@x % @firstclass.seat == 1) && (@x == ((@firstclass.emergency * @firstclass.seat)- @firstclass.seat + 1)))
            @seat = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'window_emergency',price: ((115*@firstclass.price)/100),flight_id: @flight.id,booking_id: nil)
          elsif (@x % @firstclass.seat == 0)
            @seat = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'aisle',:price=> @firstclass.price,flight_id: @flight.id,booking_id: nil)
          elsif (@x % @firstclass.seat == 1 && @x % @firstclass.emergency > 0)
            @seat = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'window',price: @firstclass.price,flight_id: @flight.id,booking_id: nil)
          else
            @seat = @flight.seats.create(seatclass:'first',pnr: 0,seatnumber: @x,seattype: 'normal',price: @firstclass.price,flight_id: @flight.id,booking_id: nil)
          end
          @x+=1
          if(@x>@firstclass.total)
            break
          end
        end

    
       
        format.html { redirect_to @flight, notice: 'Firstclass Configuration was updated successfully.' }
        format.json { render :show, status: :created, location: @firstclass }
      else
        format.html { render :new }
        format.json { render json: @firstclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /firstclasses/1
  # PATCH/PUT /firstclasses/1.json
  def update
    respond_to do |format|
      if @firstclass.update(firstclass_params)
        format.html { redirect_to @firstclass, notice: 'Firstclass was successfully updated.' }
        format.json { render :show, status: :ok, location: @firstclass }
      else
        format.html { render :edit }
        format.json { render json: @firstclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firstclasses/1
  # DELETE /firstclasses/1.json
  def destroy
    @firstclass.destroy
    respond_to do |format|
      format.html { redirect_to firstclasses_url, notice: 'Firstclass was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firstclass
      @firstclass = Firstclass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firstclass_params
      params.require(:firstclass).permit(:seat, :row, :price, :emergency)
    end
end
