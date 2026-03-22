Return-Path: <netfilter-devel+bounces-11366-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOneGMymv2nY7AMAu9opvQ
	(envelope-from <netfilter-devel+bounces-11366-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Mar 2026 09:22:36 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D22E89D0
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Mar 2026 09:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6867F3010B99
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Mar 2026 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC282690EC;
	Sun, 22 Mar 2026 08:20:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.wilcox-tech.com (mail.wilcox-tech.com [45.32.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCE2701CF
	for <netfilter-devel@vger.kernel.org>; Sun, 22 Mar 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.83.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774167636; cv=none; b=WCKUyMSnZe7QOKdn88LiOZz2iy0LxkMK/vJbERojeQisH9l6xkVqYh5vNXoRhv/ca9+uZfboPMTA/4qLLoKhI46U7IFP/yWabuVyfj2gP7vKGyG7urloP23NgEswlDmId/wwyio0D2fZHqRyZcZtEwC5yiCIxFrb9I0rPM7b2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774167636; c=relaxed/simple;
	bh=oLleNzp0onQCOXlKNzzM7hlxbG5geAht4zy26ZwF1Gw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VTJK93Lyu55XETcEI8VPE9lDdbk5mVpKXa6ZZd6rWPSDCrQwpCWh4FdNLsCX7LFPfZwdyQDkDIU9Wx2L2r/hhcurauo1wceG1jrlP26EUBWQypg22hrffp+/8Z5IRG32tw7WK5qxIMSkrFim9oh67vmrUyqmjSbXlmAaVM1vFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Wilcox-Tech.com; spf=pass smtp.mailfrom=Wilcox-Tech.com; arc=none smtp.client-ip=45.32.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Wilcox-Tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Wilcox-Tech.com
Received: (qmail 16844 invoked from network); 22 Mar 2026 08:20:17 -0000
Received: from 201.sub-97-232-75.myvzw.com (HELO smtpclient.apple) (AWilcox@Wilcox-Tech.com@97.232.75.201)
  by mail.wilcox-tech.com with ESMTPA; 22 Mar 2026 08:20:17 -0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [libnftnl PATCH] examples: nft-rule-add: Fix compile on musl libc
From: "A. Wilcox" <AWilcox@Wilcox-Tech.com>
In-Reply-To: <ab0z8HmTHljlaUEg@chamomile>
Date: Sun, 22 Mar 2026 03:19:52 -0500
Cc: netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9792EFE-DF8E-41B8-8686-92BB328007B5@Wilcox-Tech.com>
References: <20260320084340.26543-2-AWilcox@Wilcox-Tech.com>
 <ab0z8HmTHljlaUEg@chamomile>
To: Pablo Neira Ayuso <pablo@netfilter.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[wilcox-tech.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11366-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[AWilcox@Wilcox-Tech.com,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E12D22E89D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mar 20, 2026, at 6:48=E2=80=AFAM, Pablo Neira Ayuso =
<pablo@netfilter.org>
wrote:
>=20
> On Fri, Mar 20, 2026 at 03:43:04AM -0500, Anna Wilcox wrote:
>> Without `_GNU_SOURCE`, the `dest` field on `tcphdr` is not present:
>>=20
>> nft-rule-add.c: In function 'setup_rule':
>> nft-rule-add.c:108:21: error: 'struct tcphdr' has no member named =
'dest'
>=20
> Do more examples need this?

No.  The libnftnl test suite passes fully once this patch is applied.

Best,
-Anna=

