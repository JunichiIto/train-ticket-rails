class TicketsController < ApplicationController
  before_action :load_ticket, only: %i(edit update show)
  before_action :redirect_root_if_ticket_exited, only: %i(edit update)

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

  # チケットが使用済みならrootに飛ばす、のメソッド名に悩む
  def redirect_root_if_ticket_exited
    redirect_to root_path, notice: '降車済みの切符です。' and return if @ticket.exited?
  end
end
