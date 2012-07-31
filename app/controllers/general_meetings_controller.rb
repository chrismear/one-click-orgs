class GeneralMeetingsController < ApplicationController
  def new
    @general_meeting = co.general_meetings.build

    @draft_resolutions = co.resolutions.draft
    if params[:resolution_id].present?
      @draft_resolutions.find_by_id(params[:resolution_id]).try(:attached=, '1')
    end

    @directors_retiring = co.directors_retiring
  end

  def create
    @general_meeting = co.build_general_meeting_or_annual_general_meeting (params[:general_meeting])
    @general_meeting.save!
    redirect_to meetings_path
  end
end
