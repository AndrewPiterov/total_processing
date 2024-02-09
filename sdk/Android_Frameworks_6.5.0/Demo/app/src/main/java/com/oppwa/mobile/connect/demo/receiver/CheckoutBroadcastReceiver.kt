package com.oppwa.mobile.connect.demo.receiver

import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity
import com.oppwa.mobile.connect.demo.common.Constants
import com.oppwa.mobile.connect.demo.common.Utils
import com.oppwa.msa.MerchantServerApplication

class CheckoutBroadcastReceiver : BroadcastReceiver() {

    private var context: Context? = null
    var senderComponent: ComponentName? = null

    override fun onReceive(context: Context?, oldIntent: Intent?) {
        this.context = context
        val action = oldIntent?.action

        if (CheckoutActivity.ACTION_ON_BEFORE_SUBMIT == action) {
            handleOnBeforeSubmit(oldIntent)
        }
    }

    private fun handleOnBeforeSubmit(oldIntent: Intent) {
        val paymentBrand = oldIntent.getStringExtra(CheckoutActivity.EXTRA_PAYMENT_BRAND)
        senderComponent = oldIntent.getParcelableExtra(CheckoutActivity.EXTRA_SENDER_COMPONENT_NAME)

        if (isPaymentBrandWithExtraParameters(paymentBrand)) {
            if ("AFTERPAY_PACIFIC" == paymentBrand) {
                requestCheckoutIdForAfterpay()
            }
        } else {
            startCheckoutActivity(oldIntent.getStringExtra(CheckoutActivity.EXTRA_CHECKOUT_ID))
        }
    }

    private fun isPaymentBrandWithExtraParameters(paymentBrand: String?): Boolean {
        return "ONEY" == paymentBrand
                || "AFTERPAY_PACIFIC" == paymentBrand
    }

    /* Pay attention that we are using different amount and currency for ONEY and AFTERPAY_PACIFIC
       for the new checkoutId. It is required due to external simulators which have specific configurations */
    private fun requestCheckoutIdForAfterpay() {
        MerchantServerApplication.requestCheckoutId(
                MerchantServerApplication.getDefaultAuthorization(),
                Constants.Config.AFTERPAY_AMOUNT,
                Constants.Config.AFTERPAY_CURRENCY,
                "PA",
                getExtraParameters(Constants.Config.AFTERPAY_PARAMETERS_FILE),
                this::handleCheckoutId
        )
    }

    private fun getExtraParameters(fileName: String): Map<String, String> {
        val parameters: MutableMap<String, String> = HashMap()

        parameters["notificationUrl"] = Constants.NOTIFICATION_URL
        parameters["testMode"] = "EXTERNAL"
        parameters.putAll(Utils().getParametersFromFile(context!!, fileName))

        return parameters
    }

    private fun handleCheckoutId(checkoutId: String?, error: String?) {
        if (error != null) {
            Log.e(Constants.LOG_TAG, error)
        }
        startCheckoutActivity(checkoutId)
    }

    private fun startCheckoutActivity(checkoutId: String?) {
        /* This callback can be used to request a new checkout ID if selected payment brand requires
           some specific parameters or just send back the same checkout id to continue checkout process */
        val intent = Intent(CheckoutActivity.ACTION_ON_BEFORE_SUBMIT)
        intent.component = senderComponent
        intent.setPackage(senderComponent?.packageName)

        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        if (checkoutId != null) {
            intent.putExtra(CheckoutActivity.EXTRA_CHECKOUT_ID, checkoutId)
        }

        /* Also it can be used to cancel the checkout process by sending
           the CheckoutActivity.EXTRA_CANCEL_CHECKOUT */
        intent.putExtra(CheckoutActivity.EXTRA_TRANSACTION_ABORTED, false)

        context?.startActivity(intent)
    }
}