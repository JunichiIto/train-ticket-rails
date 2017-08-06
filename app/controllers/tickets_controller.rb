class TicketsController < ApplicationController
  before_action :load_ticket, only: %i(edit update show)

  TICKET_GOT_OFF = "降車済みの切符です。".freeze
  CAN_NOT_GET_OFF = "降車駅 では降車できません。".freeze

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
    redirect_to root_path, flash: { error: TICKET_GOT_OFF } if @ticket.exited?
  end

  def update
    if @ticket.exited?
      redirect_to root_path, flash: { error: TICKET_GOT_OFF }
      return
    end

    unless Gate.find(ticket_update_params[:exited_gate_id]).exit?(@ticket)
      @ticket.errors[:base] << CAN_NOT_GET_OFF
      render :edit
      return
    end

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
