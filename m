Return-Path: <netfilter-devel+bounces-10558-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNRkE49xgGkw8QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10558-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 10:42:39 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BBCA36B
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 10:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABA330048DA
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Feb 2026 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD252D5946;
	Mon,  2 Feb 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DSpSiXG3"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDF4A21
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Feb 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025257; cv=none; b=iM4r0AbhOkkdUoTngQ8jGj+QKBabqOIW5cwX+TstZQDDc+FZlH31Bq9YqFeRwU6ndXnmtEPeVTZkH25o8QqJydCZSCD04xia9FFyHBc0KbH0kSJqjelJeFmUpRuv6bM32MWG2lhtXi+b3YKjI0EiD3Pm6uH8Nm/TUUuSiDbg/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025257; c=relaxed/simple;
	bh=WnnZNkv4/bdK2PXwl6Fb5EzFIu1jXM4NKoHQKxkTHKE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mFvFu94hIcXVp+lluPNeJR81VFE52mwNLhHpg1R0e005niwzGsfh4SwpM1A8YaohEcgv75qtYQVsJN/X9lPieJYe268seAVbTET74NsSLWm3iaVo4y7EYxa1G6QYWS4GMJ+0N3avkk4RBb3SbHeg9KIAsnz/BNAs39itiENMFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DSpSiXG3; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770025247; x=1770284447;
	bh=rqGqb+IxeWQlKZ6Q2axTSQaxisBiUXtIfS/L5evgJjo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DSpSiXG3d/eU1wiwqEUUgkJiHtZEMtxgPKZnD96akNshYllKflg00hioEk02yXPSI
	 cYB2qh2w5ucze+QyUXFT/DiYn8SVc6jrQahhE1H96YTBkfSz1hI3CMmafz1meHiT7C
	 awgfi8vD1FToaTYJC/dm4gWBdDDqUZy4fwYYRPb7WDRWJ0wp4q07rx+Q+7E2I5LJzB
	 uB+nnvsjua0Wc6IhNROZR1WJhankCB9pMuHYBfjcw3jDGDdDi+JUc515QG8+LC4/tL
	 dY5wdL7jNRlzeQ5mFlLlOV2fF3jARIyGC4sMxM5pn6Zi4K/FGIKbkzJ2YBPXl6Ixs/
	 5VVrhlbCQWrsg==
Date: Mon, 02 Feb 2026 09:40:42 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next v7 0/5] doc/netlink: Expand nftables specification
Message-ID: <20260202093928.742879-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: c8afe568ce52d80bf5f1c42a61bd96d27e0bc21f
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10558-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,vger.kernel.org,protonmail.com];
	DKIM_TRACE(0.00)[protonmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netfilter-devel@vger.kernel.org];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:mid,protonmail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ynl_gen_rst.py:url]
X-Rspamd-Queue-Id: A27BBCA36B
X-Rspamd-Action: no action

Getting out some changes I've accumulated while making nftables work
with Rust netlink-bindings. Hopefully, this will be useful upstream.

v7:
- Drop "getcompat" operation.
- Fix formatting of lists of attrsets.

v6: https://lore.kernel.org/netdev/20260121184621.198537-1-one-d-wide@proto=
nmail.com/
- Sort sub-messages.
- Add description for "Add max check" commit.
- Fix doc comment for expr-bitwise-attrs to match one in nf_tables.h (thank=
s Donald)

v5: https://lore.kernel.org/netdev/20251120151754.1111675-1-one-d-wide@prot=
onmail.com/
- Fix docgen warnings in enums (avoid interleaving strings and attrsets in =
a list).
- Remove "# defined in ..." comments in favor of explicit "header" tag.
- Split into smaller commits.

v4: https://lore.kernel.org/netdev/cover.1763574466.git.one-d-wide@protonma=
il.com/
- Move changes to netlink-raw.yaml into a separate commit.

v3: https://lore.kernel.org/netdev/20251009203324.1444367-1-one-d-wide@prot=
onmail.com/
- Fill out missing attributes in each operation (removing todo comments fro=
m v1).
- Add missing annotations: dump ops, byte-order, checks.
- Add max check to netlink-raw specification (suggested by Donald Hunter).
- Revert changes to ynl_gen_rst.py.

v2: https://lore.kernel.org/netdev/20251003175510.1074239-1-one-d-wide@prot=
onmail.com/
- Handle empty request/reply attributes in ynl_gen_rst.py script.

v1: https://lore.kernel.org/netdev/20251002184950.1033210-1-one-d-wide@prot=
onmail.com/
- Add missing byte order annotations.
- Fill out attributes in some operations.
- Replace non-existent "name" attribute with todo comment.
- Add some missing sub-messages (and associated attributes).
- Add (copy over) documentation for some attributes / enum entries.
- Add "getcompat" operation.

Remy D. Farley (5):
  doc/netlink: netlink-raw: Add max check
  doc/netlink: nftables: Add definitions
  doc/netlink: nftables: Update attribute sets
  doc/netlink: nftables: Add sub-messages
  doc/netlink: nftables: Fill out operation attributes

 Documentation/netlink/netlink-raw.yaml    |  11 +-
 Documentation/netlink/specs/nftables.yaml | 694 ++++++++++++++++++++--
 2 files changed, 655 insertions(+), 50 deletions(-)

--=20
2.51.2



