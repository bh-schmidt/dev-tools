using SysOp.Infra.CrossCutting.Utils.AppSettingsConfigs.MailConfigurations;
using System.Net.Mail;

namespace YourNamespace
{
    public abstract class BaseSendMailAsync
    {
        protected readonly MailConfiguration mailConfiguration;
        private readonly SmtpClient client;

        public BaseSendMailAsync(SmtpClient client, MailConfiguration mailConfiguration)
        {
            this.client = client;
            this.mailConfiguration = mailConfiguration;
        }

        /// <summary>
        /// Envia o email informado.
        /// </summary>
        /// <param name="message">Email</param>
        /// <param name="userToken">Token utilizado para identificar o email no evento <paramref name="onSendCompleted"/></param>
        /// <param name="onSendCompleted">Evento enviado após o sucesso/falha do envio do email</param>
        public void SendAsync(
            MailMessage message,
            object userToken = null,
            SendCompletedEventHandler onSendCompleted = default)
        {
            if (!mailConfiguration.Active)
                return;

            client.SendCompleted += onSendCompleted;

            client.SendAsync(message, userToken);
        }
    }
}
