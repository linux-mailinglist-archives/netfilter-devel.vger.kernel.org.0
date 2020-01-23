Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C9146294
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jan 2020 08:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgAWHZv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jan 2020 02:25:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:36720 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgAWHZv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:25:51 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuWs8-0005xN-DM; Thu, 23 Jan 2020 10:25:48 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 4/4] xt_mttg_seq_next should increase position index
To:     coreteam@netfilter.org, netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Message-ID: <68a9cf0e-36b7-59b1-649d-41892d11e72b@virtuozzo.com>
Date:   Thu, 23 Jan 2020 10:25:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 net/netfilter/x_tables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index ce70c25..44f971f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1551,6 +1551,9 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
+	if (ppos != NULL)
+		++(*ppos);
+
 	switch (trav->class) {
 	case MTTG_TRAV_INIT:
 		trav->class = MTTG_TRAV_NFP_UNSPEC;
@@ -1576,9 +1579,6 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 	default:
 		return NULL;
 	}
-
-	if (ppos != NULL)
-		++*ppos;
 	return trav;
 }
 
-- 
1.8.3.1

