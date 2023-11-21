Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F47F2E6F
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Nov 2023 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjKUNgN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Nov 2023 08:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjKUNgN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:36:13 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799D1BC
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Nov 2023 05:36:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-32d9effe314so3933774f8f.3
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Nov 2023 05:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700573768; x=1701178568; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WQYH8wKFCCHTXrK1Zk61Xzuiy6SVyBtq7SxIFkJbxM=;
        b=b02Gs1/jclhPGW3FXRbm+GZX8giElAGBTK+xKOQevAFA43pAqhK8mKWSDUDi43gD+a
         GfWbPPzclBURCplpSVjKicCPLoLR/6oGwN1EfUkjH6K8zu3kBlNzVT/0SfzlJTsNV8lO
         i3PP7Re+5FkuwY4R9Djd+mcVix6aTt+ipfmIvqwuZzMZ/mBtzBIlOFAd7NXH+GKRW79M
         ylhe1cj7h77TfwsmHaV6pbDP/TWlQcEl+eTiiarseJBW/vYlwqXhyUI2IjrdraJaedWT
         Emyl8FREjXy7Q/0M3VKp7umivGaY8trnUXwMahaG1UXlOmRrthRzMDH1BObbXIA+gY7M
         rjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573768; x=1701178568;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WQYH8wKFCCHTXrK1Zk61Xzuiy6SVyBtq7SxIFkJbxM=;
        b=DgVaVjO/dVhsVNGyP7DOmYjI5APkFJRdV/gkAnQLpl1/y/7I4XtXXEtBel8GfaYLSt
         +OGYxbpyU5EfY8J6xUrW582Hfg2wwtvIbTNEDDLca41CPseqLrzHnve+OpN5SreDEhaI
         U39usQ0EPsd7uwLX8DeeqFsnefrCc9Zi2Btz8JTAkLDkSE19Hc65dAS+iUBO3xXl2TzU
         U7wS4PP8rx7cT1CI23YdYbFFruJb7D+3nh4LaoT3E0mFvW4QaV5Nepz/EJX9ZPG328fm
         UV/rLt5B0eXJHUN6E/j5Zp4RkP4VbDTLRvlHYAg4bZqaC8ZBeD+d2oV8cRfGHMoCWglo
         MgVw==
X-Gm-Message-State: AOJu0YxilIpUUXAyAcINoWOIiVvnK/hwWWT4nMNM05JyJzZhOmpau5hw
        WC/GRvu7Mb4iQbOKusyBXMC/Ol0pF/EOCvoBfW4=
X-Google-Smtp-Source: AGHT+IEWK3zFUynEPu6oYS3eNhvf6qA8c8Ok9hm5WtAK8r9BcOkihX1MS4tl255JkWNqy9FgJ7QB7YNpeE9kfHw4s7o=
X-Received: by 2002:a5d:448a:0:b0:331:69a2:cad2 with SMTP id
 j10-20020a5d448a000000b0033169a2cad2mr6622652wrq.62.1700573767492; Tue, 21
 Nov 2023 05:36:07 -0800 (PST)
MIME-Version: 1.0
Reply-To: razumkoykhailo@gmail.com
Sender: stedoni744@gmail.com
Received: by 2002:a5d:6e86:0:b0:314:3d27:c464 with HTTP; Tue, 21 Nov 2023
 05:36:06 -0800 (PST)
From:   "Mr.Razum Khailo" <razumkoykhailo@gmail.com>
Date:   Tue, 21 Nov 2023 05:36:06 -0800
X-Google-Sender-Auth: xIQvDSnPoOtHyBuANw5G6LZJono
Message-ID: <CAKMRoaN2Eszoa5e7u4xm_jAkdTLB7ijXdNa3vpjzn=SFh4KYgA@mail.gmail.com>
Subject: Greetings from Ukraine,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [stedoni744[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [stedoni744[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  2.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Greetings from Ukraine,

Mr. Razumkov Mykhailo, an entrepreneur businessman from Odessa
Ukraine. Within a year plus some months now, more than 8.2 million
people around the cities of my country Ukraine have been evacuated to
a safe location and out of the country, most especially children with
their parents, nursing mothers and pregnant women, and those who have
been seriously wounded and need urgent medical attention. I was among
those that were able to evacuate to our neighbouring countries and I=E2=80=
=99m
now in the refugee camp of Ter Apel Groningen in the Netherlands.

I need a foreign partner to enable me to transport my investment
capital and then relocate with my family, honestly i wish I will
discuss more and get along. I need a partner because my investment
capital is in my international account. I=E2=80=99m interested in buying
properties, houses, building real estates, my capital for investment
is ($30 Million USD) . The financial institutions in my country
Ukraine are all shot down due to the crisis of this war on Ukraine
soil by the Russian forces. Meanwhile, if there is any profitable
investment that you have so much experience in your country, then we
can join together as partners since I=E2=80=99m a foreigner.

I came across your e-mail contact through private search while in need
of your assistance and I decided to contact you directly to ask you if
you know any lucrative business investment in your country i can
invest my money since my country Ukraine security and economic
independent has lost to the greatest lower level, and our culture has
lost including our happiness has been taken away from us. Our country
has been on fire for more than a year now.

If you are capable of handling this business partnership, contact me
for more details, I will appreciate it if you can contact me
immediately. You may as well tell me a little more about yourself.
Contact me urgently to enable us to proceed with the business. I will
be waiting for your response. My sincere apologies for the
inconvenience.


Thank you!

Mr. Razumkov Mykhailo.
