using System.Globalization;

namespace YourNamespace
{
    public interface IStringFormatter
    {
        string Format(
            string text,
            object parameters,
            CultureInfo cultureInfo = null);
    }
}
