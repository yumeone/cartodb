class UserMailer < ActionMailer::Base
  default from: Cartodb.get_config(:mailer, 'from')
  layout 'mail'

  GREETINGS = %w(congrats congratulations cool awesome hooray nice wow rad bravo yay boom).freeze

  def new_organization_user(user)
    @user = user
    @organization = @user.organization
    @owner = @organization.owner
    @subject = "You have been invited to CARTO organization '#{@organization.name}'"
    base_url = CartoDB.base_url(@organization.name, @user.username)

    if @user.enable_account_token.nil?
      @link = base_url
    else
      path = CartoDB.path(self, 'enable_account_token_show', id: @user.enable_account_token)
      @enable_account_link = "#{base_url}#{path}"
    end

    @user_needs_password = user_needs_password(user)

    mail to: @user.email, subject: @subject
  end

  def share_table(table, user)
    @table_visualization = table
    @user = user
    organization = @table_visualization.user.organization
    visualization_username = @table_visualization.user.username
    path = CartoDB.path(self, 'public_tables_show_bis', id: "#{visualization_username}.#{@table_visualization.name}")
    @link = "#{CartoDB.base_url(organization.name, @user.username)}#{path}"
    @subject = "#{visualization_username} has shared a CARTO dataset with you"
    mail to: @user.email, subject: @subject
  end

  def share_visualization(visualization, user)
    @visualization = visualization
    @user = user

    # This presenter has limited compatibility with old Visualization models
    visualization_presenter = Carto::Api::VisualizationPresenter.new(visualization, user, self)
    @link = visualization_presenter.privacy_aware_map_url
    @subject = "#{@visualization.user.username} has shared a CARTO map with you"
    mail to: @user.email, subject: @subject
  end

  def unshare_table(table_visualization_name, table_visualization_owner_name, user)
    @table_visualization_name = table_visualization_name
    @table_visualization_owner_name = table_visualization_owner_name
    @user = user
    @subject = "#{@table_visualization_owner_name} has stopped sharing a CARTO dataset with you"
    mail to: @user.email, subject: @subject
  end

  def unshare_visualization(visualization_name, visualization_owner_name, user)
    @visualization_name = visualization_name
    @visualization_owner_name = visualization_owner_name
    @user = user
    @subject = "#{@visualization_owner_name} has stopped sharing a CARTO map with you"
    mail to: @user.email, subject: @subject
  end

  def map_liked(visualization, viewer_user, visualization_preview_image)
    @user = visualization.user
    @map_name = visualization.name
    @viewer_name = viewer_user.name_or_username
    @preview_image = visualization_preview_image
    @subject = "Your map got some love!"
    @greetings = GREETINGS
    mail_tracker = get_mail_tracker('like_map')
    path = CartoDB.path(self, 'public_visualizations_show_map', id: visualization.id)
    @link = "#{@user.public_url}#{path}#{mail_tracker}"
    @viewer_maps_link = "#{viewer_user.public_url}#{CartoDB.path(self, 'public_maps_home')}"
    mail to: @user.email, subject: @subject
  end

  def table_liked(canonical_visualization, viewer_user, visualization_preview_image)
    @user = canonical_visualization.user
    @dataset_name = canonical_visualization.name
    @viewer_name = viewer_user.name_or_username
    @preview_image = visualization_preview_image
    @subject = "Your dataset got some love!"
    @greetings = GREETINGS
    mail_tracker = get_mail_tracker('like_map')
    path = CartoDB.path(self, 'public_visualizations_show', id: canonical_visualization.id)
    @link = "#{@user.public_url}#{path}#{mail_tracker}"
    @viewer_datasets_link = "#{viewer_user.public_url}#{CartoDB.path(self, 'public_datasets_home')}"
    mail to: @user.email, subject: @subject
  end

  def trending_map(visualization, mapviews, visualization_preview_image)
    @user = visualization.user
    @mapviews = mapviews
    @map_name = visualization.name
    @preview_image = visualization_preview_image
    @subject = "Recent activity on one of your maps!"
    @greetings = GREETINGS
    mail_tracker = get_mail_tracker('trending_map')
    path = CartoDB.path(self, 'public_visualizations_show_map', id: visualization.id)
    @link = "#{@user.public_url}#{path}#{mail_tracker}"
    mail to: @user.email, subject: @subject
  end

  def password_reset(user)
    @user = user
    @subject = "Reset CARTO password"
    path = Rails.application.routes.url_helpers.edit_password_reset_path(@user.password_reset_token)
    @password_reset_link = "#{@user.public_url}#{path}"
    mail to: @user.email, subject: @subject
  end

  private

  # If user has been created by the admin he needs to tell him the password.
  # If he has signed in through the page he doesn't.
  def user_needs_password(user)
    !user.google_sign_in && user.enable_account_token.nil? && !user.created_with_invitation?
  end

  def get_mail_tracker(tag)
    hubspot = Cartodb.get_config(:metrics, 'hubspot')
    hubspot["mailing_track"][tag] unless hubspot.nil? || !hubspot["mailing_track"].present?
  end

end
