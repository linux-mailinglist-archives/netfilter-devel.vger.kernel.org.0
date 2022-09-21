Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0F5BFCEF
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Sep 2022 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIULZW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Sep 2022 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIULZU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:25:20 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7973332
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Sep 2022 04:25:19 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id v192so2979071vkv.7
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Sep 2022 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=hNjCnErblRwAyAj6FlkKQb2JciLGQqPu0wp0kKsDJDg=;
        b=Rgb8Rko5mdgN/Em5VsD/PzqgLEKxkJX+8cevHYig88xgzh0Us38EHPI2AWipgs5/sb
         +wDU1/UIQ7iQTOd1ji2joLpdi6W4wyJaZDCV+BZ2ddfpmZhBlZTi1XzX6EvPiHpidlg+
         blbstW2tUWzP5FQseJ4F45OFFhboD4OfWZ2nFm6k7dKTeKuO3zqI7oUTFWIprD7L9KBr
         yv0/Y/1bPnJaPkCVGPPoapgODBrPGK9Cg2RP55TgAkiWbF740h50xEcX7i0Bu0984Wxw
         VK3FuQMoJSY+/1M38gVanh0tTYplOQ2z4er2hgVnk36yCwz16tdakfpTXI7BndVv6peS
         V8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hNjCnErblRwAyAj6FlkKQb2JciLGQqPu0wp0kKsDJDg=;
        b=dvhrqm2KTGtyLifH/gDANl3o6liNOStrDuyIzgZIm6EzohKVqJjvqdpHJixBFOqLp6
         Ekmx8w25+CVfRHYSpfIfA3OD0ECNqem1genS/RzQVZLM0gs9K8BQ0khRT5ssRR4O8H0w
         yRjoTMnrHILybxITWEEzWQ4miTlRDXXYpa72rviTIWzHr4tZbHqaAUWY92BW5UV6r+Ld
         L+dC7qnnvQTxTlpX9AHFlAxfiaQ5MNyy7ZG1Q1aRPS6DMcRkv28gwrRz0c22Q+DEg4IS
         usuaavmigCOyJbJzWDCBe5QlkCy++J6OOHO/ts6InFoUj0GaBHq8o6/m5odfvFhl4WGe
         y5cg==
X-Gm-Message-State: ACrzQf2J0rdt/jOWA26DrJtoaxjfk8SvKI+sBShPTeBNtQPVsSJ9CdWK
        b4IE37mEUuS/DI+AfWbQlxPY+1QPX9aHp5ZFIiQ=
X-Google-Smtp-Source: AMsMyM4WvNWArcz5FY2Pwx43Yhj9EHXgGfrlEKMjOTnUMqPQbYJZqnSEydwTKhph1KbDw/xgqNk3cXfGSvBlc8OHUng=
X-Received: by 2002:a1f:1704:0:b0:3a3:7b3b:a5d1 with SMTP id
 4-20020a1f1704000000b003a37b3ba5d1mr5694160vkx.3.1663759518620; Wed, 21 Sep
 2022 04:25:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4545:0:0:0:0:0 with HTTP; Wed, 21 Sep 2022 04:25:18
 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Michelle Goodman <michellegoodman001@gmail.com>
Date:   Wed, 21 Sep 2022 11:25:18 +0000
Message-ID: <CA+jr58q=KrGpp2U4daOGJkLCFPMh3nqFWFEJiA7PxU82OjBYgQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman001[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

TWVyaGFiYSB1bWFyxLFtIG1lc2FqxLFtxLEgYWxtxLHFn3PEsW7EsXpkxLFyLg0KaMSxemzEsSBj
ZXZhcGxhcmEgaWh0aXlhY8SxbSB2YXINCg0Kw4dvayB0ZcWfZWtrw7xybGVyLg0KTWljaGVsbGUN
Cg==
