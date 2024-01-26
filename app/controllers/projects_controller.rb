# frozen_string_literal: true

# ProjectsController
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show; end

  # GET /projects/new
  def new
    @project = ::Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  def create
    @project = ::Projects::Create.new(project_params).call.record

    if @project.persisted?
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if ::Projects::Update.new(@project, project_params).call.successful
      redirect_to @project, notice: 'Project was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    ::Projects::Destroy.new(@project).call
    redirect_to projects_url, notice: 'Project was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = ::Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
