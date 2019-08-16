require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:question) { create :question }

  describe '#edit' do
    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }

      context 'Can find question' do
        before { get :edit, params: { id: question.id } }

        it { is_expected.to render_template 'edit' }
      end

      context 'Can not find question' do
        before { get :edit, params: { id: -1 } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :edit, params: { id: question.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :edit, params: { id: question.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#update' do
    let(:question_params) { attributes_for :question, content: 'Question 1' }

    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }
      context 'Can find question' do
        context 'Can update' do
          let!(:qs_update) do
            put :update, params: { id: question.id, question: question_params }
          end

          it do
            expect { question.reload }.to change { question.content }
              .from(question.content).to('Question 1')
          end
          it { is_expected.to set_flash }
          it { is_expected.to redirect_to test_path(question.test) }
        end

        context 'Can not update' do
          let(:question_params) { attributes_for :question, content: '' }
          before do
            post :update, params: { id: question.id,
                                    question: question_params }
          end

          it { is_expected.to set_flash }
          it { is_expected.to render_template 'edit' }
        end
      end

      context 'Can not find question' do
        before do
          put :update, params: { id: -1, question: question_params }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged in with user' do
      before do
        session[:user_id] = user.id
        put :update, params: { id: question.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { put :update, params: { id: question.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#destroy' do
    context 'Logged in with admin' do
      context 'Can find question' do
        before do
          session[:user_id] = admin.id
          delete :destroy, params: { id: question.id }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to test_path(question.test) }
      end

      context 'Can not find question' do
        before do
          session[:user_id] = admin.id
          delete :destroy, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged in with user' do
      before do
        session[:user_id] = user.id
        delete :destroy, params: { id: question.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { delete :destroy, params: { id: question.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end
end
