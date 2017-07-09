class TicketsController < ApplicationController
  before_action :load_ticket, only: %i(edit update)

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_create_params)
    if @ticket.save
      redirect_to [:edit, @ticket], notice: '乗りました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_update_params)
      redirect_to root_path, notice: '降りました。'
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
