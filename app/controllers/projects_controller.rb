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
      redirect_to @project, notice: c_t('success.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if ::Projects::Update.new(@project, project_params).call.successful
      redirect_to @project, notice: c_t('success.update'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    if ::Projects::Destroy.new(@project).call.successful
      redirect_to projects_url, notice: c_t('success.destroy'), status: :see_other
    else
      redirect_to projects_url, notice: c_t('error.destroy'), status: :see_other
    end
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
