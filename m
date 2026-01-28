Return-Path: <netfilter-devel+bounces-10452-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICAqHatpeWmPwwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10452-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 02:43:07 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C29BFC4
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 02:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC899300825E
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F42550D5;
	Wed, 28 Jan 2026 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="JVxL05X/"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA650146A66
	for <netfilter-devel@vger.kernel.org>; Wed, 28 Jan 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564583; cv=none; b=oUPwCKGJm46n0hq0jvdV+RvERuUgZjUh3YUH+uHkF+coq0PIGAPqng1BITc6kentTzAfl8rzU3nb2E9KHxiBcSlUWH2JWG0+lDNYOBoTEXVHdtbBwkK6rLEaOi3iZsNk7UyZNgp+kVis1x65eFWd1/BYZploFlyIVr2cKRfT7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564583; c=relaxed/simple;
	bh=HNJXpcDcZWPehrRRkIGWBW/QgeKQObS6a4Cr4gPmPOk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oq5jY5aHcGvyCyKi4g5G6xv4T8M9hH13LDrwLQ3o83AvrAXREiXawtvetrdH04U012oJh42MdEShhs7ngMCcAtUOJ3UmlZzodTAfsvtgoTuGYX3Dx80isZBUKq7pLg+B8rg5mzjUOOnkP4EJnS0u8Cj+ywS8GESFuB5XAVcEP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=JVxL05X/; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id BC2C660178
	for <netfilter-devel@vger.kernel.org>; Wed, 28 Jan 2026 02:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1769564578;
	bh=/1+JbcdQ6TDBwf/Af5DxXLV9FBsWTy4SWRT/EocACcM=;
	h=From:To:Subject:Date:From;
	b=JVxL05X/HMqOwHtojtCpYw+nVa0RrK8bKejtsVaeflKhmqz/jxWAzo6IBbvAWz6Hq
	 YCCV/9VQ+94zRBm2HHX2l1FpJIHjDN4FvaGs3hLp6iK4xhjz80SpHDLgflqszA/KVs
	 tF2nS3Cl6EEtTfQKorahIzHp+wCGm0BsjaEZF6L2xKk3U5kQcRLDxVEGVQgYCV8+qc
	 vCuXxjgm1k3DGwe7GM3feYYfESYXYt6JxzV13N1TC4SZSAnYFKEuZqq8QzDAtN4dTE
	 zj8dLnkT9RqZCgHDlp8vgHi+RJ1DB3frUTyDR3Q+smVzfNqVBuahApKfANdu8ZFID7
	 /PhDylMz3YzSw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/4] nf_tables: complete interval overlap detection
Date: Wed, 28 Jan 2026 02:42:47 +0100
Message-ID: <20260128014251.754512-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-10452-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Queue-Id: 165C29BFC4
X-Rspamd-Action: no action

Hi,
 
Overlap detection from the kernel in interval sets is still missing a
few corner cases, this is currently mitigated by nft from userspace by
dumping the set content for each add/create element command.
 
This series is composed of:
 
Patch #1 fixes null interval with NLM_F_CREATE: simply ignore this dummy
element when it already exists, so userspace does not need to dump the
current set content to check if it exists to decide whether to add it or
not to add it.
 
Patch #2 enables overlap detection for start elements with anonymous
sets. This validation in the kernel is currently disabled because end
elements are omitted with adjacent intervals.
 
The following command reports success while it should fail with ENOENT:
 
  add rule ip x y meta mark set ip saddr map { 255.255.255.1-255.255.255.3 : 1, 255.255.255.0-255.255.255.4 : 2}
 
Patch #3 extends overlap detection to report ENOENT when deleting start
and end elements that belong to different intervals, eg.
 
  add element inet x y { 1.1.1.1-2.2.2.2, 4.4.4.4-5.5.5.5 }
 
then:
 
  add element inet x y { 1.1.1.1-5.5.5.5 }
 
reports success but this should fail with ENOENT.
 
This patch uses a cookie field to store the pointer to the start element
that already exists, then validate that the end element is adjacent to
the start element that is stored in the cookie.
 
This patch also performs similar validation for deletions, eg.
 
  add element inet x y { 1.1.1.1-2.2.2.2, 4.4.4.4-5.5.5.5}

then:
 
  delete element inet x y { 1.1.1.1-5.5.5.5 }
 
reports success but this should fail with ENOENT.

Patch #4 enables overlap detection for open intervals in non-anonymous
sets, which are only possible at the end of the set. Note that Patch #3
relies on the end element to validate intervals, however, such end
element is missing in the last open interval of the set. This needs a
new LAST flag to detect if the last interval is an open interval.
 
This cover the following scenario:
 
  add element ip x y { 255.255.255.0-255.255.255.254 }
 
then:
 
  add element ip x y { 255.255.255.0-255.255.255.255 }
 
reports success but this should fail with ENOENT.

There is another corner case:
 
  add element ip x y { 255.255.255.0-255.255.255.254 }
  add element ip x y { 255.255.255.0-255.255.255.255, 255.255.255.0-255.255.255.254 }
 
reports success but this should fail with ENOENT. This is handled by
annotating that 255.255.255.0-255.255.255.255 is possibly an open
interval, given that there is no end element.
 
A better approach would be to allow interval sets to the KEY and KEY_END
attributes, but this is not trivial with the existing rbtree set backend
and it requires a lot more work. This series aims at addressing the
existing issues.

Pablo Neira Ayuso (4):
  netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
  netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
  netfilter: nft_set_rbtree: validate element belonging to interval
  netfilter: nft_set_rbtree: validate open interval overlap

 include/net/netfilter/nf_tables.h |   4 +
 net/netfilter/nf_tables_api.c     |  26 +++-
 net/netfilter/nft_set_rbtree.c    | 225 ++++++++++++++++++++++++++++--
 3 files changed, 243 insertions(+), 12 deletions(-)

-- 
2.47.3


