require 'rails_helper'

RSpec.describe Traveler, type: :model do
  describe 'associations' do
    describe 'has_one_attached profile_picture' do
      it 'can have a profile picture attached' do
        traveler = create(:traveler)
        expect(traveler.profile_picture).to respond_to(:attach)
      end
    end

    describe 'has_many saved_communities' do
      it 'has many saved_communities' do
        traveler = create(:traveler)
        expect(traveler).to respond_to(:saved_communities)
        expect(traveler.saved_communities).to eq([])
      end

      it 'can have multiple saved_communities' do
        traveler = create(:traveler)
        community1 = create(:community)
        community2 = create(:community)
        create(:saved_community, traveler: traveler, community: community1)
        create(:saved_community, traveler: traveler, community: community2)

        expect(traveler.saved_communities.count).to eq(2)
      end

      it 'destroys dependent saved_communities when destroyed' do
        traveler = create(:traveler)
        community = create(:community)
        create(:saved_community, traveler: traveler, community: community)

        expect { traveler.destroy }.to change { SavedCommunity.count }.by(-1)
      end
    end

    describe 'has_many saved_community_records' do
      it 'has many saved_community_records through saved_communities' do
        traveler = create(:traveler)
        expect(traveler).to respond_to(:saved_community_records)
      end

      it 'can access communities through saved_community_records' do
        traveler = create(:traveler)
        community1 = create(:community)
        community2 = create(:community)
        create(:saved_community, traveler: traveler, community: community1)
        create(:saved_community, traveler: traveler, community: community2)

        expect(traveler.saved_community_records).to contain_exactly(community1, community2)
      end
    end
  end

  describe 'validations' do
    describe 'role presence' do
      it 'is valid with a role' do
        traveler = build(:traveler, role: :traveler)
        expect(traveler).to be_valid
      end

      it 'sets default role to traveler on initialization' do
        traveler = Traveler.new
        expect(traveler.role).to eq('traveler')
      end
    end

    describe 'first name presence' do
      it 'is valid with a first name' do
        traveler = build(:traveler, first: 'John')
        expect(traveler).to be_valid
      end

      it 'is invalid without a first name' do
        traveler = build(:traveler, first: nil)
        expect(traveler).not_to be_valid
        expect(traveler.errors[:first]).to include("can't be blank")
      end
    end

    describe 'last name presence' do
      it 'is valid with a last name' do
        traveler = build(:traveler, last: 'Doe')
        expect(traveler).to be_valid
      end

      it 'is invalid without a last name' do
        traveler = build(:traveler, last: nil)
        expect(traveler).not_to be_valid
        expect(traveler.errors[:last]).to include("can't be blank")
      end
    end

    describe 'email presence' do
      it 'is valid with an email' do
        traveler = build(:traveler, email: 'test@example.com')
        expect(traveler).to be_valid
      end

      it 'is invalid without an email' do
        traveler = build(:traveler, email: nil)
        expect(traveler).not_to be_valid
        expect(traveler.errors[:email]).to include("can't be blank")
      end
    end

    describe 'home_city length' do
      it 'is valid with a home_city under 100 characters' do
        traveler = build(:traveler, home_city: 'A' * 100)
        expect(traveler).to be_valid
      end

      it 'is invalid with a home_city over 100 characters' do
        traveler = build(:traveler, home_city: 'A' * 101)
        expect(traveler).not_to be_valid
        expect(traveler.errors[:home_city]).to include('is too long (maximum is 100 characters)')
      end
    end

    describe 'home_country length' do
      it 'is valid with a home_country under 100 characters' do
        traveler = build(:traveler, home_country: 'A' * 100)
        expect(traveler).to be_valid
      end

      it 'is invalid with a home_country over 100 characters' do
        traveler = build(:traveler, home_country: 'A' * 101)
        expect(traveler).not_to be_valid
        expect(traveler.errors[:home_country]).to include('is too long (maximum is 100 characters)')
      end
    end
  end

  describe 'enums' do
    describe 'role enum' do
      it 'defines role enum values' do
        expect(Traveler.roles).to eq({ 'traveler' => 0, 'admin' => 1 })
      end

      it 'responds to role query methods' do
        traveler = build(:traveler)
        expect(traveler).to respond_to(:traveler?)
        expect(traveler).to respond_to(:admin?)
      end
    end
  end

  describe 'callbacks' do
    describe 'set_default_role' do
      it 'sets default role to traveler on initialization' do
        traveler = Traveler.new
        expect(traveler.role).to eq('traveler')
      end

      it 'does not override an explicitly set role' do
        traveler = Traveler.new(role: :admin)
        expect(traveler.role).to eq('admin')
      end

      it 'sets role to traveler if nil before validation' do
        traveler = build(:traveler)
        traveler.role = nil
        traveler.valid?
        expect(traveler.role).to eq('traveler')
      end
    end
  end

  describe 'instance methods' do
    describe '#full_name' do
      it 'returns the full name of the traveler' do
        traveler = create(:traveler, first: 'John', last: 'Doe')
        expect(traveler.full_name).to eq('John Doe')
      end

      it 'concatenates first and last name with a space' do
        traveler = create(:traveler, first: 'Jane', last: 'Smith')
        expect(traveler.full_name).to eq('Jane Smith')
      end
    end

    describe '#admin_only!' do
      it 'responds to admin_only! method' do
        traveler = create(:traveler)
        expect(traveler).to respond_to(:admin_only!)
      end
    end
  end

  describe 'Devise modules' do
    it 'includes database_authenticatable module' do
      traveler = create(:traveler)
      expect(traveler).to respond_to(:valid_password?)
    end

    it 'includes registerable module' do
      expect(Traveler).to respond_to(:new_with_session)
    end

    it 'includes recoverable module' do
      traveler = create(:traveler)
      expect(traveler).to respond_to(:send_reset_password_instructions)
    end

    it 'includes rememberable module' do
      traveler = create(:traveler)
      expect(traveler).to respond_to(:remember_me!)
    end

    it 'includes validatable module' do
      traveler = build(:traveler, email: 'invalid')
      expect(traveler).not_to be_valid
    end

    it 'includes confirmable module' do
      traveler = create(:traveler)
      expect(traveler).to respond_to(:confirmed?)
    end

    it 'includes lockable module' do
      traveler = create(:traveler)
      expect(traveler).to respond_to(:locked_at)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      traveler = build(:traveler)
      expect(traveler).to be_valid
    end

    it 'creates a traveler with a first name' do
      traveler = create(:traveler)
      expect(traveler.first).to be_present
    end

    it 'creates a traveler with a last name' do
      traveler = create(:traveler)
      expect(traveler.last).to be_present
    end

    it 'creates a traveler with an email' do
      traveler = create(:traveler)
      expect(traveler.email).to be_present
    end

    it 'creates a traveler with role set in factory' do
      traveler = build(:traveler)
      expect(traveler.role).to be_present
    end

    it 'creates unique emails for each traveler' do
      traveler1 = create(:traveler)
      traveler2 = create(:traveler)
      expect(traveler1.email).not_to eq(traveler2.email)
    end
  end

  describe 'database columns' do
    it 'has a first name column' do
      traveler = create(:traveler, first: 'John')
      expect(traveler.first).to eq('John')
    end

    it 'has a last name column' do
      traveler = create(:traveler, last: 'Doe')
      expect(traveler.last).to eq('Doe')
    end

    it 'has an email column' do
      traveler = create(:traveler, email: 'test@example.com')
      expect(traveler.email).to eq('test@example.com')
    end

    it 'has a role column' do
      traveler = build(:traveler)
      traveler.role = :admin
      expect(traveler.role).to eq('admin')
    end

    it 'has a birthdate column' do
      traveler = create(:traveler, birthdate: Date.new(1990, 1, 1))
      expect(traveler.birthdate).to eq(Date.new(1990, 1, 1))
    end

    it 'has a home_city column' do
      traveler = create(:traveler, home_city: 'Portland')
      expect(traveler.home_city).to eq('Portland')
    end

    it 'has a home_country column' do
      traveler = create(:traveler, home_country: 'USA')
      expect(traveler.home_country).to eq('USA')
    end

    it 'has a profile_image_url column' do
      traveler = create(:traveler, profile_image_url: 'https://example.com/image.jpg')
      expect(traveler.profile_image_url).to eq('https://example.com/image.jpg')
    end

    it 'has timestamps' do
      traveler = create(:traveler)
      expect(traveler.created_at).to be_present
      expect(traveler.updated_at).to be_present
    end

    it 'has Devise columns' do
      traveler = create(:traveler)
      expect(traveler).to respond_to(:encrypted_password)
      expect(traveler).to respond_to(:reset_password_token)
      expect(traveler).to respond_to(:reset_password_sent_at)
      expect(traveler).to respond_to(:remember_created_at)
      expect(traveler).to respond_to(:confirmation_token)
      expect(traveler).to respond_to(:confirmed_at)
      expect(traveler).to respond_to(:confirmation_sent_at)
      expect(traveler).to respond_to(:unconfirmed_email)
      expect(traveler).to respond_to(:failed_attempts)
      expect(traveler).to respond_to(:unlock_token)
      expect(traveler).to respond_to(:locked_at)
    end
  end
end
