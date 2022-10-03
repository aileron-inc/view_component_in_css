# frozen_string_literal: true

require "tempfile"

RSpec.describe ViewComponentScopedCss::Compiler do
  subject(:css) { described_class.new(path: scss_file.path, identifier: "Test").call }

  let(:scss_file) do
    temp = Tempfile.create
    temp.write <<~SCSS
      :module(component) { a, b, input { color: read; } }
    SCSS
    temp.rewind
    temp
  end

  let(:expected_css) do
    # rubocop:disable Layout/LineLength
    ".viewcomponent\\:\\:Test\\:\\:component a, .viewcomponent\\:\\:Test\\:\\:component b, .viewcomponent\\:\\:Test\\:\\:component input {\n  color: read;\n}"
    # rubocop:enable Layout/LineLength
  end

  it { is_expected.to eq(expected_css) }
end
