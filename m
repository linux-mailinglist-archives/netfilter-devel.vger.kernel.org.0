Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241C578A94
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Jul 2022 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiGRTVx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Jul 2022 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiGRTVw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:21:52 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258492F024
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Jul 2022 12:21:51 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id x125so11350098vsb.13
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Jul 2022 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=OGqMy3HvNvTKO+luoSzwV1yxmXaC6bU3xFi4O7cPdlkAx/EkmVRO49TXGOCgvcmE3R
         E7KtA9GlnnoHcpymbMnci1WW1rx2kWIjjWedNOiPeZfvBh1L50m672F853ryr7OwSedg
         Q/NVZphPZM71MtJPO8fu5B9U3VnCdQV0/cmUC+6kTNdBv3X347yFnn3VwyWdSKLMKVfq
         Qcgs05ylyW2tuX/lfRcYfmHwGVBls7+2+7d64l+zd6M0yhB0GvxxV5jNfJBZzgYCnYS1
         G51kAfB1zaQqjK03kZCo6h5ofgROQcdNWTbFqbMdWnZoKZz9bUiZIXpb6y4E0WrCi3C7
         xQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=mTVedESgb/YN6FQZq9QrXpAeDz+RY0yo44b7jrtXN1PrQQFSW/4sTlWWs0rzhUxUje
         X/nEEpLv28eNYVK22i9en9zrkKlxYi6NMgEdBV45lxK0xYgtlrEPzf1dFauiT+aGGXjh
         x8DO21hm2balrlOolwlOBcqf+aLIsb8JHRGlsKmbgF7mEr2+7toJW423+0Apm/PjC3PY
         CKECL4tuibG4lFxBe4r5Su4nJ0ICGLgiA3xwRivnYj6m4cSqp7+NeZVoO3bcSmZF1sSY
         Cbbmmguj0Ti68f2CZnk4A4L70HT59hstjOGy/jwrFUqbCwx0hAuFVRXv3rMwj+uhlHba
         +ayA==
X-Gm-Message-State: AJIora8Zif6mguFQoC+snt7W7lPj9HuaAgsFH3pgSrxAIGMG7rWsWC1O
        Y+i1Zhd+gOZgPIcALFEDXYAE0FIDxplTZGHTzJk=
X-Google-Smtp-Source: AGRyM1vt+60EWabhB79LlcBX9N3fQecyYGAPAFhAToEGYuaaAalF/arJ+vmS1EJ8boNQBQivY9/rspoNWUz3sHRng0Y=
X-Received: by 2002:a05:6102:667:b0:357:6577:a994 with SMTP id
 z7-20020a056102066700b003576577a994mr9869005vsf.77.1658172110053; Mon, 18 Jul
 2022 12:21:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b12a:0:b0:2d3:5030:bb10 with HTTP; Mon, 18 Jul 2022
 12:21:49 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <blessingiyore3@gmail.com>
Date:   Mon, 18 Jul 2022 11:21:49 -0800
Message-ID: <CAKQJGJYzfW+sOx077B4qEsYGsu7kpg0V5BmSrQ+OiJoYWXWQqg@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [blessingiyore3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [blessingiyore3[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
