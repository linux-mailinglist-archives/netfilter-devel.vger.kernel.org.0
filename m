Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BDE59CEAE
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Aug 2022 04:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbiHWCi1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Aug 2022 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiHWCiZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:38:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4165D5
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Aug 2022 19:38:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334f49979a0so220246147b3.10
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Aug 2022 19:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=qL+JXObshzTRrCwLbMF3qXqnBi/SJhbbagLX2SsRPgs=;
        b=j0YU8vGJDxVBrUMxfAYIf25AIzvvU+FCnsYcmSD0WCMWp5t+OQfIh/8If+ZjRCMBW2
         BU1tZI/8o15ioUCJGgdOUnEVFr5QS7U8kPsY8l4P5OigBkl6/BeIhtR4U3Dch4Tex0QK
         +RSkDaLb7kCQpDr6nIqc7smprtxKsgNiI1mkN4ps6Cu0i1PtgYjXqxxzxTHiOe1GzxsN
         Se0p5olgqGHq3UH92KMTeD0Ft2VneHSDkmW7lO4ME92FrXPsAAnxyaOIWNftLjDIaSyo
         lJ5FW+p9nGuh6woaasc2PNHEqPOTcnKfI8EanSpLLG6XJIKWx9wQwY25x1I8zpLcsDhF
         TegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=qL+JXObshzTRrCwLbMF3qXqnBi/SJhbbagLX2SsRPgs=;
        b=crE1LNJAuIiYP0xwNLIvP7uApj/5F61jV+OF+BoMM2NsdaN4Qv8zM2JJ/Lrp3KMcnO
         4VzM9uw/5+AAxORZHZvipN2kwZO5Z/E74dudCTOZHwxjJjNl2OagzTJ2u794gZ5eJIB8
         TweWWKOdt829DDYpxXIBr1eHhtUU1He1ABOguzWYgpQW7eRf+nfW99jDdeeOE8Uj6E5T
         opbKJUf76vJ9j6nBO0jFgdFsUYlwJDYu5YMlOVCEk7SqFcUuGBGUaB6xGr6gLbsUfpNa
         vUReR9M3672bvHYycIMDc7BIoIHIsK/SwPzYBCK0QQa9/02sHZfa/Y316uddAxUHJ4jF
         +L0A==
X-Gm-Message-State: ACgBeo2QuQAiTW7I8Y/TwYTgIZrQMH7Ty2djttoBEaTJMAk0S0xTQdZE
        UFB36AJAIfAJLyYBfhBgaTe6MEYrKEIIrVGjCGCi6GK3XLOnVFYZ+FEmw1N44oMytE2ofpdaFAv
        Btqy630T39CQaxFdtByNETLB45YRBuZRWQvPQXjlE5LWULLhGR89FtjBwdRtZPYGR0kn4TAiJeA
        lubAv6lQ==
X-Google-Smtp-Source: AA6agR43lmUcKmoqA+VhYqH30XyQuP3kBbwtgBtI27O620TGQeWFlX6AdSpyHIobK73N/iB7y9g17zKZu1nnWJs=
X-Received: from dolcetriade.mtv.corp.google.com ([2620:15c:124:202:b48:f6bb:50aa:3579])
 (user=harshmodi job=sendgmr) by 2002:a0d:f9c1:0:b0:33b:65f4:9506 with SMTP id
 j184-20020a0df9c1000000b0033b65f49506mr9238061ywf.227.1661222302774; Mon, 22
 Aug 2022 19:38:22 -0700 (PDT)
Date:   Mon, 22 Aug 2022 19:38:14 -0700
Message-Id: <20220823023814.1666916-1-harshmodi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] br_netfilter: Drop dst references before setting.
From:   Harsh Modi <harshmodi@google.com>
To:     netfilter-devel@vger.kernel.org
Cc:     harshmodi@google.com, sdf@google.com, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It is possible that there is already a dst allocated. If it is not
released, it will be leaked. This is similar to what is done in
bpf_set_tunnel_key().

Signed-off-by: Harsh Modi <harshmodi@google.com>
---
 net/bridge/br_netfilter_hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index ff4779036649..f20f4373ff40 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -384,6 +384,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 				/* - Bridged-and-DNAT'ed traffic doesn't
 				 *   require ip_forwarding. */
 				if (rt->dst.dev == dev) {
+					skb_dst_drop(skb);
 					skb_dst_set(skb, &rt->dst);
 					goto bridged_dnat;
 				}
@@ -413,6 +414,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			kfree_skb(skb);
 			return 0;
 		}
+		skb_dst_drop(skb);
 		skb_dst_set_noref(skb, &rt->dst);
 	}
 
-- 
2.37.1.595.g718a3a8f04-goog

