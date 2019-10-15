require 'net/smtp'

module Net
  class SMTPErrors < ProtoAuthError
    include SMTPError

    attr_reader :errors

    def initialize(errors)
      @errors = errors
      super message
    end

    def message
      "failed to deliver for #{errors}."
    end
  end

  class SMTP
    alias original_rcptto_list rcptto_list

    def rcptto_list(to_addrs)
      raise ArgumentError, 'mail destination not given' if to_addrs.empty?
      ok_users = []
      errors = {}
      to_addrs.flatten.each do |addr|
        begin
          rcptto addr
        rescue SMTPError
          errors[addr] = $!
        else
          ok_users << addr
        end
      end
      raise ArgumentError, 'mail destination not given' if ok_users.empty?
      ret = yield
      raise SMTPErrors, errors if errors.any?
      ret
    end
  end
end
