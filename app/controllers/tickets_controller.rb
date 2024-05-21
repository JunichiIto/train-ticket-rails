class TicketsController < ApplicationController
  before_action :load_ticket, only: %i(edit update show)
  before_action :do_not_use_used_ticket, only: %i(edit update)

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
    exited_gate_id = ticket_update_params[:exited_gate_id]
    @exited_gate = Gate.find(exited_gate_id)
    if @exited_gate.exit?(@ticket)
      @ticket.update(ticket_update_params)
      redirect_to root_path, notice: '降車しました。😄'
    else
      @ticket.errors[:base] << "降車駅 では降車できません。"
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

  def do_not_use_used_ticket
    redirect_to root_path, alert: '降車済みの切符です。' if @ticket.used?
  end
end
