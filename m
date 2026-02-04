Return-Path: <netfilter-devel+bounces-10613-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECaoJuRvg2lgmwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10613-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:12:20 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B9E9FE2
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55ABD304C487
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9441C307;
	Wed,  4 Feb 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGpdg9RO"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0041C303
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Feb 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219525; cv=none; b=EpbPHqiY22FGxIL6abfQF5HnFY3dDnLuiRar9yjVYMkkLBYc5HHG3QUK6lcMrbq/amiEaAKDgKQX+kE4Ao3JDBnYJlRho2q/fgg2YvgsehtAssCJUnpOgKBnFNMqiaihr0NUydrxCrDeCbMrLfqlcb4HNbAp9iWv96T4SX3UKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219525; c=relaxed/simple;
	bh=NBuh1dvBgiNH87qE3r1Qm60QPkpoCG2hUsKeZNts0C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts20Qm0f+RU43+r6YGiPQudFncQsjpfw6Rwlz1wz7hIFJ9omkOknh/fihsKzcB/iFu4mP/jjq8LjSO4Z+Vz3RsGYP622XqNu9TP766VGUKGR1alo4Xy9XqCf3LD4/Vp2L3X2ClWXKEpZqjdUqGo3HlSUVU6TD1bFgEmGvYAvoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGpdg9RO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7947cf097c1so60174537b3.2
        for <netfilter-devel@vger.kernel.org>; Wed, 04 Feb 2026 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770219524; x=1770824324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPqJuHpEvwCCDtvNN9VeUm4XD5r0IJyrLWkforP5Mn0=;
        b=KGpdg9ROD1eugZfGRs9vr2gMLYPZ/eozApqJficeLADgIHBpYro2bOBw2/UGoBU8sm
         DIciYm+liuz8vz9iYT84iDz7/Isz5dlc4CpuxSyn6U7kJtuutQAy6ER4pL5rTCN5tGhx
         bSw9HBy/70NNpjbU8zsjq0dRL6bgc4T9Vd9gJA0pwz6SkUg/HuaqRW1qWKoUJU1ddJKJ
         qIg3lfgjoWmBeBgRTqnIn5XjCj27TraXqsKgmwDH9zSzeK8UfT/RqVDQFbYTP+UTI1jp
         bStsOcB6jzFjskqlgfHwfbtSOKJRQQKys5E4ZN7FdJcjZMKk1nBrAF5sFfPA4t0bgwjX
         3bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770219524; x=1770824324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPqJuHpEvwCCDtvNN9VeUm4XD5r0IJyrLWkforP5Mn0=;
        b=GUf6ZW17eddEV0D9fyhD/EK5k+NxENR9oqDpJe4YVsY6K/si4dBINj3H6AsPU9ms8k
         MMLqJp/u3BXJZbWvS4hYKrK7SthXsyDl04BezFrKmKddp2T/QxVqKisjO0QFT2W093Vz
         ZibcumdsQZw9WH4RI06b9bCQljveF4xehdTCEmBXGKQC23FS87oRyGbacpYZkhAVZZ2g
         ZWYHjWHlX9OYw5gO6CPAqV0FferDSYe2tmMKLSTFVmt4gsz8ypQdRLLq5AkPB8S5GtCE
         O9AKd4l1BptZfgJDrAWGN37DBg6qCUL1NEaTwE2SuaDcETtmByN5ZOaZlgD5gBTaRk2m
         SykQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOdgwRqfxwm0etsPUkAdJNZnUp2lGOij4rsqKteUstkUjenpfZRTfwFGf3Vga1dLlbVa6KJUw5/PBr1H+CyjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSDIYe7b7XxkZsAgJOo6y32dgr81hWXXOZa60ytXjYO7BO6Af
	vHf0ycNMRoWHoMhnNQ1/QjBIX5fBdbdb82V960bJgZY4MtV7KKh3QwaZkdi1BOczxWQ=
X-Gm-Gg: AZuq6aLx6kB90GKxwJUQ3w0LV0Ca0hV7w5/dO8SsrXU12uw+Padb76oj5L0ze1PMp1w
	/ly0wciuHiQvYsp2VRDQ2FAVgzMYRb82VyT5g/pQFfWQMxfEwF+lIGNi9ruPy6mTDEAdHLPkjkT
	6lskslmqzToHsPBLgDJu/fBYADXh7fOVvDBaUpVV5HdBbn00ZQnPkC/DiM+NDIzSj3wp3DUVram
	ky4mk/yU3VHAAATOPPfbIttpbBd5Tcq2QrZIwVDltFVyG48bLngB70HcNDYe9D4n/iI5RJKXVd/
	PpBgmn/8s5hbcMsuxG2EwLJw3xCrBqBvC/JPBQelTkmfVsj389knqC+cf0WaDPqJB7xnDp4aDaA
	Ncn1lMoIpX01H2zCx3mTUgbBh60PzoVSFv5sG5eqMe1O2voDu0+nu5HIAIpsmtcM8d6Ru9pAAXN
	p2ZWzf2fbJuIFfRaH1seeTQKDbrOxYpTbRcbu01GjIBPkZ7ut2hBtGrCQVvyO9lDhXRRtd08EhB
	hvFxpj6FQY9qFa2CefE
X-Received: by 2002:a05:690c:97:b0:794:8055:7f68 with SMTP id 00721157ae682-794fe696cc8mr35059667b3.26.1770219523651;
        Wed, 04 Feb 2026 07:38:43 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefedd4bsm23609397b3.48.2026.02.04.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:38:43 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v4 3/5] netfilter: irc: annotate nf_nat_irc_hook with __rcu
Date: Wed,  4 Feb 2026 23:38:10 +0800
Message-ID: <20260204153812.739799-4-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10613-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 0C6B9E9FE2
X-Rspamd-Action: no action

The nf_nat_irc_hook is an RCU-protected pointer but lacks the
proper __rcu annotation. Add the annotation to ensure the declaration
correctly reflects its usage via rcu_dereference().

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 include/linux/netfilter/nf_conntrack_irc.h | 2 +-
 net/netfilter/nf_conntrack_irc.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_irc.h b/include/linux/netfilter/nf_conntrack_irc.h
index d02255f721e1..4f3ca5621998 100644
--- a/include/linux/netfilter/nf_conntrack_irc.h
+++ b/include/linux/netfilter/nf_conntrack_irc.h
@@ -8,7 +8,7 @@
 
 #define IRC_PORT	6667
 
-extern unsigned int (*nf_nat_irc_hook)(struct sk_buff *skb,
+extern unsigned int (__rcu *nf_nat_irc_hook)(struct sk_buff *skb,
 				       enum ip_conntrack_info ctinfo,
 				       unsigned int protoff,
 				       unsigned int matchoff,
diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 5703846bea3b..76c007530b3c 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -30,7 +30,7 @@ static unsigned int dcc_timeout __read_mostly = 300;
 static char *irc_buffer;
 static DEFINE_SPINLOCK(irc_buffer_lock);
 
-unsigned int (*nf_nat_irc_hook)(struct sk_buff *skb,
+unsigned int (__rcu *nf_nat_irc_hook)(struct sk_buff *skb,
 				enum ip_conntrack_info ctinfo,
 				unsigned int protoff,
 				unsigned int matchoff,
-- 
2.43.0


