require 'rails_helper'

RSpec.describe Question, type: :controller do
  describe '#edit' do
    context 'Action with admin' do
      before { get :edit }

      it { is_expected.to render_template 'edit' }
    end
  end
end
