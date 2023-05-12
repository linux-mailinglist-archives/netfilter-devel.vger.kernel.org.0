Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63B70037B
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 May 2023 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjELJTA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 May 2023 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjELJTA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 May 2023 05:19:00 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835BD2DC
        for <netfilter-devel@vger.kernel.org>; Fri, 12 May 2023 02:18:59 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-54fd5aae4e7so2459364eaf.2
        for <netfilter-devel@vger.kernel.org>; Fri, 12 May 2023 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683883138; x=1686475138;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7upYASidmeqEEydII3qqc7RD6bnaXjO6ELYE2uwAgE=;
        b=qzl9VYBCeMBgkUkG8VBzGdf+TQ6yKWPBSBhnfWKnjibxOcfhf8Ik9zHjzj8zyxH+ni
         Fm3qmBF1db3ooLM+c1iEQDtQCzbwOdyYzs96brrn+otb6Q40wd4hYuaRAFBZRYx4W602
         ITTw+QnbdOqlzvYw4CkzA61NYXgjrQ2XRKZgRrp1bgwvfEeXdk/jqJyyliQ7mpL9vt1a
         3DaFjHsuxWqtunC5vmTzeV4gVHksAZOzwkFPPbjTTrkFGJNDcI9HTRTo8jzQwByRssNb
         pPizyfUd0p2EEOmCJTrXPvqEoCuHIs7A/F+4e92xj1oxb6iBkBFEqwcT76oCMgLkAZVC
         f0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883138; x=1686475138;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7upYASidmeqEEydII3qqc7RD6bnaXjO6ELYE2uwAgE=;
        b=imZ174vt9ArM7nmtBP67XyCDHTPTyk1zWaDTPgoboeWXn5+i7XGMSNvXNvvS8iFB+T
         uh6SdjKUEb9tnEyzTKoxZlZ9Js998RQyNawb24dQEfxULOGt/xTAkpJZnfo1j8HPGrLa
         7Zy9I1bq1C7bnnMzK5aHO17WPSAyrVu508dvXiyRfq90HrTOZvkHZNMn+OOdQYwC+wjN
         USwhG8iKAa8v/WN0qsEEyRvzbH0GhQMK6MUvZwddQxHYELdtQJa2fpMJ13cDwdcFUHWM
         axoY3MKdQB2DiTUzLw91+fxyx7M4g8bNjFXNs53qM1Hgv/fS6wfEiaj3wiuiQPOTRn1V
         9IkA==
X-Gm-Message-State: AC+VfDxrnmQcp/6xMMZFRquuZcytBzRz1yIzeZmb0dgqj1XH1AhW78jX
        1m4MvaY7Azxab0t1qP92/UgbWRTuoPXZg7TCC10=
X-Google-Smtp-Source: ACHHUZ7adNXSvh4nUwa53h+iP0BRtZI0dPGwn0oNKYrfT6QtLzX4ncWq6xBkH0Ugx26Hidsk6mfb132JXTKi2hJ9elE=
X-Received: by 2002:a05:6808:a0c:b0:38b:4214:94f3 with SMTP id
 n12-20020a0568080a0c00b0038b421494f3mr6146201oij.24.1683883138484; Fri, 12
 May 2023 02:18:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7f10:b0:114:da1f:fde3 with HTTP; Fri, 12 May 2023
 02:18:58 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame003@gmail.com>
Date:   Fri, 12 May 2023 02:18:58 -0700
Message-ID: <CABt-BZ6WshkA+J4ta4gVrw8UGmCVAhWkSVS0Eihj-yGaQxXiMQ@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
