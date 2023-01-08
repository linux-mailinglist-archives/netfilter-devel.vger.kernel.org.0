Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DE661593
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Jan 2023 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjAHN46 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Jan 2023 08:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAHN45 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:56:57 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE6D2FC
        for <netfilter-devel@vger.kernel.org>; Sun,  8 Jan 2023 05:56:55 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so4611285pjf.0
        for <netfilter-devel@vger.kernel.org>; Sun, 08 Jan 2023 05:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcpM41K3Tg/Gq2Sy2fOw39ukTQf5X/VzmfsS+yU67xU=;
        b=KEW1uA95W83mO1+vVHYnP/RPB2eVYPV7ayenPBDk2MNA0R8eI72I+xLBVZ6h1dbzZ5
         IKqz2LlKUY0fSmJpT97cxSqqxRrrB4dSEH5yt62Nfj4h+8dR+uC6X+gKCi56w9Udb0Lz
         lv0JRl3rzun04VV2pScW0HdCX0QwE13NCxI+KCNGA+Apz9qhMdMVjiY6XZdSJf3oQwyZ
         Q4A/DSAcdj7mVncKkiDF/u4TUQtKU6wQo9KzMOB40EuMM4dRTjiy+SPdUsBjMZIOdYbX
         la593oQA0txirQjBJV0z6jzay2LfRZmo2Yz7ZKJdtvb2f68clgtf00HeHM9RAj0ICIrg
         btbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcpM41K3Tg/Gq2Sy2fOw39ukTQf5X/VzmfsS+yU67xU=;
        b=zEGCfh47y3ZrreCbDHJ5M0pLXeTFAtjpwFAQiOIpyT0ja9MWYc1XwMkmghVAnDK0T5
         wRikQ9Q3jcngO7g2PR+HB5mlyLQJmC2DvvyFiZJ6XxD6qu2IG5gvIXhYePE/5fy3yO/s
         bbSaOrayrXREILcCMpEd+Ol2mWI6aQjfATeMAUbNpK+vOgvwrIHtgkXsSz/60Z6kLegz
         V7EtUzchLoXH+l/+gbAodKAlpv2p4jnmIq2p6aTYJTnLC20xbiU/1KEe8GCn2KblL/lZ
         7tpgcGBu3CdFAlzToiV7PXka57ECXfIdPFgaE2af4IzsbnN9MXFE6uZN2fjKRbRjUcdE
         r12w==
X-Gm-Message-State: AFqh2krZN47JMnRQ7pvAX/jF0Ew+EybSI8mARXLFGP0gnfD7pd2KFotb
        QVKXPItbb0+hC4QLplY7VZ84M88G5qfWy1ZmUIY=
X-Google-Smtp-Source: AMrXdXszcWMQPjb2mcCW2ed5N7gHY0Bc9T8gpYexbiURqxjXgJLmErPYn31ImjA9qwZZ46d1phV8kCO77EIrvjZWjeg=
X-Received: by 2002:a17:90b:78e:b0:21a:1a66:cd91 with SMTP id
 l14-20020a17090b078e00b0021a1a66cd91mr4680665pjz.190.1673186215049; Sun, 08
 Jan 2023 05:56:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:6890:b0:50:37fa:6d9b with HTTP; Sun, 8 Jan 2023
 05:56:54 -0800 (PST)
Reply-To: muhammadabdulrahma999@gmail.com
From:   muhammad <jameswilliams0j@gmail.com>
Date:   Sun, 8 Jan 2023 05:56:54 -0800
Message-ID: <CAGpaBj5ByuBnrf1QzfiFpNFos_m5UqYqpRnV00zhhR+gvnwCww@mail.gmail.com>
Subject: Re:Urgent supply to Qatar
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5015]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jameswilliams0j[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [muhammadabdulrahma999[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear Sir/Madam,

An open Tender for the supply of your company products to (Doha,
Qatar). Urgently furnish us in full details about the standard of your
product. We will appreciate it more if you give us with Details:
Specification and Catalogs or Price list via Email.To avoid making a
wrong choice of products before placing an order for it.

Terms of payment:An upfront payment of 80% (T/T) will be made to your
account for production,While 20% will be paid before shipment.

Thanks and Regards
