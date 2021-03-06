module Admin
  class CampaignsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Campaign.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Campaign.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def send_test
      campaign = Campaign.find(params[:id])
      campaign.send_test
    end

    def schedule
      campaign = Campaign.find(params[:id])
      campaign.schedule
    end

  end
end
