# frozen_string_literal: true

class TargetValidator < ActiveModel::Validator
  def validate(record)
    return if record.user.targets_count < Target::MAX_USER_TARGETS

    record.errors.add(:targets, I18n.t('api.errors.max_user_targets', max_user_targets: Target::MAX_USER_TARGETS))
  end
end
