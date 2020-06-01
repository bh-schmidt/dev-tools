using SysOp.Infra.CrossCutting.Utils.AppSettingsConfigs.MailConfigurations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;

namespace YourNamespace
{
    public class SendMail : BaseSendMailAsync, ISendMail
    {
        public SendMail(SmtpClient client, MailConfiguration mailConfiguration) : base(client, mailConfiguration){}

        public void Send(
            MailAddress fromAddress,
            IEnumerable<string> toAddresses,
            string subject,
            string body,
            bool isBodyHtml = false,
            object userToken = null,
            Encoding encoding = null,
            SendCompletedEventHandler onSendCompleted = default)
        {
            if (toAddresses is null || !toAddresses.Any())
                throw new ArgumentException(nameof(toAddresses));

            if (encoding is null)
                encoding = Encoding.Default;

            var message = new MailMessage()
            {
                From = fromAddress,
                Subject = subject,
                Body = body,
                SubjectEncoding = encoding,
                BodyEncoding = encoding,
                IsBodyHtml = isBodyHtml
            };

            foreach (var mail in toAddresses)
                message.To.Add(mail);

            SendAsync(message, userToken, onSendCompleted);
        }
    }
}
