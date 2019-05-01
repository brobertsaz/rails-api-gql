module Types
  class QueryType < BaseObject

    # Bills
    field :all_bills, BillType.connection_type, null: false

    def all_bills
      Bill.visible
    end

    field :featured_bills, BillType.connection_type, null: false

    def featured_bills
      Bill.special.order('feature_position asc')
    end

    field :bill, BillType, null: false do
      argument :id, ID, required: true
    end

    def bill(id:)
      RecordLoader.for(Bill).load(id)
    end

    field :bills, BillType.connection_type, null: false do
      argument :user_id, ID, required: true
      argument :filter, String, required: false
    end

    def bills(user_id:, filter:)
      user = User.find(user_id)
      if filter == 'following'
        user.favorite_bills
      else
        Bill.visible
      end
    end

    field :search_bills, BillType.connection_type, null: false do
      argument :term, String, required: true
    end

    def search_bills(term:)
      Bill.search term
    end

    # Members
    field :all_members, MemberType.connection_type, null: false

    def all_members
      Member.ordered.in_office
    end

    field :members, MemberType.connection_type, null: false do
      argument :user_id, ID, required: true
      argument :filter, String, required: false
    end

    def members(user_id:, filter:)
      user = User.find(user_id)
      if filter == 'following'
        user.favorite_members.in_office.ordered
      elsif filter == 'state'
        Member.where(state: user.state).in_office.ordered
      else
        Member.ordered.in_office
      end
    end

    field :member, MemberType, null: false do
      argument :id, ID, required: true
    end

    def member(id:)
      RecordLoader.for(Member).load(id)
    end

    # Posts
    field :all_posts, PostType.connection_type, null: false

    def all_posts
      Post.all
    end

    field :posts, [PostType], null: false do
      argument :user_id, ID, required: true
      argument :filter, String, required: false
    end

    def posts(user_id:, filter:)
      user = User.find(user_id)
      if filter == 'following'
        user.favorite_posts.actually_published.ordered
      elsif filter == 'article'
        Post.actually_published.where(kind: 'article').ordered
      elsif filter == 'video'
        Post.actually_published.where(kind: 'video').ordered
      else
        Post.actually_published.ordered
      end
    end

    field :post, PostType, null: false do
      argument :id, ID, required: true
    end

    def post(id:)
      RecordLoader.for(Post).load(id)
    end

    # Committees
    field :committee, CommitteeType, null: false

    def committee(id:)
      RecordLoader.for(Committee).load(id)
    end
  end
end
