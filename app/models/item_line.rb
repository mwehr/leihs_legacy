# An ItemLine is a line in a #Contract and as such derived from the
# more general Reservation. It only contains #Item s but NOT
# #Option s.
#
# An ItemLine at first only contains a #Model and a desired quantity
# of that #Model. It's only after the #InventoryPool manager has
# picked specific instances of that #Model - which are called "#Items"
# in _leihs_ - that the ItemLines get to contain #Items.
#
# See also the page "Flow" inside the models.graffle document for a
# description of the various steps the lending process goes through.
#
class ItemLine < Reservation
  audited

  belongs_to :item, inverse_of: :item_lines
  belongs_to :model, inverse_of: :reservations

  validates_numericality_of :quantity, equal_to: 1
  validate :validate_item
  validates_presence_of :model_id
  validates_presence_of(:item,
                        if: proc { |r| [:signed, :closed].include?(r.status) })

  # TODO: 1301  default_scope -> {includes(:model).order("models.product")}

  # OPTMIZE 0209** overriding the item getter in order to get
  # a retired item as well if is the case
  def item
    Item.unscoped { Item.find_by(id: item_id) } if item_id
  end

  def to_s
    "#{item or model} - #{I18n.l end_date}"
  end

  def label_for_audits
    "#{item or model} #{_('until')} #{I18n.l end_date}"
  end

  ##################################################

  # custom valid? method
  def complete?
    !self.item.nil? and super
  end

  ##################################################

  def late?(current_date = Time.zone.today)
    # an ItemLine can only be late if the Item has been
    # handed out. And an Item can only be handed out, if
    # the contract has been signed. Thus:
    status == :signed and super
  end

  ##################################################

  private

  # validator
  def validate_item
    if item_id and status == :approved
      # model matching
      unless item.model_id == model_id
        errors.add(:base, _("The item doesn't match with the reserved model"))
      end

      if item \
        .reservations
        .handed_over_or_assigned_but_not_returned
        .where(['id != ? AND user_id = ? AND status = ?', id, user_id, status])
        .exists?
        # check if already assigned to the same contract
        errors.add(:base,
                   _('%s is already assigned to this contract') % \
                   item.inventory_code)
      elsif item \
        .reservations
        .handed_over_or_assigned_but_not_returned
        .where.not(id: id)
        .exists?
        # check if available
        errors.add(
          :base,
          _('%s is already assigned to a different contract or hand over') % \
          item.inventory_code
        )
      end

      # inventory_pool matching
      unless item.inventory_pool_id == inventory_pool_id
        errors.add(:base,
                   _("The item doesn't belong to the inventory pool " \
                     'related to this contract'))
      end

      # package check
      errors.add(:base, _('The item belongs to a package')) if item.parent_id
    end
  end

end
