class TicketsController < ApplicationController
  before_action :load_ticket, only: %i(edit update show)
  before_action :abort_exited_ticket, only: %i(edit update)

  def index
    redirect_to root_path
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_create_params)
    if @ticket.save
      redirect_to [:edit, @ticket], notice: '乗車しました。'
    else
      flash_for_error
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
      redirect_to root_path, notice: '降車しました。'
    else
      flash_for_error
      render :edit
    end
  end

  private

  def abort_exited_ticket
    if @ticket.exited?
      redirect_to root_path, notice: '降車済みの切符です。'
    end
  end

  def flash_for_error
    flash.now[:alert] = '入力値に問題があります。'
  end

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
