Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE56B16BA3B
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Feb 2020 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgBYHGE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Feb 2020 02:06:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:40214 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYHGC (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:06:02 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j6UI3-0004rd-Sp; Tue, 25 Feb 2020 10:05:59 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 2/4] synproxy_cpu_seq_next should increase position index
To:     coreteam@netfilter.org, netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
References: <497a82c1-7b6a-adf4-a4ce-df46fe436aae@virtuozzo.com>
Message-ID: <63a27a1f-0234-2dfb-2773-906d0f5f6f8b@virtuozzo.com>
Date:   Tue, 25 Feb 2020 10:05:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <497a82c1-7b6a-adf4-a4ce-df46fe436aae@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If .next function does not change position index,
following .show function will repeat output related
to current position index.

Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 net/netfilter/nf_synproxy_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index b0930d4a..b9cbe1e 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -267,7 +267,7 @@ static void *synproxy_cpu_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		*pos = cpu + 1;
 		return per_cpu_ptr(snet->stats, cpu);
 	}
-
+	(*pos)++;
 	return NULL;
 }
 
-- 
1.8.3.1

