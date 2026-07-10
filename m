Return-Path: <netfilter-devel+bounces-13822-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eo1POIDFUGpX4wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13822-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 12:12:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFF7397E2
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 12:12:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=uLuMUZ1j;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13822-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13822-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96E3A30072B1
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C573F12F2;
	Fri, 10 Jul 2026 10:07:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6753126B0
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 10:07:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678057; cv=none; b=dUKarNGeClU3FnJvqvdpR9qftZgcfV4azlbTM48QfhWAO8OnGp/6xo9Ty5RI+ZFtyAyZNrXdQwY0RBcwXeJDm6ZhERt2sGhkj3nrvurHSRoUZFAomMPIL+J/1qsvCgdarTCmP4Hk4qy9CmFZ87SIU+GcQRTDiQMHi0XILhL8mJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678057; c=relaxed/simple;
	bh=CnIIkWJhn+dzqUepCaS4znouq2Fz6HLKTb1eTyTh7wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfr11u9mKdLaQGoudpjmEamuIb4Erx8830WV2pDK0dZy1H5kBt7I9Zhajgph1q0ZnEOwSiEhHz2PwoEHO9U9kEm1R0PlRVs4HHZCck5phdlclGL+LAfaDXWTgXPG2+xVSyB6ujtA0vp4Lpzb3YW9TyA2Xgx5L9cdsXaDmO9ocIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=uLuMUZ1j; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C71EE60297;
	Fri, 10 Jul 2026 12:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783678053;
	bh=WeLUY4dgS9XHTdc4XBKIjW52zHgUYHlYVFq9IwO2RVU=;
	h=From:To:Cc:Subject:Date:From;
	b=uLuMUZ1jaan8TV8ysnXsbVfBq76Uv/lrqZTfArhihKGm8MVYvw0jirNgeN8bPPxfc
	 ddpAn3vF8yNTT7bp82JaaKyUnFVxiedInLM4eCIdfZFQaFVvOPEil94jfrxX2fptcd
	 nG41TvAddzlcUo5yZaZkoTV7OSup63d0nZGHV2iXLnsjnuA1zRF8F4Wu3yaEQ6GT7L
	 jLMJI388PO00z0PQFEw5xL8cXOZf1d+rNl5QHu6JQbFF5Shu7lCHo4t7pHgsUJ5hYn
	 PYZM3UZHnNl9Ijf8UlzJu3s93hsM+DV/PRumsVCR+VZ8QAdL231P5WpfDGHaRBnTO6
	 9RSPusRdYfDPA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: razor@blackwall.org,
	ericwouds@gmail.com,
	fw@strlen.de
Subject: [PATCH nf-next,v2 0/3] initial flowtable bridge support
Date: Fri, 10 Jul 2026 12:07:26 +0200
Message-ID: <20260710100729.1383580-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13822-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[blackwall.org,gmail.com,strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:razor@blackwall.org,m:ericwouds@gmail.com,m:fw@strlen.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CACFF7397E2

Hi,

This series adds initial support for the flowtable bridge family.
The goal is to allow to set up a forwarding path between bridge ports
which is not possible with the existing infrastructure.

This series does not support for VLAN/PPPoe tagged packets circulating
in the bridge, ie. packets are seen untagged from the ingress path of
the bridge ports.

Note that this does not include bridge vlan filtering which needs
a nf_conntrack_bridge enhancement to support PPPoE/VLAN natively, so
I can keeping back those patches 

Patch #1 and #2 are preparation patches, not strictly necessary at
this stage but they will be needed once the flowtable bridge can handle
tagged PPPoE/VLAN.

Patch #3 adds the initial flowtable bridge supports. This intentional
adds a new dataplane for the flowtable bridge, which is more boilerplate
code, rather than tweaking the existing flowtable IP dataplane. This is
intentional, for maintainability and extensibility reasons. Similarly
a new flow_offload expression is added for the bridge family.

Comments welcome, thanks.

Pablo Neira Ayuso (3):
  net: pass net_device_path_ctx struct to dev_fill_forward_path()
  net: expose dev_fwd_path() helper via static inline
  netfilter: flowtable: initial bridge support

 include/linux/netdevice.h             |  13 ++-
 include/net/netfilter/nf_flow_table.h |   7 ++
 net/core/dev.c                        |  28 ++----
 net/netfilter/nf_flow_table_inet.c    |  12 +++
 net/netfilter/nf_flow_table_ip.c      | 134 ++++++++++++++++++++++++++
 net/netfilter/nf_flow_table_path.c    |  79 ++++++++++++++-
 net/netfilter/nft_flow_offload.c      |  88 ++++++++++++++++-
 7 files changed, 336 insertions(+), 25 deletions(-)

-- 
2.47.3


