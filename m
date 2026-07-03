Return-Path: <netfilter-devel+bounces-13609-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWIgAABoR2pMXwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13609-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 09:42:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF456FFAB9
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 09:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mUJpgFjN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13609-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13609-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C13A3302A6B0
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5186D33F5BC;
	Fri,  3 Jul 2026 07:33:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E25344D90
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jul 2026 07:33:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063985; cv=none; b=Oe2w4u9j0dE9dFye2Fv6N8oL84ZXLinVHG/wgiSRAsHzkto7iU06dihPkKY/ozapECCcNlaKAxfbBpmtoJhnFjUdQg+pCnCpwU7IyT2SWS9QH8i+OxWr+jYsmKoueeEERwDRROfmzYEqxiMjqd6hCiq8EMTdqJ7culP9qkMd82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063985; c=relaxed/simple;
	bh=Sx+IcY4NSaTHqzsAA3izi4Js6ihvEMPG6yrd+tijhS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJfTzS/XMFXyoXJUxC0e2FJM71gbe/1UwZL3gty9O6JA44zZlQuAFMFgK4+OqM2AnUR3Tn6t/1LD540HK5z2t5kXMJLX/5zT1tluYP6aPwZ0seEZwfZwhML1AlxJaKBXgWItqZxlAZFJUMjCNP4EcnYQRvWgkspfJ4efYlIMDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUJpgFjN; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3811f512167so245500a91.3
        for <netfilter-devel@vger.kernel.org>; Fri, 03 Jul 2026 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783063983; x=1783668783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCfgwitqAsh8PcFp5+fftLp0gQAskFW0ykw/YjYFaBk=;
        b=mUJpgFjNuxqSEs6aQKSwAHtC2n0QfBaF2PYHFPguXvv/ZfzlQDtW6/KNGVWmj6JDuv
         b/pY1OKnfPrzCVXZ9fl6WMBlogGsfGVBHT2imYrBdvC0pxvXDyQrle07yUT8T42DDB5z
         Z2woP1fgD96mucHcyXyGLV8vp1bazic9sZvrW/NB4lXe6M0MBnT9XnUh0cXdd7saVGS+
         +FuuZVs9+AZLU9fskURm/OXsRj6ZBS/aIxIGm/DNde16mFrrme69j33H6CziSckA7z7v
         5+lO1I/SKXOXU6e7Qzx4pIWVN/7sxZ8HZo0G9gUKmD0eLzMWFuIH4lHDfZODdH+Gt0lc
         crvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783063983; x=1783668783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCfgwitqAsh8PcFp5+fftLp0gQAskFW0ykw/YjYFaBk=;
        b=nnaZtw9Aq9jo+inZdmP1m87eOM5JSKYezRMIFiS9Cbdpa7hcGs4rYRN1L0WioP18ix
         2ih0zkCQEXfQjQGX++fc3cjSYN2DEt2RawapeoaunuJESEv8eR2c4+7k/D0iGlER8XrX
         AH3N5aGcdbzrWlTPiWSGV67Zk0RjjgkGPbdj2EoesyWg3jeqOxyEaCJc8JfzhFjzayX2
         pCenXaO3r8+XJzyX8dhTz5opAh/NufIXRNcg2UxxpQsH8HsDtjiuVX+NCpZU/9ZpTjDH
         sv5hWBKdtMllshXNyro4SaCdDZ0RLLI2i3fX6BfDMxKTe4PeTrY170F/F2f57OECOHwG
         V3Yw==
X-Gm-Message-State: AOJu0Yz811FvS4fuJVUVabbTKphZeor/ZY5ljWymtUfnOFHIsTv79nF8
	IfhNKz4t5JM//NCvft3db/np+vk3KQJlggyCvP18eSWDDPq2LjdgcMN8HN1KEyyU
