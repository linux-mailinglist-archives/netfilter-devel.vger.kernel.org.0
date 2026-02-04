Return-Path: <netfilter-devel+bounces-10614-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHXmH0pwg2lgmwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10614-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:14:02 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F86EA060
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FF2B31FDBA1
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5141B379;
	Wed,  4 Feb 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQTmFKdi"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9141B34B
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Feb 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219531; cv=none; b=Vx85/s0VSx0bJ+kcP9zkyth8EPOxFuEGYOr/TCFUBZWABaKLne4KLNK/gPw7mLQY+vsJBS09XHU6x3WI0sNdCxCzkfJjq6fvwLd5SnjAqG4fGxWzksJkaOwKdJ0gdrJhMPMfxCNlhEumeZBClaawy64BzlkPbjQsQWRWaNuEeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219531; c=relaxed/simple;
	bh=VvZrFUse2WKkW09+aZ0530UxKnUHy2lCsYRmqdrLs4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOFtZhy1+M7Y/+cQlHpcO02HTC6Y3XfMSSRpV3oFjdc9RWkjE8JSS0UePIyIhBcYo+LYLklhz0rlyJkqy6ccA8dXEHN+FBCbnuPHkxVxS/Z52YjItDDdIT58NuTUOudivBx2bdWD4cy9f2w0EwARzxblZr3/g5rPhuC+pOEpv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQTmFKdi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-790992528f6so65445767b3.1
        for <netfilter-devel@vger.kernel.org>; Wed, 04 Feb 2026 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770219531; x=1770824331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKy1kRyVzTZS/2OsQ960jMKveDH4L95qBQ+tdJbKvvs=;
        b=GQTmFKdiFKbbY2wNw43o+jvgiscveU0fTMRg4aT9aXgNrnW8+rHANX6rUXKSZHOU36
         yPcCbnbxJf96YjH89WtK+IAhzXVpIZk4wRiXSyBpD/wIgqW+YWQzPUqV+6cVhvyqMEK4
         LJxui+t4Pz1hCk+VE9yCKjVRtbv5hBCMXXB6CjIfTE7eOLSGGRWVGI6mr5nyJKBHNXMM
         S+VO7aQnYI2a1jtpZmSew7qp07+FFp1JWb2Gke/JTCplBWxIzdH3PaaRGgq6xTG1lfXS
         ZtRMl6CEGFMh0yKRrLzTLJXxy7eb1gqpfHm/q8IxJf7YG5oLWKUiwFZh/PsErtJNVWyo
         xv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770219531; x=1770824331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKy1kRyVzTZS/2OsQ960jMKveDH4L95qBQ+tdJbKvvs=;
        b=Tl72Jgf4EULDD4SDBgdi0tXC1Qe3GjCa1ewSjg72zXSGjhohgaQjUuliO7fAtob+40
         GR/L0Ur+s1CmnmZQzH2v5FGfiLOvgsI/8xA1tyhvkwsW8EBJ/7i7jpwqPOFRI/hu3h9S
         l8mDTHvY+KoPAGWIIhoQiUre81OZHTahk7DrpFfSj1gQ6Ubd/fqqaL4i2FuTmtLzMMRn
         PHbXY+A+guqvXod8nePUL3/Qun4N9f1UB6moWW/BkQ7WF7lNYUxv2ShDmfd5R+xDio9L
         AAh9xPa4pGBv43LKYL2VILc8wnDbkzUIsZIKDqTMRHw0fnoV+72SPo02JhnDhhieoBEs
         GTDA==
X-Forwarded-Encrypted: i=1; AJvYcCULmF4976T/sPvPy/aCfD1vrXvxRNLtWZlwBYFWTO1k6eUI8AGiM+o6yFT4CeU2pCo5/FYj3PxEKIDphzLplE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5bklj+YwteHVvqsz6gO8TeA3f5LGkXwS2SnB+KqetE9u4973
	ZLDPPghX7295h/xKW5bbdOcLBoRNQBXl+qeCsAYKpS2uYvPZhCG0Zfl9
