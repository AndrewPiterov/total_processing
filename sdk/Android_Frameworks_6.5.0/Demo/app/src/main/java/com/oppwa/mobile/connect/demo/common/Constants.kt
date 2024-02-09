package com.oppwa.mobile.connect.demo.common

object Constants {
    const val CONNECTION_TIMEOUT = 5000

    const val BASE_URL = "http://52.59.56.185"
    const val NOTIFICATION_URL = "$BASE_URL:80/notification"
    const val MERCHANT_ID = "ff80808138516ef4013852936ec200f2"
    const val LOG_TAG = "msdk.demo"

    /* The configuration values to change across the app */
    object Config {
        /* The default amount and currency */
        const val AMOUNT = "49.99"
        const val CURRENCY = "EUR"

        /* The default amount and currency for AFTERPAY_PACIFC*/
        const val AFTERPAY_AMOUNT = "108.50"
        const val AFTERPAY_CURRENCY = "USD"
        const val AFTERPAY_PARAMETERS_FILE = "afterpayPacificParameters.txt"

        /* The payment brands for Ready-to-Use UI and Payment Button */
        val PAYMENT_BRANDS = linkedSetOf("VISA", "MASTER", "PAYPAL", "GOOGLEPAY")

        /* The default payment brand for payment button */
        const val PAYMENT_BUTTON_BRAND = "MASTER"

        /* The default payment brand for COPYandPAY in mSDK payment button */
        const val COPY_AND_PAY_IN_MSDK_PAYMENT_BUTTON_BRAND = "AFTERPAY_PACIFIC"

        /* The card info for SDK & Your Own UI */
        const val CARD_BRAND = "VISA"
        const val CARD_HOLDER_NAME = "JOHN DOE"
        const val CARD_NUMBER = "4200000000000000"
        const val CARD_EXPIRY_MONTH = "07"
        const val CARD_EXPIRY_YEAR = "28"
        const val CARD_CVV = "123"
    }
}