X-Gm-Gg: AfdE7cmzg9IFcfSw2OyFfrBCATXsm4wtLS320ZtIRcM+JjxQl84ZOkF5Sx4QHchyPTL
	Kc2xEGHl4jNASpz30vC84XOvAlgJYh5jPNLWchQAh8oNHCqapfEMD0lKXwbdqR/yPJYzkAeWF/H
	5a49gFFz4LV/SneiMN0G7fOjapNLSTQt4soVLcT1WXS2Mt6pzNIcSPPMjY/mqHz85f/Ni/+ZpqB
	hWwo/pn4RnUSTDSfU2BSKLyOwkJ/1VBUh47cjbakkRa1rd2+WWHTSQijMBv3gNu7Djw3ileC8Pd
	bQBAH3MMhYZSL8BQFvgcomiAyylZcRzEW9iaWD6QG24xtdPcy4vBdCAG304ujZzBJcNfjxiWnvp
	y+OeimyQ4FLqH5mAV/HFMi0h/NcSKI0v3ijnbtnHo2zvXIJL8ArQXqY2EC2EKKKE9QBC29/lR8Z
	slNylRJLn9f19os4NpUUb2JMEEgpKL
X-Received: by 2002:a17:90b:2c87:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-380aa0e0512mr9438351a91.14.1783063983008;
        Fri, 03 Jul 2026 00:33:03 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c3134fsm540474a91.5.2026.07.03.00.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:33:02 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	yuantan098@gmail.com,
	dstsmallbird@foxmail.com,
	chzhengyang2023@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH nf 1/1] netfilter: xt_time: reject pre-epoch calendar matching
Date: Fri,  3 Jul 2026 15:32:43 +0800
Message-ID: <779d223ad31c493cbfc3c483293e435dca89cf90.1782879547.git.chzhengyang2023@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782879547.git.chzhengyang2023@lzu.edu.cn>
References: <cover.1782879547.git.chzhengyang2023@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:chzhengyang2023@lzu.edu.cn,m:enjou1224z@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13609-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER(0.00)[enjou1224z@gmail.com,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foxmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enjou1224z@gmail.com,netfilter-devel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:mid,lzu.edu.cn:email,foxmail.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DF456FFAB9

From: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>

When XT_TIME_CONTIGUOUS handles a cross-day daytime range, packets in
the post-midnight part of the range are matched against the previous
calendar day by subtracting SECONDS_PER_DAY from stamp.

On the first day after the epoch, this backdating can make the signed
time64_t stamp negative. localtime_2() and localtime_3() then feed the
value into unsigned division helpers and derive wrapped calendar fields.
In particular, monthday can become larger than the valid 1..31 range,
leading time_mt() to evaluate an out-of-range
1U << current_time.monthday shift.

The date_start/date_stop ABI is unsigned and cannot represent pre-epoch
calendar dates. If contiguous matching backdates stamp before the epoch,
only rules without weekday and monthday constraints can still be
evaluated safely; reject calendar-constrained rules before converting
the timestamp to calendar fields.

Fixes: 54eb3df3a7d0 ("netfilter: xt_time: add support to ignore day transition")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/netfilter/xt_time.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netfilter/xt_time.c b/net/netfilter/xt_time.c
index 2065fce8ef81..014561a2ef3f 100644
--- a/net/netfilter/xt_time.c
+++ b/net/netfilter/xt_time.c
@@ -220,6 +220,15 @@ time_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			stamp -= SECONDS_PER_DAY;
 	}
 
+	/*
+	 * The date_start/date_stop ABI cannot express pre-epoch timestamps.
+	 * If XT_TIME_CONTIGUOUS moves the packet into that range, only rules
+	 * without calendar constraints can still match.
+	 */
+	if (stamp < 0)
+		return info->weekdays_match == XT_TIME_ALL_WEEKDAYS &&
+		       info->monthdays_match == XT_TIME_ALL_MONTHDAYS;
+
 	localtime_2(&current_time, stamp);
 
 	if (!(info->weekdays_match & (1U << current_time.weekday)))
-- 
2.43.0

