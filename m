Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C67526C
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbfGYPTZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 11:19:25 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:53762 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388736AbfGYPTZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:19:25 -0400
Received: from localhost ([::1]:38620 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hqfWd-0004TQ-A3; Thu, 25 Jul 2019 17:19:23 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/2] nft: Set errno in nft_rule_flush()
Date:   Thu, 25 Jul 2019 17:19:13 +0200
Message-Id: <20190725151914.28723-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When trying to flush a non-existent chain, errno gets set in
nft_xtables_config_load(). That is an unintended side-effect and when
support for xtables.conf is later removed, iptables-nft will emit the
generic "Incompatible with this kernel." error message instead of "No
chain/target/match by that name." as it should.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index cd42af70b54ef..9f8df5414d4c4 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1804,8 +1804,10 @@ int nft_rule_flush(struct nft_handle *h, const char *chain, const char *table,
 
 	if (chain) {
 		c = nftnl_chain_list_lookup_byname(list, chain);
-		if (!c)
+		if (!c) {
+			errno = ENOENT;
 			return 0;
+		}
 
 		__nft_rule_flush(h, table, chain, verbose, false);
 		flush_rule_cache(c);
-- 
2.22.0

