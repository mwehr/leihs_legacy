class UserSession < ApplicationRecord
  belongs_to :user
  belongs_to :delegation, foreign_key: :delegation_id, class_name: 'User'

  def self.find_by_token_base(token)
    where(
      <<-SQL
            user_sessions.token_hash = encode(digest(?, 'sha256'), 'hex')
    SQL
        .strip_heredoc,
      token
    )
      .joins(:user)
      .where(users: { account_enabled: true })
  end

  def self.find_by_token(token)
    find_by_token_base(token).joins(
      <<-SQL
              INNER JOIN settings
        ON settings.id = 0
      SQL
        .strip_heredoc
    )
      .where(
      <<-SQL
              now() <
          user_sessions.created_at +
          settings.sessions_max_lifetime_secs * interval '1 second'
      SQL
        .strip_heredoc
    )
      .first
  end
end
