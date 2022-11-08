Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DB6211FC
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Nov 2022 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiKHNIj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Nov 2022 08:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiKHNIi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:08:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31A12D0B
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Nov 2022 05:08:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k7so14130874pll.6
        for <netfilter-devel@vger.kernel.org>; Tue, 08 Nov 2022 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=DKkWfxExwMlEUJXNP6lKfjyb4CMccx2Kai3Q0h/Roaelr7alr5uAkTo62gd3//EKF1
         u/2zEzeJv5VIaaqataB1zclP63Oh4T0RIF6WHq90ryfBcWCt1l8PJITeTlJL2J8NT8CL
         GZsliKtJInFjIPLbI2HgYXJKmMxUJl9MSNLCqqkMdTfKUlpW+2/va5HtK0XoYg2cdKya
         O91VZ9jBHFIfRUXEckXlx+Up/+BxrWBKd6T4C6nR6gjuZsTjiElF4faWZM4wvhutMuo2
         a3hY41PvxkuFETI78LBZNVuV1ml1LhejvXQ8zAgJAPc07//imjJmrdrDqwbr4f2shXEG
         9H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=z9tw/FPI48AhuWWW5x53ehGibydP3x7C8MqN04CNN58R2TbF6zFWKe/fLvXtUbx0gX
         ZE3y8jN/Ar1G/sfxqAq1KwJmYhASqpYhQdGKq1w1WcA6hPWso9TBfRlrgpKIUuc9nEDa
         xs1ESHmIVNxZ2W3rNdo25QX4ZDEYwS640fUyAcZqFo9k7vG6LgwUGxTgMlg1mCpH/hJM
         nahtNeCJsBS9/2wSG0qywviw84yo0tM4Ee+D9OShBIpqVP9qtkXSJ1ERCcd8STuFj1If
         0lbVKE9hMER1rWer5qyLLDPqIJRDFeypH9K8NA468qPrqWJkRUNj0iFHFrYehDAjZ1G5
         VYIA==
X-Gm-Message-State: ACrzQf3rbRO6dkuhfYxvzW3YVPeVpKfWBHaz6F5q8dT/nuozmu2NJtW5
        ty4J/KWGUMFbwgKOPFcFuzc6bDZq9+rlcK0yi4M2cpbMoEQIXQ==
X-Google-Smtp-Source: AMsMyM5tdOYLdG/oxKOBN/WLHl4YriGuBMSS/iGMoC30zQYR1SEKqy220Ddxri5UKqj7OmrjP6qodRR0EpWYfh+a+NU=
X-Received: by 2002:ad4:5be4:0:b0:4bb:e947:c664 with SMTP id
 k4-20020ad45be4000000b004bbe947c664mr44158322qvc.122.1667912906076; Tue, 08
 Nov 2022 05:08:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5cc5:0:0:0:0:0 with HTTP; Tue, 8 Nov 2022 05:08:25 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidkekeli1001@gmail.com>
Date:   Tue, 8 Nov 2022 13:08:25 +0000
Message-ID: <CA+f86Q=8f8EXvBeCBtU7zSEiurpSyEpYw5gxR0u4R6X5kQTDOQ@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:636 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4947]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidkekeli1001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidkekeli1001[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
