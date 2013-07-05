
class CampaignsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @campaigns = Campaign.all
    @topics = Topic.all
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.create(params[:campaign])
    if @campaign.valid?
      campaign_user = CampaignUser.create(campaign_id: @campaign.id, user_id: current_user.id, :user_type => "Creator")
      ScheduledWorker.perform_in(100.seconds, @campaign.id)
      redirect_to @campaign
    else
      @errors = @campaign.errors.full_messages
      render :new
    end
  end

  def show
    session.delete(:campaign_id) if session[:campaign_id]
    @support = current_user.supported_campaigns if current_user
    @campaign = Campaign.find_by_id(params[:id])
    @ids = CampaignUser.where(campaign_id: @campaign.id, user_type: "Supporter").pluck("user_id")
  end

  def update
  end

  def destroy
  end
end
