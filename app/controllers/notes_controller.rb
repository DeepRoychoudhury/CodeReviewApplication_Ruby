require 'notifyuser'
require 'notifier'

class NotesController < ApplicationController
  def index
  	@project=Project.find(params[:project_id])
  	@notes=Note.all.where(:project_id => @project.id)
  end

  def new
  	@project=Project.find(:project_id)
  	@note=@project.notes.build
  end
  	
  def show 
  	@project=Project.find(params[:project_id])  	
  	@note=@project.note
  end

  def edit      
    @project=Project.find(params[:project_id])  
    @note=Note.find(params[:id])
  end

  def create  	
  	@project=Project.find(:project_id)
  	@note=@project.notes.build(params.require(:note).permit(:notepad,:notify,:project_id))

  	respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end	

  def update
    @note=Note.find(params[:id])
      @notification=@note.notify
     @notifyuser=NotifyUser.new(@note.id,@note.notepad,@note.notify,current_user.id) 
     @notifier=Notifier.new(@notifyuser)

    @project=Project.all.where(:id => @note.project_id)
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to project_note_path(@project.pluck(:id),@note), notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
        @notifyuser.notepad=@note.notepad
  end

  def note_params
      params.require(:note).permit(:notepad, :notify, :project_id)
  end
end
