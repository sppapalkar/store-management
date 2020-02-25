class AdminController < ApplicationController
  def index
    unless user_signed_in? and current_user.admin
      redirect_to root_path, notice: 'You dont have the rights to access the page'
    end
  end
  def approvals
    @order_items = Orderitem.where(status: 'Pending Approval')
  end
  def returns
    @order_items = Orderitem.where(status: 'Return Requested')
  end
  def approve
    parameters = orderitem_params
    order = Order.find(parameters[:order_id])
    orderitem = Orderitem.find(parameters[:orderitem_id])
    unless orderitem.nil?
      if orderitem.status == 'Pending Approval'
        orderitem.update(status: 'Purchased')
      elsif orderitem.status == 'Return Requested'
        orderitem.update(status: 'Returned')
      end
    end
    redirect_to order_manage_path(order), notice: 'Status Updated'
  end
  def reject
    parameters = orderitem_params
    order = Order.find(parameters[:order_id])
    orderitem = Orderitem.find(parameters[:orderitem_id])
    unless orderitem.nil?
      if orderitem.status == 'Pending Approval'
        orderitem.update(status: 'Request Rejected - Refunded')
      elsif orderitem.status == 'Return Requested'
        orderitem.update(status: 'Return Request Rejected')
      end
    end
    redirect_to order_manage_path(order), notice: 'Status Updated'
  end
  private
  def orderitem_params
    params.permit(:order_id, :orderitem_id)
  end
end