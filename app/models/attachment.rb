class Attachment < ApplicationRecord
  audited

  belongs_to :model, inverse_of: :attachments
  belongs_to :item, inverse_of: :attachments

  validate do
    errors.add(:base, _('Uploaded file must be less than 100MB')) if size >= 100_000_000
    unless content_type.match? %r{^(image\/(png|gif|jpeg)|application\/pdf)}
      errors.add(:base, _('Unallowed content type'))
    end
  end

  validate do
    errors.add :base, _('Attachment must be belong to model or item') unless model or item

    errors.add :base, _("Attachment can't belong to model and item") if model and item
  end

  def to_s
    filename
  end

  def label_for_audits
    filename
  end
end
