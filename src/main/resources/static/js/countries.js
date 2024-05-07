const asianCountries = [
    {emoji: "🇨🇳", name: "China", currencyCode: "CNY", currencyName: "Chinese Yuan"},
    {emoji: "🇭🇰", name: "Hongkong", currencyCode: "HKD", currencyName: "Hong Kong Dollar"},
    {emoji: "🇯🇵", name: "Japan", currencyCode: "JPY", currencyName: "Japanese Yen"},
    {emoji: "🇮🇳", name: "India", currencyCode: "INR", currencyName: "Indian Rupee"},
    {emoji: "🇮🇩", name: "Indonesia", currencyCode: "IDR", currencyName: "Indonesian Rupiah"},
    {emoji: "🇮🇱", name: "Israel", currencyCode: "ILS", currencyName: "Israeli New Shekel"},
    {emoji: "🇰🇼", name: "Kuwait", currencyCode: "KWD", currencyName: "Kuwaiti Dinar"},
    {emoji: "🇲🇾", name: "Malaysia", currencyCode: "MYR", currencyName: "Malaysian Ringgit"},
    {emoji: "🇧🇭", name: "Bahrain", currencyCode: "BHD", currencyName: "Bahraini Dinar"},
    {emoji: "🇵🇰", name: "Pakistan", currencyCode: "PKR", currencyName: "Pakistani Rupee"},
    {emoji: "🇵🇭", name: "Philippines", currencyCode: "PHP", currencyName: "Philippine Peso"},
    {emoji: "🇶🇦", name: "Qatar", currencyCode: "QAR", currencyName: "Qatari Riyal"},
    {emoji: "🇷🇺", name: "Russia", currencyCode: "RUB", currencyName: "Russian Ruble"},
    {emoji: "🇸🇦", name: "Saudi Arabia", currencyCode: "SAR", currencyName: "Saudi Riyal"},
    {emoji: "🇸🇬", name: "Singapore", currencyCode: "SGD", currencyName: "Singapore Dollar"},
    {emoji: "🇻🇳", name: "Vietnam", currencyCode: "VND", currencyName: "Vietnamese Dong"},
    {emoji: "🇹🇭", name: "Thailand", currencyCode: "THB", currencyName: "Thai Baht"},
    {emoji: "🇦🇪", name: "UAE", currencyCode: "AED", currencyName: "United Arab Emirates Dirham"},
    {emoji: "🇹🇼", name: "Taiwan", currencyCode: "TWD", currencyName: "New Taiwan Dollar"},
    {emoji: "🇹🇷", name: "Turkey", currencyCode: "TRY", currencyName: "Turkish Lira"}
];
const africanCountries = [
    {emoji: "🇿🇦", name: "South Africa", currencyCode: "ZAR", currencyName: "South African Rand"},
]
const northAmericanCountries = [
    {emoji: "🇨🇦", name: "Canada", currencyCode: "CAD", currencyName: "Canadian Dollar"},
    {emoji: "🇲🇽", name: "Mexico", currencyCode: "MXN", currencyName: "Mexican Peso"},
    {emoji: "🇺🇸", name: "United States", currencyCode: "USD", currencyName: "United States Dollar"},
]
const southAmericanCountries = [
    {emoji: "🇦🇷", name: "Argentina", currencyCode: "ARS", currencyName: "Argentine Peso"}
]
const europeanCountries = [
    {emoji: "🇩🇰", name: "Denmark", currencyCode: "DKK", currencyName: "Danish Krone"},
    {emoji: "🇭🇺", name: "Hungary", currencyCode: "HUF", currencyName: "Hungarian Forint"},
    {emoji: "🇳🇴", name: "Norway", currencyCode: "NOK", currencyName: "Norwegian Krone"},
    {emoji: "🇸🇪", name: "Sweden", currencyCode: "SEK", currencyName: "Swedish Krona"},
    {emoji: "🇨🇭", name: "Switzerland", currencyCode: "CHF", currencyName: "Swiss Franc"},
    {emoji: "🇬🇧", name: "United Kingdom", currencyCode: "GBP", currencyName: "British Pound"},
    {emoji: "🇪🇺", name: "European Union", currencyCode: "EUR", currencyName: "Euro"},
    {emoji: "🇵🇱", name: "Poland", currencyCode: "PLN", currencyName: "Polish Zloty"}
]
const oceaniaCountries = [
    {emoji: "🇦🇺", name: "Australia", currencyCode: "AUD", currencyName: "Australian Dollar"},
    {emoji: "🇳🇿", name: "New Zealand", currencyCode: "NZD", currencyName: "New Zealand Dollar"}
]

const allCountries = [
    ...africanCountries,
    ...asianCountries,
    ...europeanCountries,
    ...northAmericanCountries,
    ...southAmericanCountries,
    ...oceaniaCountries
];