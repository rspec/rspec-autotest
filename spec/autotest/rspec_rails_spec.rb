require "autotest/rails_rspec"

describe Autotest::RailsRspec do

  let(:rails_rspec_autotest) { Autotest::RailsRspec.new }

  describe 'exceptions' do
    let(:exceptions_regexp) { rails_rspec_autotest.exceptions }

    it "matches './log/test.log'" do
      expect(exceptions_regexp).to match('./log/test.log')
    end

    it "matches 'log/test.log'" do
      expect(exceptions_regexp).to match('log/test.log')
    end

    it "does not match './spec/models/user_spec.rb'" do
      expect(exceptions_regexp).not_to match('./spec/models/user_spec.rb')
    end

    it "does not match 'spec/models/user_spec.rb'" do
      expect(exceptions_regexp).not_to match('spec/models/user_spec.rb')
    end
  end

  describe 'mappings' do
    before do
      rails_rspec_autotest.find_order = %w(spec/models/user_spec.rb spec/support/blueprints.rb spec/views/users/index_spec.rb)
    end

    it 'runs model specs when support files change' do
      expect(rails_rspec_autotest.test_files_for('spec/support/blueprints.rb')).to(
        include('spec/models/user_spec.rb'))
    end

    it 'finds specs' do
      expect(rails_rspec_autotest.test_files_for('spec/models/user_spec.rb')).to(
        include('spec/models/user_spec.rb'))
    end

    describe 'when controllers exist' do
      before do
        rails_rspec_autotest.find_order = %w(spec/controllers/admin_controller_spec.rb spec/controllers/users_controller_spec.rb)
      end

      it 'finds all controller specs for default controller' do
        expect(rails_rspec_autotest.test_files_for('app/controllers/application_controller.rb')).to eq(
          %w(spec/controllers/admin_controller_spec.rb spec/controllers/users_controller_spec.rb)
        )
      end

      it 'finds specific controller spec' do
        rails_rspec_autotest.find_order = %w(spec/controllers/admin_controller_spec.rb spec/controllers/users_controller_spec.rb)
        expect(rails_rspec_autotest.test_files_for('app/controllers/users_controller.rb')).to eq(
          %w(spec/controllers/users_controller_spec.rb)
        )
      end
    end

    describe 'when fixtures exist' do
      it 'finds associated model specs' do
        expect(rails_rspec_autotest.test_files_for('spec/fixtures/users.yml')).to(
          include('spec/models/user_spec.rb'))
      end

      it 'finds associated view specs' do
        expect(rails_rspec_autotest.test_files_for('spec/fixtures/users.yml')).to(
          include('spec/views/users/index_spec.rb'))
      end
    end

    describe 'when helpers exist' do
      before do
        rails_rspec_autotest.find_order = %w(spec/controllers/users_controller_spec.rb spec/helpers/application_helper_spec.rb spec/helpers/users_helper_spec.rb
                                             spec/models/user_spec.rb spec/support/blueprints.rb spec/views/users/index_spec.rb)
      end

      it 'finds all helper specs for default helper' do
        expect(rails_rspec_autotest.test_files_for('app/helpers/application_helper.rb')).to eq(
          %w(spec/helpers/application_helper_spec.rb spec/helpers/users_helper_spec.rb spec/views/users/index_spec.rb)
        )
      end

      it 'finds helper spec' do
        expect(rails_rspec_autotest.test_files_for('app/helpers/users_helper.rb')).to(
          include('spec/helpers/users_helper_spec.rb')
        )
      end

      it 'finds view spec' do
        expect(rails_rspec_autotest.test_files_for('app/helpers/users_helper.rb')).to(
          include('spec/views/users/index_spec.rb')
        )
      end
    end

    describe 'when models exist' do
      it 'finds associated model specs' do
        expect(rails_rspec_autotest.test_files_for('app/models/user.rb')).to(
          include('spec/models/user_spec.rb'))
      end
    end

    describe 'when routes change' do
      before do
        rails_rspec_autotest.find_order = %w(spec/controllers/users_controller_spec.rb spec/helpers/application_helper_spec.rb
                                             spec/helpers/users_helper_spec.rb spec/models/user_spec.rb spec/routing/users_spec.rb
                                             spec/views/users/index_spec.rb spec/views/users/index.html.erb_spec.rb)
      end

      it 'runs controller specs' do
        expect(rails_rspec_autotest.test_files_for('config/routes.rb')).to(
          include('spec/controllers/users_controller_spec.rb'))
      end

      it 'runs helper specs' do
        expect(rails_rspec_autotest.test_files_for('config/routes.rb')).to(
          include('spec/helpers/users_helper_spec.rb'))
      end

      it 'does not run model specs' do
        expect(rails_rspec_autotest.test_files_for('config/routes.rb')).not_to(
          include('spec/models/user_spec.rb'))
      end

      it 'runs routing specs' do
        expect(rails_rspec_autotest.test_files_for('config/routes.rb')).to(
          include('spec/routing/users_spec.rb'))
      end

      it 'runs views specs' do
        expect(rails_rspec_autotest.test_files_for('config/routes.rb')).to(
          include('spec/views/users/index_spec.rb'))
      end
    end

    it 'runs lib specs on change' do
      rails_rspec_autotest.find_order = %w(spec/lib/make_money_spec.rb spec/models/user_spec.rb)
      expect(rails_rspec_autotest.test_files_for('lib/make_money.rb')).to(
        include('spec/lib/make_money_spec.rb'))
    end

    it 'runs mailer specs on change' do
      rails_rspec_autotest.find_order = %w(spec/mailers/compliment_user_spec.rb spec/models/user_spec.rb)
      expect(rails_rspec_autotest.test_files_for('app/mailers/compliment_user.rb')).to(
        include('spec/mailers/compliment_user_spec.rb'))
    end

    it 'runs model specs when database config changes' do
      rails_rspec_autotest.find_order = %w(spec/controllers/application_controller_spec.rb spec/models/admin_spec.rb spec/models/user_spec.rb)
      expect(rails_rspec_autotest.test_files_for('config/database.yml')).to eq(
        %w(spec/models/admin_spec.rb spec/models/user_spec.rb))
    end

    it 'runs view specs when views change' do
      rails_rspec_autotest.find_order = %w(spec/views/users_spec.rb spec/views/users/index.html.erb_spec.rb)
      expect(rails_rspec_autotest.test_files_for('app/views/users/index.html.erb')).to(
        include('spec/views/users/index.html.erb_spec.rb'))
    end
  end

end
