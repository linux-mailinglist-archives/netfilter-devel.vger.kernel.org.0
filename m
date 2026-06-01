Return-Path: <netfilter-devel+bounces-12978-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPv6DDreHWpsfQkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12978-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 21:32:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8B624AAB
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 21:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F58430094E4
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA357349CFD;
	Mon,  1 Jun 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NByVCFal";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m3VtVZYA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NByVCFal";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m3VtVZYA"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A2345724
	for <netfilter-devel@vger.kernel.org>; Mon,  1 Jun 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342270; cv=none; b=OselfbUmBYjANhdXAyCsVJn+ivPxBv/dznXFh9UByfxn+9/19F2QzxNeurVARhKp+IS//v59d8WgxA+ixP+d687iJg8b1jGXzcgZKK01IWuBpxXr7Sowg5SEZM9QPJuetUM0vXSUMGcc0lX3l4rD2PHVXbRJWrvi0cixu5L7XAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342270; c=relaxed/simple;
	bh=nFR/r1fzdiKANfOtE1/vTalV0PMokZ2Uc2pZVxbbrrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqA28Sf1LwmvW6ICXItvoXW/aPy2XkCDTvU8oplfE9c0Xh0Z5PoRXBvSvDwF5O0CgsUlan7uFX2TAOyWBnhiukfvwje6xfuvwnpqcko+1Gk2VN+/uxHUwvIweAeORxvELGUH5cs/GJ3pCAxoO9W+RS4c4JYkL9EInOHsZEHspcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NByVCFal; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m3VtVZYA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NByVCFal; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m3VtVZYA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AEE16A91A;
	Mon,  1 Jun 2026 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780342267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQER7HMDilX000+D47pVsBvUcxIoQ0gGCT2WoKj2xvA=;
	b=NByVCFal90qNk98tL2fIWYuQzWhQkhVJDRucp+aqo0kaWYwShYsndKxeN+6vEdInK8d4nO
	N9gv2jdn2Xj4K3V6QeoCs8Q+LLXeKHy5Zv1BqYqrvDy9cT7sijxKd5i55ERyR2ZJ/2NO39
	z/idNhulx2UMv6xhgZZ6kIuHRS8xI1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780342267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQER7HMDilX000+D47pVsBvUcxIoQ0gGCT2WoKj2xvA=;
	b=m3VtVZYAB2MuPqOjYdmr9rujZeSuJB6yvpRcKvROWCH1Q5VA5hm+JiOydkJMyRk5QQnpQK
	PEbHZptK4wQmguDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NByVCFal;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m3VtVZYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780342267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQER7HMDilX000+D47pVsBvUcxIoQ0gGCT2WoKj2xvA=;
	b=NByVCFal90qNk98tL2fIWYuQzWhQkhVJDRucp+aqo0kaWYwShYsndKxeN+6vEdInK8d4nO
	N9gv2jdn2Xj4K3V6QeoCs8Q+LLXeKHy5Zv1BqYqrvDy9cT7sijxKd5i55ERyR2ZJ/2NO39
	z/idNhulx2UMv6xhgZZ6kIuHRS8xI1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780342267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQER7HMDilX000+D47pVsBvUcxIoQ0gGCT2WoKj2xvA=;
	b=m3VtVZYAB2MuPqOjYdmr9rujZeSuJB6yvpRcKvROWCH1Q5VA5hm+JiOydkJMyRk5QQnpQK
	PEbHZptK4wQmguDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CF8C779A7;
	Mon,  1 Jun 2026 19:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QNIsDPvdHWobLwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 01 Jun 2026 19:31:07 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	phil@nwl.cc,
	fw@strlen.de,
	pablo@netfilter.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 7/9 nf-next] netfilter: bpf: use DEBUG_NET_WARN_ON_ONCE for missing BTF structures
Date: Mon,  1 Jun 2026 21:30:47 +0200
Message-ID: <20260601193049.8131-8-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601193049.8131-1-fmancera@suse.de>
References: <20260601193049.8131-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12978-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: A5D8B624AAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace WARN_ON_ONCE with DEBUG_NET_WARN_ON_ONCE in nf_ptr_to_btf_id.
The function already returns false when a structure lookup fails, which
causes the BPF verifier to reject the program load and report the error
cleanly to userspace. This prevents unnecessary system panics when
panic_on_warn=1 is enabled in production systems.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/nf_bpf_link.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index c20031891b86..7a1cd767f236 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -280,8 +280,10 @@ static bool nf_ptr_to_btf_id(struct bpf_insn_access_aux *info, const char *name)
 		return false;
 
 	type_id = btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
-	if (WARN_ON_ONCE(type_id < 0))
+	if (unlikely(type_id < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
 		return false;
+	}
 
 	info->btf = btf;
 	info->btf_id = type_id;
-- 
2.54.0


