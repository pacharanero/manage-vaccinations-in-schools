# frozen_string_literal: true

describe ProcessImportJob do
  describe "#perform" do
    subject(:perform) { described_class.new.perform(import) }

    let(:team_cached_counts) do
      instance_double(TeamCachedCounts, reset_import_issues!: true)
    end

    before do
      allow(TeamCachedCounts).to receive(:new).with(import.team).and_return(
        team_cached_counts
      )
    end

    context "with a class import" do
      let(:import) { create(:class_import) }

      it "parses, processes the rows and resets the import issues count" do
        allow(import).to receive(:rows_are_invalid?).and_return(false)

        expect(import).to receive(:parse_rows!)
        expect(import).to receive(:process!)
        expect(team_cached_counts).to receive(:reset_import_issues!)

        perform
      end
    end

    context "with a cohort import" do
      let(:import) { create(:cohort_import) }

      it "parses, processes the rows and resets the import issues count" do
        allow(import).to receive(:rows_are_invalid?).and_return(false)

        expect(import).to receive(:parse_rows!)
        expect(import).to receive(:process!)
        expect(team_cached_counts).to receive(:reset_import_issues!)

        perform
      end
    end

    context "with an immunisation import" do
      let(:import) { create(:immunisation_import) }

      it "parses, processes the rows and resets the import issues count" do
        allow(import).to receive(:rows_are_invalid?).and_return(false)

        expect(import).to receive(:parse_rows!)
        expect(import).to receive(:process!)
        expect(team_cached_counts).to receive(:reset_import_issues!)

        perform
      end
    end

    context "when the parsed rows are invalid" do
      let(:import) { create(:cohort_import) }

      it "does not process the import or reset the import issues count" do
        allow(import).to receive(:rows_are_invalid?).and_return(true)

        expect(import).to receive(:parse_rows!)
        expect(import).not_to receive(:process!)
        expect(TeamCachedCounts).not_to receive(:new)

        perform
      end
    end
  end
end
