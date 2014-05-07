class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @active_curriculums = Curriculum.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_curriculums = Curriculum.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @camps = @curriculum.camps.chronological.to_a
  end

  def new
    authorize! :new, @curriculum
    @curriculum = Curriculum.new
    authorize! :new, @curriculum
  end

  def edit
    authorize! :update, @curriculum
  end

  def create
    authorize! :new, @curriculum
    adjust_ratings
    @curriculum = Curriculum.new(curriculum_params)
    if @curriculum.save
      redirect_to @curriculum, notice: "#{@curriculum.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    adjust_ratings
    if @curriculum.update(curriculum_params)
      redirect_to @curriculum, notice: "#{@curriculum.name} was revised in the system."
    else
      render action: 'edit'
    end
    authorize! :update, @curriculum
  end

  def destroy
    @curriculum.destroy
    redirect_to curriculums_url, notice: "#{@curriculum.name} was removed from the system."
    authorize! :destroy, @curriculum
  end

  def search
    q = params[:camp][:name]
    @curriculums = Curriculum.find(:all, :conditions => ["name LIKE %?%",q])
  end


  private
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    def curriculum_params
      params.require(:curriculum).permit(:name, :description, :min_rating, :max_rating, :active)
    end

    def adjust_ratings
      params[:curriculum][:min_rating] = 0 if params[:curriculum][:min_rating].nil?
      params[:curriculum][:max_rating] = 3000 if params[:curriculum][:max_rating].nil? 
    end


end
