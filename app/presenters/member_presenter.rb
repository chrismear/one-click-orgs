class MemberPresenter
  def initialize(member)
    self.member = member
  end
  
  attr_accessor :member
  
  def timeline
    @timeline ||= [
      @member,
      @member.proposals.to_a,
      @member.votes.to_a
    ].flatten.map(&:to_event).compact.sort{|a, b| b[:timestamp] <=> a[:timestamp]}
  end
end
