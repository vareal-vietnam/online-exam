require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  describe 'Check without login' do
    let(:test_saved) do
      Test.create name: 'Test git',
                  time: 120,
                  kind: 'git'
    end
    let(:question1) { Question.create content: 'Qs 1', test_id: test_saved.id }

    context 'GET index' do
      before { get :index }
      it { is_expected.to render_template 'index' }
    end

    context 'Get show' do
      before { get :show, params: { id: test_saved.id } }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Get new' do
      before { get :new }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Get edit' do
      before { get :edit, params: { id: test_saved.id } }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Delete destroy' do
      before { delete :destroy, params: { id: test_saved.id } }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe 'Check with admin' do
    let(:user_login) do
      User.create name: 'name',
                  email: 'abc@email.com',
                  password: 'password',
                  password_confirmation: 'password',
                  activated: true,
                  is_admin: true
    end

    let(:test_saved) do
      Test.create name: 'Test git',
                  kind: 'git',
                  time: 120
    end

    before(:each) { session[:user_id] = user_login.id }

    context 'Get index' do
      before { get :index }
      it { is_expected.to render_template('tests/admin/index') }
    end

    context 'Get show' do
      before { get :show, params: { id: test_saved.id } }
      it { is_expected.to render_template('tests/admin/show') }
    end

    context 'Post create' do
      # it do
      #   test_params = {
      #     test: {
      #       name: 'Test',
      #       kind: 'rails',
      #       time: 120,
      #       questions_attributes: {
      #         content: 'Question content',
      #         answers_attributes: {
      #           is_correct: true,
      #           content: 'Answer content'
      #         }
      #       }
      #     }
      #   }

      #   is_expected.to permit(:name,
      #                         :kind,
      #                         :time,
      #                         :questions_attributes,
      #                         :answers_attributes)
      #     .for(:create, params: test_params).on(:test)
      # end
    end
  end
end
