Return-Path: <netfilter-devel+bounces-10688-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPi6KNHfhWnFHgQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10688-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Feb 2026 13:34:25 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5F5FDA23
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Feb 2026 13:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39863013D69
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Feb 2026 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA33A9621;
	Fri,  6 Feb 2026 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="RPqsyBHX"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD223A7F46
	for <netfilter-devel@vger.kernel.org>; Fri,  6 Feb 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381239; cv=none; b=tD6z5U/NksHQtUeTlMNqs3I+C1yhRDgszO8ycCJQjuH0HiHQ2Ja6prnfQDtalch2WuhkfEuGf876vTUS7wIWo9FxLiMEvg0upr4TLuojrNVKonoBAu5woamNGvaiGcfkGcUlCnyeHf9Pv07mVzYChQFhAhFdnvB2jbMgbWZQ9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381239; c=relaxed/simple;
	bh=vmbA8RaDKlSisHrYRkJTXXsjFgHKWy+QqxF4CQJLDQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mi5+z661HFGDjTd3q4AHwYgoFyZdF/v1oEGaYTWrYcaddap+PsD5pw8Hj2h+03PTEC/E+ETx5GF9Toxzu0/S7vByKN64k9t6FE+TOX7HW1OLsVAcc4QtpiscRWiemvyibKSaOTV0bu3Mlqs+dQfe2FiGbFOU1wHOs6hkpRvFTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=RPqsyBHX; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 96B0760888;
	Fri,  6 Feb 2026 13:33:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770381229;
	bh=vi550CN9H1WNaMx+11098lGnuTjYxfaEg9OPn4iiVK8=;
	h=From:To:Cc:Subject:Date:From;
	b=RPqsyBHX8LVEGK81W1+QNCmyV8tuZwkfFpwS00rmoF6Zuyi57+ycc7XnMj59zqhiq
	 K2FdpwUQUxI3cbSLZLQIWkPwQPAVGqovAQlfo26IIhK7gfj6/x2xnSJAaEYhR7HsPt
	 gY2FnLMemUhAvlrzmpZnEQQntCDb/Fiml7uQ0SJAZKdH8cRj/WzlgWnDcCtEuYdr5N
	 RcBc84c2ZBsKtj34RovymH6jn1t+58hmGWh7HenvEs2uChdJDwruYn+dj6JTVxvFPT
	 rUQ6xv9J1VBLvqC1rJosUwQNkb9JeuAePbKa4b5v1ocolJxzm+XyyJE59wniucv9Rb
	 MqG4G7SXq4+BA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf-next,v3 0/4] nft_set_rbtree: complete interval overlap detection
Date: Fri,  6 Feb 2026 13:33:42 +0100
Message-ID: <20260206123346.1529474-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-10688-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D5F5FDA23
X-Rspamd-Action: no action

Hi,

This is a series addressing comments by AI.

It has spotted mostly comestic issues, but it also uncovered a real
issue in the last patch.

Please, apply this series for the nf-next PR, thanks.

Pablo Neira Ayuso (4):
  netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
  netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
  netfilter: nft_set_rbtree: validate element belonging to interval
  netfilter: nft_set_rbtree: validate open interval overlap

 include/net/netfilter/nf_tables.h |   4 +
 net/netfilter/nf_tables_api.c     |  26 +++-
 net/netfilter/nft_set_rbtree.c    | 241 ++++++++++++++++++++++++++++--
 3 files changed, 258 insertions(+), 13 deletions(-)

-- 
2.47.3


