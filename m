Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349175A2017
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Aug 2022 07:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiHZFD5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 26 Aug 2022 01:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZFD4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:03:56 -0400
Received: from babylon.otherwize.co.uk (babylon.otherwize.co.uk [85.119.82.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB7205D1
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Aug 2022 22:03:55 -0700 (PDT)
Received: (qmail 24664 invoked from network); 26 Aug 2022 04:57:13 -0000
From:   David Leadbeater <dgl@dgl.cx>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc:     David Leadbeater <dgl@dgl.cx>
Subject: [PATCH 2/2] netfilter: nf_conntrack_irc: Fix forged IP logic
Date:   Fri, 26 Aug 2022 14:56:58 +1000
Message-Id: <20220826045658.100360-2-dgl@dgl.cx>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826045658.100360-1-dgl@dgl.cx>
References: <20220826045658.100360-1-dgl@dgl.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ensure the match happens in the right direction, previously the
destination used was the server, not the NAT host, as the comment
shows the code intended.

Additionally nf_nat_irc uses port 0 as a signal and there's no valid way
it can appear in a DCC message, so consider port 0 also forged.

Fixes: 869f37d8 ("[NETFILTER]: nf_conntrack/nf_nat: add IRC helper port")
Signed-off-by: David Leadbeater <dgl@dgl.cx>
---
 net/netfilter/nf_conntrack_irc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 3b9d6f8ba436..5703846bea3b 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -216,8 +216,9 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 
 			/* dcc_ip can be the internal OR external (NAT'ed) IP */
 			tuple = &ct->tuplehash[dir].tuple;
-			if (tuple->src.u3.ip != dcc_ip &&
-			    tuple->dst.u3.ip != dcc_ip) {
+			if ((tuple->src.u3.ip != dcc_ip &&
+			     ct->tuplehash[!dir].tuple.dst.u3.ip != dcc_ip) ||
+			    dcc_port == 0) {
 				net_warn_ratelimited("Forged DCC command from %pI4: %pI4:%u\n",
 						     &tuple->src.u3.ip,
 						     &dcc_ip, dcc_port);
-- 
2.37.1

