Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706C31317E7
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jan 2020 19:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFSzr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jan 2020 13:55:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbgAFSzr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578336946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:in-reply-to:
         references:references:references;
        bh=D0Jq/XsPiURLI1PVAfNfvZIlWS8x7slAAs4CTxeCAgY=;
        b=aXeA533tz5aHDHVfp899gfJnoz5vq2cRZqjZXOiBwNw8YGAZHX2hHKnngwcC6pvTRcjvJE
        wFCgRTVix59U3PFZ+xLUBuLNpYnUiHxnNSsKinNOL6nLZlgIQgTEr65lsFWZCbnltOyAUN
        G0rJqJ4GIYSxB2yUNnUZ/GREvLRHspY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-crFK0jXjMhWrZAGya-Bkcw-1; Mon, 06 Jan 2020 13:55:43 -0500
X-MC-Unique: crFK0jXjMhWrZAGya-Bkcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 288F0108C22F;
        Mon,  6 Jan 2020 18:55:42 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-34.phx2.redhat.com [10.3.112.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42DB25D9D6;
        Mon,  6 Jan 2020 18:55:24 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        eparis@parisplace.org, ebiederm@xmission.com, tgraf@infradead.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak25 v2 5/9] netfilter: x_tables audit only on syscall rule
Date:   Mon,  6 Jan 2020 13:54:06 -0500
Message-Id: <48636daf8850e06a4d33e99a8a9ad534d2f525d8.1577830902.git.rgb@redhat.com>
In-Reply-To: <cover.1577830902.git.rgb@redhat.com>
References: <cover.1577830902.git.rgb@redhat.com>
In-Reply-To: <cover.1577830902.git.rgb@redhat.com>
References: <cover.1577830902.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Call new audit_nf_cfg() to store table parameters for later use with
syscall records.

See: https://github.com/linux-audit/audit-kernel/issues/25
See: https://github.com/linux-audit/audit-kernel/issues/35
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 net/netfilter/x_tables.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 0094853ab42a..c0416ae52f7f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1401,14 +1401,8 @@ struct xt_table_info *xt_replace_table(struct xt_table *table,
 		}
 	}
 
-#ifdef CONFIG_AUDIT
-	if (audit_enabled) {
-		audit_log(audit_context(), GFP_KERNEL,
-			  AUDIT_NETFILTER_CFG,
-			  "table=%s family=%u entries=%u",
-			  table->name, table->af, private->number);
-	}
-#endif
+	if (audit_enabled)
+		audit_nf_cfg(table->name, table->af, private->number);
 
 	return private;
 }
-- 
1.8.3.1

