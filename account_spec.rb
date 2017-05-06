require "rspec"

require_relative "account"

describe Account do
  let(:transactions) { 1 }
  let(:account) { Account.new("1234567890", transactions) }

  describe "#initialize" do
    it "should have at least one argument" do
      expect{Account.new()}.to raise_error(ArgumentError)
    end

    it "should only accepts valid numbers" do
      expect{Account.new("123456789")}.to raise_error(InvalidAccountNumberError)
      expect{Account.new("1234567890")}.not_to raise_error
    end
  end

  describe "#transactions" do
    it "should return the transactions" do
      expect(account.transactions).to eq([transactions])
    end
  end

  describe "#balance" do
    it "should return current balance" do
      expect(account.balance).to eq(1)
    end
  end

  describe "#acct_number" do
    it "should censor (Which parts?)" do
      expect(account.acct_number).to eq("******7890")
    end
  end

  describe "deposit!" do
    it "should not be negative" do
      expect{account.deposit!(-1000)}.to raise_error(NegativeDepositError)
    end

    it "should return the new balance" do
      account.deposit!(1)
      expect(account.balance).to eq(2)
    end
  end

  describe "#withdraw!" do
    it "should not overdraft" do
      expect{account.withdraw!(1000)}.to raise_error(OverdraftError)
    end

    it "should return the new balance" do
      account.withdraw!(1)
      expect(account.balance).to eq(0)
    end
  end
end
