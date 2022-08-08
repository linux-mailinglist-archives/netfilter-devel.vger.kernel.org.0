Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209ED58CB23
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Aug 2022 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbiHHPRa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Aug 2022 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiHHPR3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:17:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF33DDE85
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Aug 2022 08:17:28 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n133so10745917oib.0
        for <netfilter-devel@vger.kernel.org>; Mon, 08 Aug 2022 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=K/FYN1zvN+b7oXMhqI+KTbmCOwOgcniR1F6fn5h0uqE=;
        b=QvoasPAstkeJJnH5Dgf9AT2Vn3vrpDClIOXbggPGbYiemVj4Km7GjdFkfmw53TJjNf
         qH7NBmQ4sI3Io4Nv41DtPGnMRHJ7t7XVrzw/dnSziLz/7JIGXh1+K+F90SAIFXXYy9tD
         ZUuihtmMsQudWJ78tjXvT70r0MAiFP06Gk1CpJc7BV1XeGw1UJc/zDtBopIiXaEfT4MT
         1WXXVaOAu+kvVhh+250hoJKhnxyjcjen+X+9JhNIv5sVzJYMc8PLMeXC8aA3kN4SgzAl
         Nag99X0aaCVZ989RZ022l6j90vV5aI6TNL4ocshDQaeB4dgX8j8Nvj8RMBZBzlc/oMQd
         8zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=K/FYN1zvN+b7oXMhqI+KTbmCOwOgcniR1F6fn5h0uqE=;
        b=XYs2gV1M8m6oxoPDfPI4UDwyory9W0stmDWG/xVw7ptWekYKgKkNKl8qFaIxCGVrry
         /av6E8WTgQdys3nL0y1NdfYa/QcZe8jwgjlLSUZnTMza+rXpna8yRHBcwg7BVkzSWUgT
         w8/C24vWAF1NDbjw6F8h9soBHkHtX8vO5QoMIz0rgK+Mv4daDXGwn6HfCgjDuuZrJVzR
         WbpJgEfxH7k39zFPZxEtET8W5+H5DyuhNYAjNhRcaKW7zdK3hIscWztQSPmHPzxQwEHI
         lXD1fjCOSwgDGJpJUK3ltb3iAGuS/yOrtmcxm0IuQFjEpdDPhYP6a1vqTt6OA1CwRC5b
         pVnA==
X-Gm-Message-State: ACgBeo3QnrczbselcZPaFhIf+4QyydYdH/be3MZI25RPYf8uzUSIlXJe
        LfcIu78Dg5ek5mkNK5yodO7Oe41vf/u1dQNUSX0=
X-Google-Smtp-Source: AA6agR5mN5KjgNtJeFKa+Q8yAAiEPFxTosH85D6oINOaaLCybtp9f5DRpitJLH6rx2oG8cHyihoyOCud1jgZCdTU9R4=
X-Received: by 2002:a05:6808:120a:b0:333:54f1:351 with SMTP id
 a10-20020a056808120a00b0033354f10351mr8121018oil.70.1659971848363; Mon, 08
 Aug 2022 08:17:28 -0700 (PDT)
MIME-Version: 1.0
Sender: gigiagbozo@gmail.com
Received: by 2002:a8a:907:0:0:0:0:0 with HTTP; Mon, 8 Aug 2022 08:17:27 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Mon, 8 Aug 2022 15:17:27 +0000
X-Google-Sender-Auth: BS7PCzk3rgpndhTHCiUVcw-e8NM
Message-ID: <CACTXA_C3XKL02=MucjpF_Bq+HC26gLEhKLRvwZ9rkWS7_=_zcw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello how are you? I hope you're okay. did you receive my two previous
emails?  please check and reply me.
