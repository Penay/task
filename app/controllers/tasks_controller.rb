class TasksController < ApplicationController
   before_filter :signed_in_user
   before_filter :check_owner, :except => [:index, :new, :create]

   def check_owner
     current_task = Task.find(params[:id])
    unless Appointment.where("task_id like ? and user_id like ?", current_task.id, current_user.id).first
      redirect_to root_path
      flash[:error] = "You are not allowed to be here!"
    end
   end
  # GET /tasks
  # GET /tasks.json
  def index
     @tasks = current_user.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    appointment = Appointment.new(user_id: current_user.id, task: @task.id)
    respond_to do |format|
      if @task.save
        appointment.task_id = @task.id
       appointment.save
        format.html { redirect_to @task, :success => 'Task was successfully created.' }
        format.json { render :json => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, :notice => 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def share
    @task = Task.find(params[:id])
    @user = User.all
  end

  def add_owner
    @task = Task.find(params[:id])
    user = User.find_by_email(params[:owner])
    begin
      appointment = Appointment.create(task_id: @task.id, user_id: user.id)
      @task.shared_by = current_user.email
        @task.save
        flash[:success] = "Your task successfully shared"
        redirect_to @task
      rescue ActiveRecord::RecordNotUnique
        redirect_to :back
        flash[:error] = "This task is already shared with this user"
    end
  end
end