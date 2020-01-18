Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D31416FC
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 11:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgARK3N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 05:29:13 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49496 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbgARK3N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 05:29:13 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1islLr-0005gF-D9; Sat, 18 Jan 2020 11:29:11 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel@vger.kernel.org
Cc:     syzkaller-bugs@googlegroups.com, Florian Westphal <fw@strlen.de>,
        syzbot+cf23983d697c26c34f60@syzkaller.appspotmail.com
Subject: [PATCH nf] netfilter: nft_osf: add missing check for DREG attribute
Date:   Sat, 18 Jan 2020 11:27:25 +0100
Message-Id: <20200118102725.30600-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <000000000000d740e5059c65cbd0@google.com>
References: <000000000000d740e5059c65cbd0@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot reports just another NULL deref crash because of missing test
for presence of the attribute.

Reported-by: syzbot+cf23983d697c26c34f60@syzkaller.appspotmail.com
Fixes:  b96af92d6eaf9fadd ("netfilter: nf_tables: implement Passive OS fingerprint module in nft_osf")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_osf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index f54d6ae15bb1..b42247aa48a9 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -61,6 +61,9 @@ static int nft_osf_init(const struct nft_ctx *ctx,
 	int err;
 	u8 ttl;
 
+	if (!tb[NFTA_OSF_DREG])
+		return -EINVAL;
+
 	if (tb[NFTA_OSF_TTL]) {
 		ttl = nla_get_u8(tb[NFTA_OSF_TTL]);
 		if (ttl > 2)
-- 
2.24.1

