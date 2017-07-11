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
    @ticket.assign_attributes(ticket_update_params)

    if @ticket.save(context: :exit)
      redirect_to root_path, notice: '降車しました。😄'
    else
      flash.now[:alert] = format('%s では降車できません。', @ticket.exited_gate.name)
      render :edit
    end
  end

  private

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
