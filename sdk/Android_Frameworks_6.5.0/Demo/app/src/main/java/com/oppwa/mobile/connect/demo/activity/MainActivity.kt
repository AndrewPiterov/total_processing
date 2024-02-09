package com.oppwa.mobile.connect.demo.activity

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.View.OnClickListener
import androidx.appcompat.app.AppCompatActivity
import com.oppwa.mobile.connect.demo.R
import com.oppwa.mobile.connect.demo.common.Constants.Config.AFTERPAY_AMOUNT
import com.oppwa.mobile.connect.demo.common.Constants.Config.AFTERPAY_CURRENCY
import com.oppwa.mobile.connect.demo.common.Constants.Config.AMOUNT
import com.oppwa.mobile.connect.demo.common.Constants.Config.COPY_AND_PAY_IN_MSDK_PAYMENT_BUTTON_BRAND
import com.oppwa.mobile.connect.demo.common.Constants.Config.CURRENCY
import com.oppwa.mobile.connect.demo.common.Constants.Config.PAYMENT_BUTTON_BRAND
import com.oppwa.mobile.connect.provider.Connect
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(), OnClickListener {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        checkout_ui.setOnClickListener(this)
        payment_button.setOnClickListener(this)
        cnp_in_msdk_payment_button.setOnClickListener(this)
        custom_ui.setOnClickListener(this)

        version_number.text =
                String.format(getString(R.string.sdk_version_number), Connect.getVersion())
    }

    override fun onClick(view: View?) {
        if (view != null) {
            when (view.id) {
                R.id.checkout_ui -> startActivity(Intent(this, CheckoutUIActivity::class.java))
                R.id.payment_button -> startActivity(Intent(this, PaymentButtonActivity::class.java)
                        .putExtra(EXTRA_PAYMENT_BRAND, PAYMENT_BUTTON_BRAND)
                        .putExtra(EXTRA_CURENCY, CURRENCY)
                        .putExtra(EXTRA_AMOUNT, AMOUNT))
                R.id.cnp_in_msdk_payment_button -> startActivity(Intent(this, PaymentButtonActivity::class.java)
                        .putExtra(EXTRA_PAYMENT_BRAND, COPY_AND_PAY_IN_MSDK_PAYMENT_BUTTON_BRAND)
                        .putExtra(EXTRA_CURENCY, AFTERPAY_CURRENCY)
                        .putExtra(EXTRA_AMOUNT, AFTERPAY_AMOUNT))
                R.id.custom_ui -> startActivity(Intent(this, CustomUIActivity::class.java))
            }
        }
    }
}