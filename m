Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAB06E3455
	for <lists+netfilter-devel@lfdr.de>; Sun, 16 Apr 2023 00:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDOW5x (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 15 Apr 2023 18:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDOW5w (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 15 Apr 2023 18:57:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9610D0
        for <netfilter-devel@vger.kernel.org>; Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso22452678pjp.5
        for <netfilter-devel@vger.kernel.org>; Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1681599471; x=1684191471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jm23euiY98fsN22kiG5rHbRtDdr3VWwy800+EazcFQ=;
        b=GBfLzDMaedtUl6MyPA5MjqwskjXDB8bXlQkls/cGP4aq1jUv7RrRFtXHLwgTEGVidb
         x+yYSroQA1+8wmK2nLvfaVEN3cMOIs5qH3X54gCP+KRH3xJ+4SmDE1grbMoFifyFXlPc
         RI0xSxywOQMml3hnpp2skrtAslxJZk2wR9p79TDktIn6BkkyDaCbEmvvHIRn0QjEWqht
         8eQQirlYYZgBQ/JwhSrlewqOHstVPBpK4duQ8aUnfUE+nLGCySqyLX1g1NOzCO3wSxFa
         jm9ygqNznrgQ9S2/G24r7ngYQJBkMGHFycKgNG88gySGQA40KnO1k13R5U3FnMpOhOD2
         Pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681599471; x=1684191471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jm23euiY98fsN22kiG5rHbRtDdr3VWwy800+EazcFQ=;
        b=AmKjXoQ/At0xAQ+zp4jEBvTph44xFyCegqsek3Y9yG1N/Eb+4cot1dPpECEqe546Ah
         5Gh6prsIsFkJlsMD+/rnul5ovr1/H342ZiIkWskVwgJ3tofYlUezRvbKEKW6pWWVW8h7
         5rrojUTz5OPOIzcoMEP4AnAMp9kIqmpIFMgKbTd/jx5oAHmK1U9zu4qZuunfwr9y8+fR
         OvUkB0rAv95LUEVDOGOMmGpCJRbCmaI+GvsMndFsgMKBNSGdWWjCdtEp23zjesBR0Cj5
         c6N0dih4/3vULUuPNA22vQGtyh0EKp63oSvyRBKcgy89S4v+k58RSp6lBAXicBF0eFxT
         sBJw==
X-Gm-Message-State: AAQBX9eJ/rHeFZ1xucOW3eW47rkgaEe2P35fWbDtbOSRjw6PutOSpX2G
        siLsUqWssctFY3QNnmESqjedcQ==
X-Google-Smtp-Source: AKy350atP7YyE1uh5Cv1o1OIAdHqZyYd5TMCJvKCXUcCmogo34GyZWci+oDz1ExgkYU+uGfEZj3q7Q==
X-Received: by 2002:a17:902:d583:b0:1a0:6bd4:ea78 with SMTP id k3-20020a170902d58300b001a06bd4ea78mr7929045plh.31.1681599471180;
        Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001a68991e1b3sm4801780plr.263.2023.04.15.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Date:   Sat, 15 Apr 2023 15:57:48 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>, Jason@zx2c4.com,
        keescook@chromium.org, ilay.bahat1@gmail.com, aksecurity@gmail.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Replace invocation of weak PRNG
Message-ID: <20230415155748.2c9663a9@hermes.local>
In-Reply-To: <20230415173756.5520-1-david.keisarschm@mail.huji.ac.il>
References: <20230415173756.5520-1-david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, 15 Apr 2023 20:37:53 +0300
david.keisarschm@mail.huji.ac.il wrote:

>  include/uapi/linux/netfilter/xt_connmark.h    |  40 +-
>  include/uapi/linux/netfilter/xt_dscp.h        |  27 +-
>  include/uapi/linux/netfilter/xt_mark.h        |  17 +-
>  include/uapi/linux/netfilter/xt_rateest.h     |  38 +-
>  include/uapi/linux/netfilter/xt_tcpmss.h      |  13 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ecn.h   |  40 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ttl.h   |  14 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_hl.h   |  14 +-
>  net/netfilter/xt_dscp.c                       | 149 ++++---
>  net/netfilter/xt_hl.c                         | 164 +++++---
>  net/netfilter/xt_rateest.c                    | 282 ++++++++-----
>  net/netfilter/xt_tcpmss.c                     | 378 ++++++++++++++----
>  ...Z6.0+pooncelock+pooncelock+pombonce.litmus |  12 +-

NAK
You sucked in some unrelated netfilter stuff.
