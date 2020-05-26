Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16761C77FC
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgEFReD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 May 2020 13:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFReD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 May 2020 13:34:03 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3724C061A0F
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 10:34:02 -0700 (PDT)
Received: from localhost ([::1]:58714 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jWNvl-0002kD-OM; Wed, 06 May 2020 19:34:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 02/15] nft: Add missing clear_cs() calls
Date:   Wed,  6 May 2020 19:33:18 +0200
Message-Id: <20200506173331.9347-3-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200506173331.9347-1-phil@nwl.cc>
References: <20200506173331.9347-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Previous patch "nft: split parsing from netlink commands" added a second
struct iptables_command_state to rule_find functions but missed to add a
related clear_cs() call also.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-arp.c    | 1 +
 iptables/nft-bridge.c | 1 +
 iptables/nft-shared.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/iptables/nft-arp.c b/iptables/nft-arp.c
index 748784bc49048..e9a2d9de21560 100644
--- a/iptables/nft-arp.c
+++ b/iptables/nft-arp.c
@@ -656,6 +656,7 @@ static bool nft_arp_rule_find(struct nft_handle *h, struct nftnl_rule *r,
 	ret = true;
 out:
 	h->ops->clear_cs(&this);
+	h->ops->clear_cs(cs);
 	return ret;
 }
 
diff --git a/iptables/nft-bridge.c b/iptables/nft-bridge.c
index 80d7f91710c16..39a2f704000c7 100644
--- a/iptables/nft-bridge.c
+++ b/iptables/nft-bridge.c
@@ -789,6 +789,7 @@ static bool nft_bridge_rule_find(struct nft_handle *h, struct nftnl_rule *r,
 	ret = true;
 out:
 	h->ops->clear_cs(&this);
+	h->ops->clear_cs(cs);
 	return ret;
 }
 
diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 6b425f8525d3a..bfc7bc2203239 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -1024,6 +1024,7 @@ bool nft_ipv46_rule_find(struct nft_handle *h, struct nftnl_rule *r,
 	ret = true;
 out:
 	h->ops->clear_cs(&this);
+	h->ops->clear_cs(cs);
 	return ret;
 }
 
-- 
2.25.1