X-Gm-Gg: AZuq6aIUtMO7zAIaD9sfFlFAmO0EhRLJWPAveNjPekZm3EFXofQ/OA6Dhwcb7I5cNFU
	Ovg5E8k/qB/aQkxstglP8x0siMHzC9keb/o5XFrZj3nAQHFt57P3sUprOvU8ioajv6W0mZhO5Fa
	K3Ehr5iclOe8sT0KbbfwgJnmeYkLFZicaEl4s/BKH5WgI9zx2/mWChZS1KXUnLYvFClmSgKj4c2
	gWtiFiIoAOXMJHJqp24VIE4aZBn6j5x8a5F5xbrquIzRuHxU8P/zjpl46WjNjP+0HL0cR00V4nH
	2G7vTqcBMU/qPNONI5AtBVcxU5mdZMxA3e/sRgWvNCbKbr0wkwyFgqn0lhe4lwFmbGtscQm8cQ+
	CU03lZ4yO91lOcQgU/iHkzk1fqlYdFNhfzYoUCJPSkm7y4DpRcyzX5fX02OPMUNSA5NXs/zJfWD
	L6wPyyMPqt7h87vY7Ftcs4Oy2deZyAioLtr4lZ3AoEDk/xAqO1CufHe76qwsrzjcN29nnCPt17+
	aMCj/ldkw==
X-Received: by 2002:a05:690c:1e:b0:794:5ac:a9e1 with SMTP id 00721157ae682-794fe87d8e0mr32891587b3.65.1770219530827;
        Wed, 04 Feb 2026 07:38:50 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefedd4bsm23609397b3.48.2026.02.04.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:38:50 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v4 4/5] netfilter: snmp: annotate nf_nat_snmp_hook with __rcu
Date: Wed,  4 Feb 2026 23:38:11 +0800
Message-ID: <20260204153812.739799-5-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204153812.739799-1-sun.jian.kdev@gmail.com>
References: <aYM6Wr7D4-7VvbX6@strlen.de>
 <20260204153812.739799-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10614-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29F86EA060
X-Rspamd-Action: no action

The nf_nat_snmp_hook is an RCU-protected pointer but lacks the
proper __rcu annotation. Add the annotation to ensure the declaration
correctly reflects its usage via rcu_dereference().

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 include/linux/netfilter/nf_conntrack_snmp.h | 2 +-
 net/netfilter/nf_conntrack_snmp.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_snmp.h b/include/linux/netfilter/nf_conntrack_snmp.h
index 87e4f33eb55f..99107e4f5234 100644
--- a/include/linux/netfilter/nf_conntrack_snmp.h
+++ b/include/linux/netfilter/nf_conntrack_snmp.h
@@ -5,7 +5,7 @@
 #include <linux/netfilter.h>
 #include <linux/skbuff.h>
 
-extern int (*nf_nat_snmp_hook)(struct sk_buff *skb,
+extern int (__rcu *nf_nat_snmp_hook)(struct sk_buff *skb,
 				unsigned int protoff,
 				struct nf_conn *ct,
 				enum ip_conntrack_info ctinfo);
diff --git a/net/netfilter/nf_conntrack_snmp.c b/net/netfilter/nf_conntrack_snmp.c
index daacf2023fa5..34f6624fbcfb 100644
--- a/net/netfilter/nf_conntrack_snmp.c
+++ b/net/netfilter/nf_conntrack_snmp.c
@@ -25,7 +25,7 @@ static unsigned int timeout __read_mostly = 30;
 module_param(timeout, uint, 0400);
 MODULE_PARM_DESC(timeout, "timeout for master connection/replies in seconds");
 
-int (*nf_nat_snmp_hook)(struct sk_buff *skb,
+int (__rcu *nf_nat_snmp_hook)(struct sk_buff *skb,
 			unsigned int protoff,
 			struct nf_conn *ct,
 			enum ip_conntrack_info ctinfo);
-- 
2.43.0


