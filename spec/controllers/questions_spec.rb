require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:question) { create :question }

  describe '#edit' do
    context 'Action with admin' do
      before do
        session[:user_id] = admin.id
        get :edit, params: { id: question.id }
      end

      it { is_expected.to use_before_action(:get_question) }
      it { is_expected.to render_template 'edit' }
    end

    context 'Action with user' do
      before do
        session[:user_id] = user.id
        get :edit, params: { id: question.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Action with anonymous' do
      before { get :edit, params: { id: question.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#update' do
    let(:question_params) { attributes_for :question }
    context 'Action with admin' do
      before do
        session[:user_id] = admin.id
        put :update, params: { id: question.id, question: question_params }
      end

      it { is_expected.to use_before_action(:get_question) }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to test_path(question.test) }
    end

    context 'Action with user' do
      before do
        session[:user_id] = user.id
        put :update, params: { id: question.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Action with anonymous' do
      before { put :update, params: { id: question.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#destroy' do
    context 'Action with admin' do
      before do
        session[:user_id] = admin.id
        delete :destroy, params: { id: question.id }
      end

      it { is_expected.to use_before_action(:get_question) }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to test_path(question.test) }
    end

    context 'Action with user' do
      before do
        session[:user_id] = user.id
        delete :destroy, params: { id: question.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Action with anonymous' do
      before { delete :destroy, params: { id: question.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#get_question' do
    context 'Can find question' do
      before do
        session[:user_id] = admin.id
        use_before_action :get_question, params: { id: question.id }
      end

      it { expect(@question).to eq(question) }
    end

    context 'Can not find question' do
      before do
        session[:user_id] = admin.id
        get :edit, params: { id: -1 }
      end

      it { expect(@question).to be_nil }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end
  end
end
