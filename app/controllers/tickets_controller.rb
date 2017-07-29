class TicketsController < ApplicationController
  before_action :load_ticket, only: %i(edit update show)

  def index
    redirect_to root_path
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_create_params)
    if @ticket.save
      redirect_to [:edit, @ticket], notice: '乗車しました。🚃'
    else
      render :new
    end
  end

  def show
    redirect_to [:edit, @ticket]
  end

  def edit
    stored_record = Ticket.find(@ticket.id)
    redirect_to root_path, alert: '降車済みの切符です。' if stored_record.exited_gate_id
  end

  def update
    stored_record = Ticket.find(@ticket.id)
    return redirect_to root_path, alert: '降車済みの切符です。' if stored_record.exited_gate_id

    if @ticket.update(ticket_update_params)
      redirect_to root_path, notice: '降車しました。😄'
    else
      render :edit
    end
  end

  private

  def ticket_create_params
    params.require(:ticket).permit(:fare, :entered_gate_id)
  end

  def ticket_update_params
    params.require(:ticket).permit(:exited_gate_id)
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end
end
