using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace YourNamespace
{
    public class StringFormatter : IStringFormatter
    {
        public string Format(
            string text, 
            object parameters, 
            CultureInfo cultureInfo = null)
        {
            if (cultureInfo is null)
                cultureInfo = CultureInfo.DefaultThreadCurrentCulture;

            var keys = GetKeys(text);
            var parameterValues = new List<object>();
            var index = 0;

            var builder = new StringBuilder(text);

            foreach (var key in keys)
            {
                if (!CanInject(key))
                    continue;

                var keyName = GetKeyName(key);

                var newKey = ReplaceKeyNameByIndex(key, keyName, index);
                builder.Replace(key, newKey);

                var propertyValue = GetPropertyValue(keyName, parameters);
                parameterValues.Add(propertyValue);

                index++;
            }

            var newText = builder.ToString();

            return string.Format(cultureInfo, newText, parameterValues.ToArray());
        }

        private static IEnumerable<string> GetKeys(string text)
        {
            var matches = Regex.Matches(text, @"[{]+[^{}]+[}]+");

            return matches.Select(m => m.ToString());
        }

        private static string GetKeyName(string key)
        {
            var match = Regex.Match(key, @"(?<={)[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ_0-9]+");
            return match.ToString();
        }

        private static object GetPropertyValue(string keyName, object parameters)
        {
            var property = parameters.GetType()
                .GetProperty(keyName);

            if (property is null)
                throw new ArgumentException($"A chave {keyName} não foi encontrada nos parâmetros.");

            return property.GetValue(parameters);
        }

        private static string ReplaceKeyNameByIndex(string key, string keyName, int index)
        {
            return key.Replace(keyName, index.ToString());
        }

        private static bool CanInject(string key)
        {
            var firstBraceCount = key.Count(c => c == '{');
            var lastBraceCount = key.Count(c => c == '}');

            return IsOddNumber(firstBraceCount) || IsOddNumber(lastBraceCount);
        }

        private static bool IsOddNumber(long number)
        {
            return (number % 2) != 0;
        }
    }
}
