Return-Path: <netfilter-devel+bounces-11336-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANydOt9EvWkR8gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11336-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 14:00:15 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A72DA9CE
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 14:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F031302802F
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620A325483;
	Fri, 20 Mar 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="qIpGcTuV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302EE1A6835
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011596; cv=none; b=TpRwuP20m58//dUNwl5RESj7Pt+OqxjzCgvz6MDcbfp+Yv7IiZTXZb7tr+Tk7QXNOtlvj8zpGn9C7PpDtLVezblLnzjQrtLKoXueffxmxXqzVI3+tz6ho2GQk7I7QlPTVgtEdn/5h56tiGM3MyYU5hHsoj3T7dv9kbHozoIhyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011596; c=relaxed/simple;
	bh=pIkHSS/VPw8ajSMGRxbVWheMzKTK0Pj1kCYNUejfAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1xyurZngKUCN1IPcm9HYjFK2HvRUUSQrV4lVtFBWwwsa+rIsMP+wAUYlCYCBVEb3qxuJkGVmbOvE4Lt+C3Z119soZlM/MZKDPXmwdLBs6PlW/MQgPQO8gYDm6hdFN/b8OaigtnDKuDvRS6PMgliH9YRiUtJkv8ZDqXYVFnrDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=qIpGcTuV; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 7232D60178;
	Fri, 20 Mar 2026 13:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774011591;
	bh=A5Q0AM+kOcjeYLevdRyenDGFxI02NHGAcT6qS1NpWhc=;
	h=From:To:Cc:Subject:Date:From;
	b=qIpGcTuVwr0ZJBsVGfOWZxjyR01vnQIyvCV1zG+fcBCHOK+f1M1mHYF0l892QdtUJ
	 fFuoK5MuAe+nN7DgZFcrCQjR/07TS/glEv8mSPgWCWjWcu34Dq0SUL4B45pqGDna9h
	 a72Nmur3GCGvCHO3jsA4ZzH82ImyLvMWQeTQ/MKEy3xF5OZ+XvawuKJ8Vre/l1AWqk
	 tSopl+k+ytxjxs9AX8UARIhGod5vLbKBo5RED83qoRUJro8FDJKirrBlDKnIxFlZeI
	 /cQYtURDZrL8bmTRoav4pDqDqIODwp1VZoJ1bOFhI9yjWg4nzk1V+ZbJnBbp9EM8z+
	 VTK5r2vwUEfvw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf 0/5] conntrack expectation fixes
Date: Fri, 20 Mar 2026 13:59:42 +0100
Message-ID: <20260320125947.305117-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11336-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: 586A72DA9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series addresses races in the conntrack expectation
subsystem.

Patch #1 and #2 honor the exp->helper as a replacement to accessing
exp->master->helper which is unsafe when accessed away from the
nf_conntrack_expect spinlock, because the ct->ext is released
immediately, hence rcu_read_lock section cannot help in such case. On
the contrary, accessing exp->helper under rcu_read_lock section is safe.

Patch #3 extends the spinlock section in delete and get expectation
commands in ctnetlink, because holding a reference on the expectation
is not sufficient, the master conntrack can go away rendering
exp->master unsafe.

Patch #4 and #5 move the netns and zone to the expectation object.
This is to fix /proc/net/nf_conntrack_expect which is dumping the
global expectation table in every netns. By moving these fields
to the expectation, it is safe to access them under rcu_read_lock
section.

This passing tests with shell and scapy generated traffic to create
expectations for the ftp and tftp helpers, I am still reviewing the
remaining helpers in the tree. I will come back with a confirmation
that all is ok on that front too.

Pablo Neira Ayuso (5):
  netfilter: nf_conntrack_expect: honor expectation helper field
  netfilter: nf_conntrack_expect: use expect->helper
  netfilter: ctnetlink: ensure safe access to master conntrack
  netfilter: nf_conntrack_expect: store netns and zone in expectation
  netfilter: nf_conntrack_expect: skip expectations in other netns via proc

 include/net/netfilter/nf_conntrack_core.h   |  8 +++
 include/net/netfilter/nf_conntrack_expect.h | 20 ++++++-
 net/netfilter/nf_conntrack_broadcast.c      |  2 +-
 net/netfilter/nf_conntrack_ecache.c         |  2 +
 net/netfilter/nf_conntrack_expect.c         | 30 +++++++++--
 net/netfilter/nf_conntrack_h323_main.c      | 12 ++---
 net/netfilter/nf_conntrack_helper.c         |  8 ++-
 net/netfilter/nf_conntrack_netlink.c        | 58 ++++++++++++---------
 net/netfilter/nf_conntrack_sip.c            |  4 +-
 9 files changed, 101 insertions(+), 43 deletions(-)

-- 
2.47.3


