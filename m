Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE10770DAE
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Aug 2023 06:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHEEOh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 5 Aug 2023 00:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEEOg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:14:36 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA44683
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Aug 2023 21:14:34 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56ce936f7c0so1964845eaf.3
        for <netfilter-devel@vger.kernel.org>; Fri, 04 Aug 2023 21:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691208874; x=1691813674;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=dt9Sj8c3Q/0wBrji1Pi7jAAB+VxH9CTy+btQVDZbXkQZbTj5Ajo3H/ynQADWRg/GRv
         35pqTJvTnGyGswZllmPWE40kXwwmauamw5zo73oZZrbO9x1Cwnk3ciVmJg4Yif/WT7+b
         B3Ez4+VbXGGCFl1TyYJ1nHFrRCP6I9/BJ1nsiADEUqvRMArl+rlni7snMLPF9orJYORJ
         ui3r3jVV9an4zO2j8nEeSWZsDZmQK0ciufuw3ZU0SdyDq53rNETGQEa12oACBIDIu0P4
         6y+Nssi7am1lUa6P+8VYVS1wQWGtBpNbFulsk/tf9Zast6SJ+3yyfh/lcoPKYfSExPi+
         UKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691208874; x=1691813674;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=jEWAJH4KTJfg1npu8O2uenfkv8aCT4jbFbk4HTIscp2veVuO3uygMe8BoUsfb6u/9c
         jVqvlEXgxcjMGsodfo/j5MWMI19/PtH25v5vgc6i3pWG6yjLC1unr9B4mYc4AdfH1k8f
         XV5Z2hUKYTSntEBHLXctBF9F+Xv/J9qX5zboF0xd9esn9DDcf5WcNeJhjcaNJwuw5xMX
         Ew/zHXBLurazctCHIVT8Ml8wZOWZkqBrhzxeFqAkpOHLYdzJaxHpRVrllkwLj4J8rAQz
         pRpFwqnjdrZEmeXfiegtKxJGqVpftMkUbGONTza8zBVgh5R7nfFnarx1mA2zNnJ1WaME
         O/kw==
X-Gm-Message-State: AOJu0YyT6nU1qppyxO/DWvVZp39tubKHVvFjzFc9V6oAz3JTX3a7a1jS
        aAWn6GFrskHbitxYm6/C8NG/zj1cpvFK6Ab8xMw=
X-Google-Smtp-Source: AGHT+IF/AsSvZAkWr2Uwm34FjyTsq2fT0ABI/+cFr15Mjms9ef2GqNUp2PdVDGh6VRPhKeYkt1nVbj7TDf7jMgAZVHc=
X-Received: by 2002:a4a:650c:0:b0:563:5666:5c03 with SMTP id
 y12-20020a4a650c000000b0056356665c03mr4075277ooc.5.1691208874190; Fri, 04 Aug
 2023 21:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6359:618a:b0:127:358e:515 with HTTP; Fri, 4 Aug 2023
 21:14:33 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   BINTU FELICIA <snfinancier@gmail.com>
Date:   Sat, 5 Aug 2023 05:14:33 +0100
Message-ID: <CAFzaTZs_UtdhTAYH-WdnWF778YrxaXVmibVHzPP+eBymyCSeRA@mail.gmail.com>
Subject: HELLO...,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail
with a wish for much happiness
