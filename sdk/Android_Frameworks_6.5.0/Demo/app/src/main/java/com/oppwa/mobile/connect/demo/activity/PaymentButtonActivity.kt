package com.oppwa.mobile.connect.demo.activity

import android.os.Bundle

import com.oppwa.mobile.connect.checkout.dialog.PaymentButtonFragment
import com.oppwa.mobile.connect.checkout.meta.WpwlOptions
import com.oppwa.mobile.connect.demo.R
import com.oppwa.mobile.connect.demo.common.Constants.Config.COPY_AND_PAY_IN_MSDK_PAYMENT_BUTTON_BRAND
import com.oppwa.mobile.connect.exception.PaymentException

import kotlinx.android.synthetic.main.activity_payment_button.*
import kotlinx.coroutines.ExperimentalCoroutinesApi

const val EXTRA_AMOUNT = "com.oppwa.mobile.connect.demo.activity.EXTRA_AMOUNT"
const val EXTRA_CURENCY = "com.oppwa.mobile.connect.demo.activity.EXTRA_CURENCY"
const val EXTRA_PAYMENT_BRAND = "com.oppwa.mobile.connect.demo.activity.EXTRA_PAYMENT_BRAND"

/**
 * Represents an activity for making payments via {@link PaymentButtonSupportFragment}.
 */
class PaymentButtonActivity : BasePaymentActivity() {

    private lateinit var paymentButtonFragment: PaymentButtonFragment
    private lateinit var currency: String
    private lateinit var amount: String
    private lateinit var paymentBrand: String

    @ExperimentalCoroutinesApi
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_payment_button)

        getDataFromIntent()

        val amountText = "$amount $currency"
        amount_text_view.text = amountText

        progressBar = progress_bar_payment_button

        initPaymentButton()
    }

    private fun getDataFromIntent() {
        amount = intent.getStringExtra(EXTRA_AMOUNT).toString()
        currency = intent.getStringExtra(EXTRA_CURENCY).toString()
        paymentBrand = intent.getStringExtra(EXTRA_PAYMENT_BRAND).toString()
    }

    override fun onCheckoutIdReceived(checkoutId: String?) {
        super.onCheckoutIdReceived(checkoutId)

        checkoutId?.let { pay(checkoutId) }
    }

    @ExperimentalCoroutinesApi
    private fun initPaymentButton() {
        paymentButtonFragment = payment_button_fragment as PaymentButtonFragment

        paymentButtonFragment.paymentBrand = paymentBrand
        paymentButtonFragment.paymentButton.apply {
            setOnClickListener {
                requestCheckoutId()
            }

            /* Customize the payment button (except Google Pay button) */
            setBackgroundResource(R.drawable.drop_in_button_background)
        }
    }

    private fun pay(checkoutId: String) {
        val checkoutSettings = createCheckoutSettings(checkoutId)

        if (COPY_AND_PAY_IN_MSDK_PAYMENT_BUTTON_BRAND == paymentBrand) {
            checkoutSettings.wpwlOptions = prepareWpwlOptions()
        }

        try {
            paymentButtonFragment.setActivityResultLauncher(checkoutLauncher)
            paymentButtonFragment.submitTransaction(checkoutSettings)
        } catch (e: PaymentException) {
            showAlertDialog(R.string.error_message)
        }
    }

    private fun prepareWpwlOptions(): Map<String, WpwlOptions> {
        val wpwlOptionsMap: MutableMap<String, WpwlOptions> = HashMap()
        wpwlOptionsMap["AFTERPAY_PACIFIC"] = getAfterpayPacificWpwlOptions()
        return wpwlOptionsMap
    }

    private fun getAfterpayPacificWpwlOptions(): WpwlOptions {
        val wpwlOptions = WpwlOptions()
        wpwlOptions.addValue("inlineFlow", arrayOf("AFTERPAY_PACIFIC"))
        wpwlOptions.addJSFunction("onReady", "function(){wpwl.executePayment(\"wpwl-container-virtualAccount-AFTERPAY_PACIFIC\")}")

        return wpwlOptions
    }
}