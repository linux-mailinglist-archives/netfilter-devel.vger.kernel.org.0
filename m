Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585B810EA1E
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLBMe7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 07:34:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLBMe7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:34:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so21586605wmj.4
        for <netfilter-devel@vger.kernel.org>; Mon, 02 Dec 2019 04:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tanaza-com.20150623.gappssmtp.com; s=20150623;
        h=user-agent:from:to:cc:subject:date:message-id:mime-version;
        bh=si4Qt/WqY+cuoLWiKhaIj+u/k3AZYYwbUnJI7p4ynE8=;
        b=h//gGqry2mEd1I2IzUX4xqvElIANo6yfvbrfVkZ+o3t5nCk+YcsaniWTXAmzCXDDox
         0xJVw4OlxGye+W/YMlUEKOop/d25P8mOHHvjU4/e1JivaroqDWwfVZU+Dv5S1QkliPSF
         xZAOE10HP8SgX4AJo7zMEkTfg1QS9ZexuPItvsGlDZr7ESD/RipsxYBwQydlYaXz98cp
         2KjQdGzHZv9WNhBdXYR6ATVXBqLuItVewkS46f0EmZC+1svzX9530l2o+dqADL7EgO2x
         TBip8t+q1UvC8z1dhr0y+q6tDrQ8caFhEV/xibW1BwY4kWHTgr0Y25MtWoRkZ+ZxA8FN
         C1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
         :mime-version;
        bh=si4Qt/WqY+cuoLWiKhaIj+u/k3AZYYwbUnJI7p4ynE8=;
        b=KMHY9otIDiAwBkjEP4feoqcDaNqhATceiP//h+jcgR6dT7hd/SDjEzEb5Aw8aUSsFD
         clES82DBdgTQCU4atow6vDiHQ/ktHfOD4Yt1/MiNCoZ63fyWBhN5KNg0WN+GctAJcXc6
         EJWvPPfWyKaTBRnNGTmwLsOibV2X+13rO8EA78obqkDOxmuEhyrYnBI/7nwEcVSntSwg
         2gn2C4Qpv25G8Yq0eo1qIzsUSNEgqL+5D89QzXs1sps6Od419XoXWA/SVVoxLHGli9T7
         A6i+7Y5QsNjxnf4vlwosNPjCzhBjO5UVdKJxHSOmU7+7XBty+N/dDwOp3dVqAE/+JUvt
         dQXw==
X-Gm-Message-State: APjAAAUFLkwxH9WeJYl/s/S2f4yAGrQzx667uZsQSKfeWRo8L1GrbHqf
        SX3QsL3KJJGWmNqrUJohwxxihAOxqmFAcQ==
X-Google-Smtp-Source: APXvYqzHOiRsu2vcc7QO823R5r7yPixuu25GtLEeWyv+t2re3G8D4cT9nrYe6fc+Q3IAs9tale45gQ==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr28329341wma.140.1575290096457;
        Mon, 02 Dec 2019 04:34:56 -0800 (PST)
Received: from sancho ([160.97.163.130])
        by smtp.gmail.com with ESMTPSA id a186sm12601970wmd.41.2019.12.02.04.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 04:34:55 -0800 (PST)
User-agent: mu4e 1.2.0; emacs 26.3
From:   Marco Oliverio <marco.oliverio@tanaza.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Marco Oliverio <marco.oliverio@tanaza.com>,
        Rocco Folino <notifications@github.com>,
        Florian Westphal <fw@strlen.de>,
        netdev <netdev@vger.kernel.org>
Subject: forwarded bridged packets enqueuing is broken
Date:   Mon, 02 Dec 2019 13:34:54 +0100
Message-ID: <87pnh6lxch.fsf@tanaza.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


Hi,

We cannot enqueue userspace bridged forwarded packets (neither in the
forward chain nor in the postrouting one):

nft add table bridge t
nft add chain bridge t forward {type filter hook forward priority 0\;}
nft add rule bridge t forward queue

packets from machines other than localhost aren't enqueued at all.

(this is also true for the postrouting chain).

We think the root of the problem is the check introduced by
b60a77386b1d4868f72f6353d35dabe5fbe981f2 (net: make skb_dst_force
return true when dst is refcounted):

modified   net/netfilter/nf_queue.c
@@ -174,6 +174,11 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		goto err;
 	}
 
+	if (!skb_dst_force(skb) && state->hook != NF_INET_PRE_ROUTING) {
+		status = -ENETDOWN;
+		goto err;
+	}
+

AFAIU forwarded bridge packets have a null dst entry in the first
place, as they don't enter the ip stack, so skb_dst_force() returns
false. The very same commit suggested to check skb_dst() before
skb_dst_force(), doing that indeed fix the issue for us:

modified   net/netfilter/nf_queue.c
@@ -174,7 +174,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		goto err;
 	}
 
-	if (!skb_dst_force(skb) && state->hook != NF_INET_PRE_ROUTING) {
+	if (skb_dst(skb) && !skb_dst_force(skb)) {
 		status = -ENETDOWN;
 		goto err;
 	}

This assumes that we shouldn't enqueue the packet if skb_dst_force()
sets not-NULL skb->dst to NULL, but it is safe to do that if skb->dst
was NULL in the first place. It should also cover che PRE_ROUTING hook
case. Is this assumption correct? Are there any side effects we're
missing?

If it is correct and it helps we can send a patch on top of the
netfilter tree.

Greetins
Marco

