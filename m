Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5B6CA0AF
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Mar 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjC0J6n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Mar 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjC0J6k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:58:40 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468DD59C0
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Mar 2023 02:58:28 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id n17so5861355uaj.10
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Mar 2023 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679911107;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYcZPqH3I6SUi+3HZiGlz7bBbKQQVG9vXsJL8zyyX8g=;
        b=P6uCWhHf2jb3ORI3C/HMCZ7CD0wwHp+HeoK87Ilg4GWNkgcsWS7IAuWT4spA6BT1xt
         UhqD2JRdVSO3viSCg5KHe256b/WXM5dpgRem7cyTfl0tfhnXmRPcadqXplCUmP3ql8pD
         W34aTsTy7QyGJwSS615do3gTNE0VBdL5YlZw7ysfdnrcO0L4iGbqp4CpVz3KhNITJpEG
         /Lb/xqlrnw8lp1JCag1tsceeggZT+ggrV0A535PTEg0iFVJR9yisWBOtUYZ5LZsX1BEM
         /8q7A0GqEjgBuZV0X2bwyrYtAgMkNYY+1l2PF/aUJ3AJl/1TYrFFrA9XFrTAadmJi63H
         y4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911107;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYcZPqH3I6SUi+3HZiGlz7bBbKQQVG9vXsJL8zyyX8g=;
        b=q5Jas+cYqs35lGwjKfXyOkOehxxA3meS4g75BS/ICFmUg/iFZn804P5/2bGYvzTUon
         jPu0p/Z0rYuITPErfIxa7wEj6i/ODfMn79PTvcvcSsRbpYzxcDNp34kuLGS8QGPdPYb7
         9N70KQNBlFjxyC9cWmsjpYyhOWIC5uKM0ZyHmNGLUV4dUnqKDK3L4YYOKEEA0I4IfE6X
         g6tUFitm4Gl8XYRhHkkkC6c1GPlZvSE6OPwL5owytSzdcH9EkLFHJ6aVu+mPPPXiwQOX
         a5/Spq+g08MVYiaRZ8vIvkcapOpnjtI9jVsWAOuFjZbt0OSwqP9NOyDejJAtf++dizCJ
         josA==
X-Gm-Message-State: AAQBX9cNrjx2nfkDlGpvT/gRa993Y/cnlAPU6p6zXunOD4JowW8vNz6U
        6Ohml67rRMT8sY3IWgoyzZ4nK6hkSThdjmNi+Xk=
X-Google-Smtp-Source: AKy350aehYmpAuUQK6bWHsG579UK/SCF/87xMhNW6I7vQUVY72IxStcb38qnMJVWk4q3/fMEjmeGOUuNGogbt6hseC8=
X-Received: by 2002:a05:6130:2a9:b0:68a:5c52:7f2b with SMTP id
 q41-20020a05613002a900b0068a5c527f2bmr7452968uac.1.1679911107323; Mon, 27 Mar
 2023 02:58:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:1450:0:b0:351:e0de:eb1e with HTTP; Mon, 27 Mar 2023
 02:58:27 -0700 (PDT)
Reply-To: annamalgorzata587@gmail.com
From:   "Leszczynska Anna Malgorzata." <pastorwilliamleung@gmail.com>
Date:   Mon, 27 Mar 2023 02:58:27 -0700
Message-ID: <CACGvA98GXcPy+3gSjMWF4TjaX4AXxwmyHu+u8v+wq-u=iObjjA@mail.gmail.com>
Subject: Mrs. Leszczynska Anna Malgorzata.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:942 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [pastorwilliamleung[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [annamalgorzata587[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.8 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

-- 
I am Mrs. Leszczynska Anna Malgorzatafrom Germany . Presently admitted
 in one of the hospitals here in Ivory Coast.

I and my late husband do not have any child that is why I am donating
this money to you having known my condition that I will join my late
husband soonest.

I wish to donate towards education and the less privileged I ask for
your assistance. I am suffering from colon cancer I have some few
weeks to live according to my doctor.

The money should be used for this purpose.
Motherless babies
Children orphaned by aids.
Destitute children
Widows and Widowers.
Children who cannot afford education.

My husband stressed the importance of education and the less
privileged I feel that this is what he would have wanted me to do with
the money that he left for charity.

These services bring so much joy to the kids. Together we are
transforming lives and building brighter futures - but without you, it
just would not be possible.
I am using translation to communicate with you in case there is any
mistake in my writing please correct me.
Sincerely,

Mrs. Leszczynska Anna Malgorzata.
