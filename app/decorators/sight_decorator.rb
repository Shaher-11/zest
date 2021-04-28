module SightDecorator
  def humanized_activity_type(sight)
    case activity_type
    when Sight::CHECKIN then "checked in at"
    when Sight::CHECKOUT then "checked out from"
    end
  end
end