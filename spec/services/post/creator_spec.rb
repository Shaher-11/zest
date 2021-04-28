require "rails_helper"
describe Post::Creator do
  let(:user) { create(:user) }
  let(:permitted_params) { {} }
  subject { described_class.new(user, permitted_params) }
  describe "#call" do
    context "when creating a status" do
      let(:postable_type) { "Status" }
      let(:status_text) { "Howdy!" }
      let(:permitted_params) { {
        postable_type: postable_type,
        status_text: status_text,
      } }
      it "can post successfully" do
        expect {
          subject.call
        }.to change {
          user.posts.reload.count
        }.from(0).to(1)
        post = user.posts.first
        expect(post.postable).to be_a Status
        expect(post.postable.text).to eq "Howdy!"
      end
      context "when the user is not known" do
        let(:user) { nil }
        it "cannot be posted" do
          expect(subject.call).to be_falsey
        end
      end
      context "when the status text is empty" do
        let(:status_text) { "" }
        it "cannot be posted" do
          expect(subject.call).to be_falsey
        end
      end
      context "when the postable type is empty" do
        let(:postable_type) { "" }
        it "cannot be posted" do
          expect(subject.call).to be_falsey
        end
      end
    end
  end
end