Return-Path: <netfilter-devel+bounces-13582-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6z9XHuA7RmrsMQsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13582-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 12:22:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C16F5D40
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 12:22:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ne+i796L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B1FeCalO;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f6hBD1pY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4Bt5iqpv;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13582-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13582-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44A09314892B
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCD480326;
	Thu,  2 Jul 2026 10:11:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9D47DD4A
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Jul 2026 10:11:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987072; cv=none; b=Q/EKWj2qeD4ZoSpy99UAigPpzkBxKgJ5G9ksAc9fwBkiOVPEREor72xYG05gm5S0Fk2bNxggwNn96nGhoAG8nFP1UKirPpTEKwomVx5vZjQ+CrcFyvoS73jIKvNxwsmBNVFqyCvVayVETan7Byzb4S0TMiI3kmGPnDAqNhZfEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987072; c=relaxed/simple;
	bh=ikk1fuxsPajwPBSmiBJUt4APtxDWqqLCg+u79Heljkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+7L31bDu58OAS7yibjqV/Sg1UBEFIab4v4nz55RFKA01tBjKkxkR6cvOnbK55kzGp5l2Z6GqRFJvlwLpVPs1Y2mSzNDcfZGjinBzZ/ZjFROMzKhG7CpjWHYl6U7WqVKepOnAl5FgfibQ9qHdd886s2BeYCpEIMsKomG3VQR+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ne+i796L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B1FeCalO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f6hBD1pY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Bt5iqpv; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEABE75AE7;
	Thu,  2 Jul 2026 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782987068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nwBam1Mu5tQiZpwXSkkzPWsysU7mQvcSyfKYuwaMZd8=;
	b=Ne+i796LZxQiRrOGulhlPmiw3LFuySz+/aExN+R5Yakfyk9X1qQzcstlEOtXQQKMg2wF7a
	Ck1VLzdL7SyF8Zl1QPHJhxIQYo6YfoNLjiS1jIXF96F13yjjECX7StKltDo4sN1tCltnhM
	MQi/VMigwn54stRloYOUTFnz8zR0xBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782987068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nwBam1Mu5tQiZpwXSkkzPWsysU7mQvcSyfKYuwaMZd8=;
	b=B1FeCalOc0PYgDrQeoi5JtvQ39tnhqLI3dHAS/N2GtuvlCj0XwlI/eVkDldluzFjcdHaHY
	duXgtMkxno+32GCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782987067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nwBam1Mu5tQiZpwXSkkzPWsysU7mQvcSyfKYuwaMZd8=;
	b=f6hBD1pY+0qf2IPSp614iwiEXww+cGK+6iFAqwPaq5r12xEobVCUpPDoFSdeJ69hVL4biE
	mFlsUu7uuSgFWTf2RHbV4p5XlKWSjL/rC2wfg7cMxlk/G/WGK90Kkw261HliAkoJJ1sYj+
	BtEnNW41Cuc2WtngaTtIdwoMXmyTcvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782987067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nwBam1Mu5tQiZpwXSkkzPWsysU7mQvcSyfKYuwaMZd8=;
	b=4Bt5iqpvWkLSScfEvyNV6xR0a5W3dNuCjzn8ZFq/ybEzFQPMaHW1letMuWTAVHloBpdyzJ
	MDDazEK+wBEsZMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B54779AA;
	Thu,  2 Jul 2026 10:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b6c0LDs5RmpZJwAAD6G6ig
	(envelope-from <iluceno@suse.de>); Thu, 02 Jul 2026 10:11:07 +0000
From: Ismael Luceno <iluceno@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Ismael Luceno <iluceno@suse.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:IPVS),
	lvs-devel@vger.kernel.org (open list:IPVS),
	netfilter-devel@vger.kernel.org (open list:NETFILTER),
	coreteam@netfilter.org (open list:NETFILTER)
Subject: [PATCH v2 nf-next] ipvs: Move defense_work and est_reload_work to system_dfl_long_wq
Date: Thu,  2 Jul 2026 12:10:50 +0200
Message-ID: <20260702101100.24256-2-iluceno@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13582-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:iluceno@suse.de,m:marco.crivellari@suse.com,m:tj@kernel.org,m:horms@verge.net.au,m:ja@ssi.bg,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[iluceno@suse.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iluceno@suse.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA9C16F5D40

Under synflood conditions binding these handlers to system_long_wq may
pin them to a saturated CPU.

We've observed improved throughtput on a DPDK/VPP application with this
change, which we attribute to the reduced context switching.

Neither handler has per-CPU data dependencies nor cache locality
requirements that would prevent this change.

Signed-off-by: Ismael Luceno <iluceno@suse.de>
---
CC: Marco Crivellari <marco.crivellari@suse.com>
CC: Tejun Heo <tj@kernel.org>

Changes since v1:
* Rebased on nf-next
* Reworded commit message

 net/netfilter/ipvs/ip_vs_ctl.c | 6 +++---
 net/netfilter/ipvs/ip_vs_est.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index bcf40b8c41cf..d7e669efab4d 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -235,7 +235,7 @@ #define DEFENSE_TIMER_PERIOD	1*HZ
 	update_defense_level(ipvs);
 	if (atomic_read(&ipvs->dropentry))
 		ip_vs_random_dropentry(ipvs);
-	queue_delayed_work(system_long_wq, &ipvs->defense_work,
+	queue_delayed_work(system_dfl_long_wq, &ipvs->defense_work,
 			   DEFENSE_TIMER_PERIOD);
 }
 #endif
@@ -290,7 +290,7 @@ #define DEFENSE_TIMER_PERIOD	1*HZ
 	atomic_set(&ipvs->est_genid_done, genid);
 
 	if (repeat)
-		queue_delayed_work(system_long_wq, &ipvs->est_reload_work,
+		queue_delayed_work(system_dfl_long_wq, &ipvs->est_reload_work,
 				   delay);
 
 unlock:
@@ -5126,7 +5126,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 		goto err;
 
 	/* Schedule defense work */
-	queue_delayed_work(system_long_wq, &ipvs->defense_work,
+	queue_delayed_work(system_dfl_long_wq, &ipvs->defense_work,
 			   DEFENSE_TIMER_PERIOD);
 
 	return 0;
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index ab09f5182951..78964aa861e9 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -243,7 +243,7 @@ #define pr_fmt(fmt) "IPVS: " fmt
 	/* Bump the kthread configuration genid if stopping is requested */
 	if (restart)
 		atomic_inc(&ipvs->est_genid);
-	queue_delayed_work(system_long_wq, &ipvs->est_reload_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &ipvs->est_reload_work, 0);
 }
 
 /* Start kthread task with current configuration */

