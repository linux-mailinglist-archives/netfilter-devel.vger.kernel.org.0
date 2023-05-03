Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BD6F5BF5
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjECQ2O (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECQ2N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 12:28:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88F26A9
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 09:28:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso4172531fa.1
        for <netfilter-devel@vger.kernel.org>; Wed, 03 May 2023 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131291; x=1685723291;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1o3TDsmabgBewcVwpqP80qF6wI2yiYJ2QQkuG02ZCd0=;
        b=XbHh+MGtX4JK5c81Aoh/iJLuHgqQrcWWGk+t7OyXwrNX69zOUk1o9haOpdOMcX+o4N
         LKDYy49UreOr6C+reFATF3sw6goyEsmaOptLlhtMa8LPXeakRlcJqE2wwijwr1oMGCk6
         jwb2u5CNYcvbcbXIC/Xl+rFAE4Jra/CIeCbpNhkAM2/K1CDq1AShh+WsUuvUOXZdrH4z
         1QunzbBof9oN0TMZRpClmyqz+iE2as/CCl2U0znMxtBSH3ZEm9CueGJzGCVJPDviq3zl
         7Y+VX/2kBUB6Xe4ngRWTs4AyGdXiq0OJcb+ZiMQj0UKDzPLUEkv/UM11jjrhz9E5LOiV
         vFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131291; x=1685723291;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o3TDsmabgBewcVwpqP80qF6wI2yiYJ2QQkuG02ZCd0=;
        b=k2W/Z7CuidW7u758fmbgddpkXkChqLEzLp3dHkfU7zTT6WMS0N82gz0Pphtsnp2tnK
         xis69RUIzRzllzxT6vSILeXGZAHymbaRd/Nw7/NeUPvlB/FFGP2ydt2sv3NZWsgdE+G/
         vNWLRtQeHvVTp7B1gevqCLCys70l0j1x2v/oiY0yTWuV4WyPwHbUIlEz1MjDA4eWEIrl
         8IWxH33658D0x3Y7/7XX+r0dfJzXFW1wcU9G0IXpOMfFJMCzt1FldrL0FGjBv5l5GeZp
         F2DYsrRCc+6dEenXd9rRfbNCi69OMnf83eTyU0stSgQFi7U5hYLvmDrwNI/4tnS2RM7u
         hzSg==
X-Gm-Message-State: AC+VfDzAcBIyIycVI/B4NGIYpxwCvXonvcHeAZyfgLM0iRgrH9z+n+Gs
        9ylxUHr+5nsYjDkgTGB+ocCL898bgfxpOhw0oxY=
X-Google-Smtp-Source: ACHHUZ7lgNcP9gqysdRrGgmm74Z4Qz457LDMGGZXWUpuIb3j9Gg72sE6ve2+7W9JjiWJfrogHBFi9xbCHJKsDhqmoMg=
X-Received: by 2002:a2e:330e:0:b0:2a8:c842:d30c with SMTP id
 d14-20020a2e330e000000b002a8c842d30cmr152796ljc.44.1683131290763; Wed, 03 May
 2023 09:28:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrstheresenina112@gmail.com
Sender: honbarristermatthias@gmail.com
Received: by 2002:a05:6022:51a9:b0:3e:7a0a:82a5 with HTTP; Wed, 3 May 2023
 09:28:09 -0700 (PDT)
From:   "Mrs. Therese Nina" <mrstheresenina112@gmail.com>
Date:   Wed, 3 May 2023 09:28:09 -0700
X-Google-Sender-Auth: 9oQb_0CBA3xIKMcFet9RzUOUcbw
Message-ID: <CADkLFNzRRxLvdcYWKsgshgBO9AXcj45b4LD+cPzTCR7e2Dv_rA@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_5,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:236 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrstheresenina112[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrstheresenina112[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello Good Morning

I write you this letter from the heart full of sincerity and tension,
My Name is Mrs. Therese Nina, from Norway, I know that this message
will be a surprise to you. Firstly, I am married to Mr. Patrick Nina,
A gold merchant who owns a small gold Mine in Austria; He died of
cardiovascular disease in mid-March 2011. During his lifetime he
deposited the sum of =E2=82=AC 8.5 Million Euro in a bank in Vienna, the
Capital city of Austria.

I am not in good health in which I sleep every night without knowing
if I may be alive to see the next day. I am suffering from long term
cancer and presently I am partially suffering from a stroke illness
which has become almost impossible for me to move around, I have
decided to donate what I have to you for the support of helping
Motherless babies less privileged Widows' because I am dying and
diagnosed with cancer for about two years ago.

I need a very honest person who can claim this money and use it for
Charity works, for orphanages, widows and also build schools for less
privilege that will be named after my late husband and my name; and I
will give you more information on how the fund will be transferred to
your bank account.

Warm Regards
Mrs. Therese Nina
