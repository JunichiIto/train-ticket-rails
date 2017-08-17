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
  end

  def update
    exited_gate = Gate.find(ticket_update_params[:exited_gate_id])
    return redirect_to edit_ticket_path, alert: '降車駅 では降車できません。😢' unless exited_gate.exit?(@ticket)
    return redirect_to root_path, notice: '降車しました。😄' if @ticket.update(ticket_update_params)
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
