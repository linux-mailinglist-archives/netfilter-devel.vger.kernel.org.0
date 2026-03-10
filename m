Return-Path: <netfilter-devel+bounces-11111-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDjlEimlsGnQlQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11111-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 00:11:37 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE225930C
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 00:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70CEF3075AAA
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 23:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9B3783C2;
	Tue, 10 Mar 2026 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="gT9xDYrH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E737472F
	for <netfilter-devel@vger.kernel.org>; Tue, 10 Mar 2026 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184285; cv=none; b=V537yUvCn9K+mxdju3ze+ipj0UeNGLrthGZi4JrHhrAAcqA89+V+wDxk1c/iDy70OoODZsUvJHVXMH4teJmleypLlNqhwZTRO/u9uRsU9WYpN2XphmsF00cPRAyo+OywjQVYpYjMhz3jj9ICE02PrEutlmjwJks93edI/kpXemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184285; c=relaxed/simple;
	bh=NScDZBDLI+ri2S045KaeVmtusz+sRzgaqKCbXKRDrJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKi3M9e+wD3zBfQBmJy7FfhKsHoVGOqZrOH1BzQYRWCI8b6H5fxq8Zej9tpDKwYcqq9zN5y/qHlc570Y+38hRi3lLqK/M5LozjbG+NxsaXGSbe64CFgblMydW4fkdkRdPZ2thbEzSobRBDe2cht3eqLyWt8IsmnH2fDiKuKMu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=gT9xDYrH; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d+H3jI456eW7dgmPuQKkBQ+ZVPpr/B8flnzjgXmH+Hw=; b=gT9xDYrHTiKtvUAXRbXIBiAXxV
	cGHcbiosAAZAGVkC4edUAJObchbCozr6dh2F8slcQIhIN/ZgH9yxOCkOBFFkXS9ULdYsOpSA+uUo2
	YJPBE5cPCmnngmA2RNiT6/6UjgsM+nNni3zTlzTi26t2Lr/Vl45X40thV5v4hNuKC7rptBrSV1Vf0
	kZ93CZzucMVsL3eEMYhbjVCaFEKpDDdPIrT4Wdp2tqK7DY6jo/HSVJuZYvWo+vCo0ErLG5EJG384A
	pmCMKC+OQfIgkjeTBaSVegOva+Q0iRjQzr3qBTSnYNXb81Zvco4ntDdRFPLisOGnVcBe1OQp2QkkZ
	vDglVQbA==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w06EU-000000004qp-1nZ8;
	Wed, 11 Mar 2026 00:11:22 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: [nft PATCH 5/5] cache: Filter for table when listing flowtables
Date: Wed, 11 Mar 2026 00:11:15 +0100
Message-ID: <20260310231115.25638-6-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310231115.25638-1-phil@nwl.cc>
References: <20260310231115.25638-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03DE225930C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11111-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Respect an optionally specified table name to filter listed flowtables
to by populating the filter accordingly.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/cache.c                                 | 1 +
 tests/shell/testcases/listing/cache_filters | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/src/cache.c b/src/cache.c
index f86d000690929..bad8275326c76 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -266,6 +266,7 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 		/* fall through */
 	case CMD_OBJ_FLOWTABLES:
 		filter->list.family = cmd->handle.family;
+		filter->list.table = cmd->handle.table.name;
 		flags |= NFT_CACHE_TABLE | NFT_CACHE_FLOWTABLE;
 		break;
 	case CMD_OBJ_COUNTER:
diff --git a/tests/shell/testcases/listing/cache_filters b/tests/shell/testcases/listing/cache_filters
index 7a89330d2b6c0..e3d0e5e5a7217 100755
--- a/tests/shell/testcases/listing/cache_filters
+++ b/tests/shell/testcases/listing/cache_filters
@@ -47,4 +47,7 @@ $NFT --debug=netlink list flowtables | \
 	grep -q 'flow table ip_t ip_t_ft' || fail "broken list flowtables"
 $NFT --debug=netlink list flowtables ip6 | \
 	grep -q 'flow table ip_t ip_t_ft' && fail "broken list flowtables family filter"
+$NFT --debug=netlink list flowtables ip ip_t2 | \
+	grep -q 'flow table ip_t ip_t_ft' && fail "broken list flowtables table filter"
+
 exit 0
-- 
2.51.0


