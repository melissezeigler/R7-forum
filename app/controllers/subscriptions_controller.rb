class SubscriptionsController < ApplicationController
  before_action :check_logon
  before_action :set_forum, only: %w[new create]
  before_action :set_subscription, only: %w[show edit update destroy]

  # GET /subscriptions or /subscriptions.json
  def index
    @forums = Forum.joins(:subscriptions).where(subscriptions: {user_id: @current_user.id}).order(:priority)
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    if @forum.subscriptions.where(user_id: @current_user.id).any?
      redirect_to forums_path, notice: "You are already subscribed to that forum."
    else
      @subscription = @current_user.subscriptions.new
      @subscription.forum_id = @forum.id
    end
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions or /subscriptions.json
  def create
    @subscription = @current_user.subscriptions.new(subscription_params)
    @subscription.forum_id = @forum.id

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully created." }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def check_logon
    unless @current_user
      redirect_to forums_path, notice: "You can't access subscriptions unless you are logged in."
    end
  end

  def set_forum
    @forum = Forum.find(params[:forum_id])
  end

  def set_subscription
    @subscription = Subscription.find_by(id: params[:id], user_id: @current_user.id)
  end

  def subscription_params
    params.require(:subscription).permit(:priority)
  end
  # Checking for duplicate user
  def new
    if @forum.subscriptions.where(user_id: @current_user.id).any?
      redirect_to forums_path, notice: "You are already subscribed to that forum."
    else
      @subscription = @current_user.subscriptions.new
      @subscription.forum_id = @forum.id
    end
  end
end
