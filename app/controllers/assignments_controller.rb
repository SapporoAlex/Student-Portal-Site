class AssignmentsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :upload, :show, :destroy]
  before_action :set_assignment, only: [:destroy]

  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
    if current_user.admin?
      @uploaded_files = @assignment.uploads
    elsif current_user.student?
      @upload = @assignment.uploads.new(user: current_user)
    else
      redirect_to assignments_path, alert: "You are not authorized to view this assignment."
    end
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = current_user.assignments.build(assignment_params)
    if @assignment.save
      redirect_to assignments_path, notice: "Assignment created successfully!"
    else
      render :new
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path, notice: "Assignment was successfully deleted."
  end

  def upload
    @assignment = Assignment.find(params[:assignment_id])
    @upload = @assignment.uploads.new(upload_params)
    @upload.user = current_user
    
    if @upload.save
      flash[:success] = "File uploaded successfully!"
      redirect_to assignment_path(@assignment)
    else
      flash[:error] = "There was an issue uploading your file."
      render :show
    end
  end

  private

  def set_assignment
    @assignment = Assignment.find_by(id: params[:id])
    unless @assignment
      flash[:alert] = "Assignment not found."
      redirect_to root_path
    end
  end

  def assignment_params
    params.require(:assignment).permit(:title, :description, :due_date)
  end
end

def upload_params
  params.require(:upload).permit(:file)
end
