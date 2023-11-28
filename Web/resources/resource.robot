*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${browser}                  Chrome
${base_url}                 https://www.jamtangan.com/
${button_allow}             //button[text()="Izinkan"]
${button_login}             //button[@id='login-button']
${input_name}               //input[@name='username']
${name}                     xxxxx
${input_password}           //input[@name='password']
${password}                 xxxxx
${checkbox_remember}        //input[@id='remember-me']
${button__login_popup}      //button[@class='mw-ripple-effect btn rounded text-sm relative overflow-hidden w-full btn-filled text-neutral-1000 bg-primary-1 uppercase qa-login-button']
${img_all-collection}       //img[@alt='Semua Koleksi']
${product}                  //img[@alt='Olivia Burton OB16BD97 Big Dial Ladies White Dial Silver Mesh Strap']
${button_buy-now}           //button[@id='btn-buy-now']
${button_add-cart}          //button[@id='btn-add-to-cart']
${button_cart1}             //*[@id="app"]/div/div[1]/div[2]/div/div[3]/div[1]/div/a/div/span[2]
${button_next-cart}         //button[text()="Lanjutkan"]
${button_fill-address}      //button[text()="Isi alamat"]
${button_later-address}     //button[text()="Nanti"]
${input_label-address}      //input[@aria-label='Label']
${address_label}            Kantor
${input_name-address}       //input[@aria-label='Fullname']
${address_name}             Wina Hariningtyas Candidate QA
${input-phone-number}       //input[@aria-label='Phone']
${phone-number}             082210346652
${input_city}               //input[@aria-label='City or district']
${city}                     Bekasi
${dropdown_city}            //ul[@class="overflow-auto scrollbar-neutral-900-neutral-800"]/li[contains(text(), 'Jawa Barat, Bekasi, Cikarang Selatan')]
${input_postal}             //input[@aria-label='Postal code']
${postal_code}              17510
${input_detail}             //textarea[@aria-label="Address detail"]
${address}                  Jl Nusa Indah Blok C15 No 16 RT 01 RW 09 (Candidate for QA)
${button_submit}            //button[text()="Simpan"]
${button_shipping-method}   //button[@aria-label='Choose shipping method']
${shipping_method}          //p[text()="REG"]
${choose_voucher}           //span[text()="Pilih Voucher"]
${voucher}                  //button[text()='Gunakan']
${button_payment-method}    //button[@class="mw-ripple-effect btn rounded text-sm relative overflow-hidden w-full btn-filled text-neutral-1000 bg-primary-1 uppercase" and text()="Pilih Pembayaran"]
${button_VA}                //div[@data-testid='payment-item-VirtualAccount']
${button_bca}               //input[@id='bank-VABCA']
${button_order-now}         //button[text()="order sekarang"]
${price_element}           //div[contains(@class, "col-span-2") and contains(@class, "font-black") and contains(text(), "Rp1.137.000")]
${courier_charge_element}  //div[contains(@class, "col-span-2") and contains(@class, "font-black") and contains(text(), "Rp10.000")]
${insurance_element}       //div[contains(@class, "col-span-2") and contains(@class, "font-black") and contains(text(), "Rp7.274")]

*** Keywords ***
User Open Browser
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --disable-notifications
    Open Browser    ${base_url}    ${browser}    chrome_options=${chrome_options}
    Maximize Browser Window

User Login in Web
    Wait Until Element Is Visible    ${button_allow}
    Click Button    ${button_allow}
    Wait Until Element Is Visible    ${button_login}
    Click Element     ${button_login}
    Input Text    ${input_name}    ${name}
    Input Text    ${input_password}    ${password}
    Click Element    ${checkbox_remember}
    Click Button    ${button__login_popup}
    
Choose Watch to Order
    Scroll Element Into View    ${product}
    Wait Until Element Is Visible    ${product}
    Click Element    ${product}

Add Product to Buy Now
    Wait Until Element Is Visible    ${button_buy-now}
    Click Button    ${button_buy-now}
    
Add Product to Cart
    Wait Until Element Is Visible    ${button_add-cart}
    Click Button    ${button_add-cart}

Go to Shopping Cart
    Wait Until Element Is Visible    ${button_cart1}   timeout=10s
    Click Element    ${button_cart1}
    Wait Until Element Is Visible    ${button_next-cart}
    Click Button    ${button_next-cart}
Input New Address
    Wait Until Element Is Visible    ${button_fill-address}
    Click Button    ${button_fill-address}
    Input Text    ${input_label-address}    ${address_label}
    Input Text    ${input_name-address}    ${address_name}
    Input Text    ${input-phone-number}    ${phone-number}
    Input Text    ${input_city}    ${city}
    Wait Until Page Contains    Jawa Barat, Bekasi, Cikarang Selatan    timeout=10s
    ${choosen_city}=    Get Text    ${dropdown_city}
    Click Element  ${dropdown_city}
    Input Text   ${input_postal}   ${postal_code}
    Input Text    ${input_detail}    ${address}
    Wait Until Element Is Visible    ${button_submit}
    Click Button    ${button_submit}

Choose Shipping Method
    Wait Until Element Is Visible    ${button_shipping-method}
    Click Button    ${button_shipping-method}
    Wait Until Element Is Visible    ${shipping_method}
    Click Element    ${shipping_method}

Validate Total Payment
    Wait Until Element Is Visible    ${price_element}
    ${price} =              Get Text    ${price_element}
    ${courier_charge} =     Get Text    ${courier_charge_element}
    ${insurance} =          Get Text    ${insurance_element}
    ${price} =              Convert To Number    ${price.replace("Rp", "").replace(".", "").strip()}
    ${courier_charge} =     Convert To Number    ${courier_charge.replace("Rp", "").replace(".", "").strip()}
    ${insurance} =          Convert To Number    ${insurance.replace("Rp", "").replace(".", "").strip()}
    ${actual_total_payment} =    Evaluate    ${price} + ${courier_charge} + ${insurance}
    Should Be Equal As Numbers    ${actual_total_payment}    1154274
    
Choose Payment Method
    Wait Until Element Is Visible    ${button_payment-method}   timeout= 20s
    Click Button    ${button_payment-method}
    Wait Until Element Is Visible    ${button_VA}   timeout=20s
    Click Element   ${button_VA}
    Click Element   ${button_bca}
    Click Button    ${button_order-now}