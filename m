Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2456ABB8
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Jul 2022 21:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiGGTSW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 7 Jul 2022 15:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiGGTSW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:18:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07F5C9D5
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Jul 2022 12:18:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k13-20020a25240d000000b0066e32c61c25so9873336ybk.3
        for <netfilter-devel@vger.kernel.org>; Thu, 07 Jul 2022 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tVSk6aDePRlfaMKbBa1wNYKRnA8D6KWXesEA2nPDvx8=;
        b=rKGylpDT7+YQfH2LTSbtEjJ5z8UmpAYYaiJ3XCVUTC8D6MNAFRsPeXRNLoKi/8qJ1L
         PbZSRnEFFzX3ICffc8QHxWwNMx5JgiHxbnyKGiRhDjUWrFb4i0jfRESAhKpBgE/ZJs9c
         SteCEmJF+blqWfdNGvgeUtJqN2lTVF1/zBWz/efTDiQ2KMiYy0CeajTiFiVmkZt0fc+R
         ny25GCY0WIpHH/Q0jO9EUYjJAVsxcKsBtDG3qaEc4OsinMkHGHOrKjuCK0S5Gcp4/BER
         aT44115fSbWeQNHRTTv26x4wIzTI7zml1jBo1P9yci2IGTLOdAIGcDIBjpYo6ZP6U/O7
         FS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tVSk6aDePRlfaMKbBa1wNYKRnA8D6KWXesEA2nPDvx8=;
        b=ETTYz96Ew/Q4spbkoUaFcXDBkuBK3xMtTSAcdqmzBhDhWqlKkAphyoSdiZM/zVmSX5
         184bAmqWLi8IquNN9RY77uPJ6y+aY8z03KBCLHFJwXzC45avMRhXKD34D6XnCn06uUpS
         MiOftK46LQbf7jHXQPY9cp7AsH4XEOxbfHtCpBtMfN68DfGvmtgKEIuAWg7zS0VRl9Ck
         QNp07jkhLTpICLR44V3ppAeDdDnLYl/27BGjfpQZLGeBT35xdf27aZQQIZd2jILE6hRm
         BV+VfG+NhMkaVC2N/5PcZF9wtSa7UzmUlEJxfzIwJFx5wEeMJPvJTavq31LZObnZZ9kA
         AW/Q==
X-Gm-Message-State: AJIora/2M6DnGpv1kBlkkhHFc3nA364mGYSBTB3eBSNNK5szsmfRhe+q
        Bf3a7Vk5FQebFj5OKAq1BYHG+Ihb6MRgjyaecw==
X-Google-Smtp-Source: AGRyM1vh2aNec0y0qNtJWHVhMXf3oe7xSDLFg0L29X/v0RrKNisGF3nj4CLEjmRA1x6E5hJB+xQxWYpEpTP2r44U6w==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:4640:519a:f833:9a5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1184:b0:66e:756d:3baa with
 SMTP id m4-20020a056902118400b0066e756d3baamr16339226ybu.533.1657221500162;
 Thu, 07 Jul 2022 12:18:20 -0700 (PDT)
Date:   Thu,  7 Jul 2022 12:17:45 -0700
Message-Id: <20220707191745.840590-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] netfilter: xt_TPROXY: fix clang -Wformat warnings:
From:   Justin Stitt <justinstitt@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When building with Clang we encounter these warnings:
| net/netfilter/xt_TPROXY.c:173:5: error: format specifies type 'unsigned
| char' but the argument has type 'int' [-Werror,-Wformat] tproto,
| &iph->saddr, ntohs(hp->source),
-
| net/netfilter/xt_TPROXY.c:181:4: error: format specifies type 'unsigned
| char' but the argument has type 'int' [-Werror,-Wformat] tproto,
| &iph->saddr, ntohs(hp->source),

The format specifier `%hhu` refers to a u8 while tproto is an int. In
this case we weren't losing any data because ipv6_find_hdr returns an
int but its return value (nexthdr) is a u8. This u8 gets widened to an
int when returned from ipv6_find_hdr and assigned to tproto. The
previous format specifier is functionally fine but still produces a
warning due to a type mismatch.

The fix is simply to listen to Clang and change `%hhu` to `%d` for both
instances of the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
It should be noted that for this entire file to build without -Wformat
warnings you should apply this `ntohs` patch which fixed many, many
-Wformat warnings in the kernel.
https://lore.kernel.org/all/20220608223539.470472-1-justinstitt@google.com/

 net/netfilter/xt_TPROXY.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_TPROXY.c b/net/netfilter/xt_TPROXY.c
index 459d0696c91a..5d74abffc94f 100644
--- a/net/netfilter/xt_TPROXY.c
+++ b/net/netfilter/xt_TPROXY.c
@@ -169,7 +169,7 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 		   targets on the same rule yet */
 		skb->mark = (skb->mark & ~tgi->mark_mask) ^ tgi->mark_value;
 
-		pr_debug("redirecting: proto %hhu %pI6:%hu -> %pI6:%hu, mark: %x\n",
+		pr_debug("redirecting: proto %d %pI6:%hu -> %pI6:%hu, mark: %x\n",
 			 tproto, &iph->saddr, ntohs(hp->source),
 			 laddr, ntohs(lport), skb->mark);
 
@@ -177,7 +177,7 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 		return NF_ACCEPT;
 	}
 
-	pr_debug("no socket, dropping: proto %hhu %pI6:%hu -> %pI6:%hu, mark: %x\n",
+	pr_debug("no socket, dropping: proto %d %pI6:%hu -> %pI6:%hu, mark: %x\n",
 		 tproto, &iph->saddr, ntohs(hp->source),
 		 &iph->daddr, ntohs(hp->dest), skb->mark);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

