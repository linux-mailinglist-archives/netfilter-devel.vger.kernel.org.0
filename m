Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778DC775012
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Aug 2023 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjHIBHp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjHIBHn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:43 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26719AF
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:42 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-3a78c2cdd77so6889921b6e.1
        for <netfilter-devel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543262; x=1692148062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVz1ojRkhYeSRtVo9H/tM0do8XQLIQHE9IgccPkP+yI=;
        b=YM0EF08LMQ5WvMrXeAp8gjjtszwUk2pUWzHCMZ0zn+G2isYfsms0AEcAOJHR+FzqoJ
         5gGzXyXgO1s6N6jbssTgI6zymokr1AXoo+FhWaVJg4ihaxML7ucWHHuIxbr5HzCvt2MG
         Tt3yOmk7P8lv4yKQX63qFntp01EHrSBjsYSJq/s2dMp7zCD1Je4SxOgsOQ9tGtmEzCoe
         SpySLAiirdXb9RHkLdoS1GVfBe+V+nm33FdHqqxIkhu9U007DhL2rTOQ0/2K+sDSPX6C
         uGWsZ8A2DtO3QHV8XEPMcKLOS6G2USuAt/czHn56zM0QWZ4AQUFXQcNZZzbRLXv8blyO
         iMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543262; x=1692148062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVz1ojRkhYeSRtVo9H/tM0do8XQLIQHE9IgccPkP+yI=;
        b=Ql9FzQZ2GkP+7bHUIYoaGxvM4uRXdiVDxaABy0X64O3oFzC8TFWpQoKC2SLRBcT4F7
         04ho89omGlVF4nF67wFFxKOGVnJwNRynlgKQEd8QapyM/bKdu/LyshQej0kHnGdPqyw9
         H6I0XzZ9AkZ6mpTyqELRiS0IB7vfkumB4dH3WSxBr6QpsVO6EHNFrc6flnKg+Z/gbbx9
         i0v00lMAksV/exi74qidIR27l2qreS9P37qiui6PxYOUQ4eR4k2WkDIAYbTF2IFSHJDI
         ZvKkswlCte5KyLMvVAFsvznBk3xvAXFG97bZzjOPZ5uOM3ekl4+F6hQ2sgGrSw1sFUhF
         6a6w==
X-Gm-Message-State: AOJu0YwqoqfwlFM+hrI1pxHOWhEFAenByTRRv2GRqhzttcvbATu1vsiV
        ZsImQsu2Y8S6h/Jo6SgZ++5M1jDblZTtnowDJw==
X-Google-Smtp-Source: AGHT+IEKxVs1OlcWwiqA53GB6oh49zRgHksKsF0BWd5xdJypQdb1s8ZOL6iCRc3UIvJ02CL7Fj3KY4dzDtnnYJ2MCA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:1594:b0:3a4:18d1:1686 with
 SMTP id t20-20020a056808159400b003a418d11686mr793268oiw.10.1691543262146;
 Tue, 08 Aug 2023 18:07:42 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:06 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=692;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Rb7knhgVRoO1cFP5KZBOoghV8KJqLMcT0yWjrGm/ENU=; b=SGRqAQLRAvrm1QwRllI6+LYWlBGAQP3OWJJwRohe3cZ2RB+HyT7yASIlpFuvkLVwAhf0uTtpO
 XHh1FrAHIHoC+nIE6P/23cWFGuKLtpQSj4dwTByKp1fsGBUz1TyiFoX
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-3-5847d707ec0a@google.com>
Subject: [PATCH v2 3/7] netfilter: nf_tables: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Prefer `strscpy_pad` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/netfilter/nft_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 6e049fd48760..8c250a47a3b4 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -150,7 +150,7 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 		if (priv->flags & NFTA_FIB_F_PRESENT)
 			*dreg = !!dev;
 		else
-			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
+			strscpy_pad(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
 	default:
 		WARN_ON_ONCE(1);

-- 
2.41.0.640.ga95def55d0-goog

