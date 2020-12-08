class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  
  def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @amount = amount
      @status = "pending"
  end

  # def valid?
  #   if sender.valid? && receiver.valid?
  #     true
  #   else
  #     false
  #   end
  # end

  def valid?
    @sender.valid? && @receiver.valid?
  end
  

  # def execute_transaction
  #   if !self.valid? && @sender.balance <= @amount
  #     @status = "rejected" 
  #     puts "Transaction rejected. Please check your account balance."
  #   else @status == "pending"
  #     BankAccount.all.map do |person|
  #       if person == @sender
  #         person.balance -= @amount
  #       elsif person == @receiver
  #         person.balance += @amount
  #       end
  #     end
  #   end
  #   @status = "complete"
  # end

  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending"
      sender.withdrawal(self.amount)
      receiver.deposit(self.amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && receiver.balance > amount && self.status == "complete"
      sender.deposit(self.amount)
      receiver.withdrawal(self.amount)
      self.status = "reversed"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."      
    end
  end
end
