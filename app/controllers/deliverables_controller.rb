class DeliverablesController < ApplicationController
  before_action :set_deliverable, only: %i[show edit update destroy]

  # GET /deliverables or /deliverables.json
  def index
    @deliverables = Deliverable.all
  end

  # GET /deliverables/1 or /deliverables/1.json
  def show; end

  # GET /deliverables/new
  def new
    @deliverable = Deliverable.new
  end

  # GET /deliverables/1/edit
  def edit; end

  # POST /deliverables or /deliverables.json
  def create
    @deliverable = Deliverable.new(deliverable_params)

    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to deliverable_url(@deliverable), notice: 'Deliverable was successfully created.' }
        format.json { render :show, status: :created, location: @deliverable }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deliverable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliverables/1 or /deliverables/1.json
  def update
    respond_to do |format|
      if @deliverable.update(deliverable_params)
        format.html { redirect_to deliverable_url(@deliverable), notice: 'Deliverable was successfully updated.' }
        format.json { render :show, status: :ok, location: @deliverable }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deliverable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliverables/1 or /deliverables/1.json
  def destroy
    @deliverable.destroy!

    respond_to do |format|
      format.html { redirect_to deliverables_url, notice: 'Deliverable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deliverable
    @deliverable = Deliverable.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deliverable_params
    params.require(:deliverable).permit(:name, :deadline, :project_id)
  end
end
