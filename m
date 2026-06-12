Return-Path: <netfilter-devel+bounces-13237-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VyXTJjgBLGqfJQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13237-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 14:53:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD57679847
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 14:53:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=ghmCFP54;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13237-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13237-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C9BE30243A1
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D83074A1;
	Fri, 12 Jun 2026 12:52:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED153A9002
	for <netfilter-devel@vger.kernel.org>; Fri, 12 Jun 2026 12:52:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268767; cv=pass; b=IPWcPECmIlovUM2m/ZeRtj07kdzsEZ6xuxcGztYYLwsiSV1gnGTFucG2lAyM+77gCTrtexnZls7zIyWXKjDgrbDcGeaaPy/XBiksegVW6I6UUQliZKv7PaLobtFUJsgMe9bUKlTPJo8nhSRJC0lPqA3FAQ+LPzEtNf0G/KLzxYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268767; c=relaxed/simple;
	bh=86mDC7ruP/2ajWD+fSdzORJCNhBZZaQsuJ8vrIhtAIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcqQHXlkVhEPKKhWjGtUMFb4DbVsV+3l4e6LsqbI48gS/w8BZpUqo1ZpCqSqPMiTXKb+809gQkOpPpnBIXBhcNpgw6rhtis/V68lxBQlV4mY5ARzMGmLoMLt0yOfKMmlodJfqrCSHFNBfyJar2LQqYYOJAJqXqmtvR/6eggn64U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=ghmCFP54; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1781268737; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KdZI3vqBElFt5L+TCsFlC8P7oTvfUCyk7DSvALplRI/yZKsEfmFyOKxsN1UdaSxy1OYgH7NagMqBTjNhK7uOMfQIkMkU7OyGdOm81wb3JhQMsWWf7aLpWgVI7frf50+ufeQ4C9DFt9ZAq95QVW5KLAAIYKpZtrL2nYhp6/I1wyA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781268737; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cS9NSECc2+e0XAcEOI0LWPvqayQh8tYk2xJCYx044c8=; 
	b=VsOS+rhOdrPHksZJM4FtskFX4fa9Yx6bNvpIuhbKvmF0Kxpy+iIJpZ7jHGk227cjgCs3VSm9c9fOp1W/mviBGlSJ8oaKanW2nF9+4KdgHAo0DDmUBHGaM7QifWUMGEmVPuFAyhhPYvkV5IlWzAwlM0gP0y1OdtLRX2C8FHly3vE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781268737;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cS9NSECc2+e0XAcEOI0LWPvqayQh8tYk2xJCYx044c8=;
	b=ghmCFP540ye8Vaax4NErDhertjPTiZxiwlclOuvTEI/2mlV4W2yMDEiaoNlarjm4
	TDa8EPvHxITZ7J/xuJgBxQXQHAyzwGMWpVlJJDXWQcfkkMw6yUq7hMA8eBc9pnNOJCP
	jldnEWgMGEeknIp6iNsjSlxvjLb8eZFprLGcAQbQ=
Received: by mx.zoho.eu with SMTPS id 1781268735526513.0757740974964;
	Fri, 12 Jun 2026 14:52:15 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: coreteam@netfilter.org (open list:NETFILTER),
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	netfilter-devel@vger.kernel.org (open list:NETFILTER),
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>
Cc: Carlos Grillet <carlos@carlosgrillet.me>
Subject: [PATCH nf-next 0/6] netfilter: replace u_int*_t with kernel int types
Date: Fri, 12 Jun 2026 14:51:46 +0200
Message-ID: <20260612125146.75672-1-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612123653.70510-2-carlos@carlosgrillet.me>
References: <20260612123653.70510-2-carlos@carlosgrillet.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:coreteam@netfilter.org,m:davem@davemloft.net,m:edumazet@google.com,m:fw@strlen.de,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:pabeni@redhat.com,m:phil@nwl.cc,m:horms@kernel.org,m:carlos@carlosgrillet.me,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13237-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,carlosgrillet.me:dkim,carlosgrillet.me:mid,carlosgrillet.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CD57679847

Hi all! This is my first patch series of many, I hope :)
I'd like to start contributing by helping out with janitor work,
standardizing code and cleaning up.

This patch series replaces POSIX u_int8_t/u_int16_t with the preferred
kernel types u8/u16 across several netfilter files.

u_int*_t appears in many other files, 48 more to be precise, but I wanted
to keep this series small, unless advised otherwise.

No functional changes.

Carlos Grillet (6):
  netfilter: nf_nat_ftp: replace u_int16_t with u16
  netfilter: nf_nat_irc: replace u_int16_t with u16
  netfilter: nf_sockopt: replace u_int8_t with u8
  netfilter: xt_DSCP: replace u_int8_t with u8
  netfilter: xt_TCPOPTSTRIP: replace u_int8_t and u_int16_t with u8 and u16
  netfilter: nf_log: replace u_int8_t with u8

 net/netfilter/nf_log.c         | 14 +++++++-------
 net/netfilter/nf_nat_ftp.c     |  2 +-
 net/netfilter/nf_nat_irc.c     |  2 +-
 net/netfilter/nf_sockopt.c     |  8 ++++----
 net/netfilter/xt_DSCP.c        |  8 ++++----
 net/netfilter/xt_TCPOPTSTRIP.c |  8 ++++----
 6 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.54.0


