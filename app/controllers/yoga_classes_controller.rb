class YogaClassesController < ApplicationController
  # GET /yoga_classes
  # GET /yoga_classes.json
  def index
    @date = Time.parse("#{params[:year]}/#{params[:month]}/#{params[:day]}") rescue Time.now
    @todays_yoga_classes = YogaClass.fav_classes_on(@date)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @yoga_classes }
    end
  end

  # GET /yoga_classes/1
  # GET /yoga_classes/1.json
  def show
    @yoga_class = YogaClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @yoga_class }
    end
  end

  # GET /yoga_classes/new
  # GET /yoga_classes/new.json
  def new
    @yoga_class = YogaClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @yoga_class }
    end
  end

  # GET /yoga_classes/1/edit
  def edit
    @yoga_class = YogaClass.find(params[:id])
  end

  # POST /yoga_classes
  # POST /yoga_classes.json
  def create
    @yoga_class = YogaClass.new(params[:yoga_class])

    respond_to do |format|
      if @yoga_class.save
        format.html { redirect_to @yoga_class, notice: 'Yoga class was successfully created.' }
        format.json { render json: @yoga_class, status: :created, location: @yoga_class }
      else
        format.html { render action: "new" }
        format.json { render json: @yoga_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /yoga_classes/1
  # PUT /yoga_classes/1.json
  def update
    @yoga_class = YogaClass.find(params[:id])

    respond_to do |format|
      if @yoga_class.update_attributes(params[:yoga_class])
        format.html { redirect_to @yoga_class, notice: 'Yoga class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @yoga_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yoga_classes/1
  # DELETE /yoga_classes/1.json
  def destroy
    @yoga_class = YogaClass.find(params[:id])
    @yoga_class.destroy

    respond_to do |format|
      format.html { redirect_to yoga_classes_url }
      format.json { head :no_content }
    end
  end
end
