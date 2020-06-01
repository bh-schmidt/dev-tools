using System.Collections.Generic;
using System.Net.Mail;
using System.Text;

namespace YourNamespace
{
    public interface ISendMail
    {
        /// <summary>
        /// Envia um email para os destinatários informados.
        /// </summary>
        /// <param name="fromAddress">Remetente</param>
        /// <param name="toAddresses">Destinatário</param>
        /// <param name="subject">Assunto</param>
        /// <param name="body">Corpo do email</param>
        /// <param name="userToken">Token utilizado para identificar o email no evento <paramref name="onSendCompleted"/></param>
        /// <param name="encoding">Tipo de codificação do texto.</param>
        /// <param name="onSendCompleted">Evento enviado após o sucesso/falha do envio do email</param>
        void Send(
            MailAddress fromAddress,
            IEnumerable<string> toAddresses,
            string subject,
            string body,
            bool isBodyHtml = false,
            object userToken = null,
            Encoding encoding = null,
            SendCompletedEventHandler onSendCompleted = default);
    }
}
