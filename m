Return-Path: <netfilter-devel+bounces-13488-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L9bgBPfvPmrXNAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13488-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 23:32:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C0F6D0466
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 23:32:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=redfish-solutions.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13488-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13488-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B857C3007218
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10843502A7;
	Fri, 26 Jun 2026 21:32:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [50.20.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331D296BCC
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jun 2026 21:32:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509553; cv=none; b=d+XxGh9/oxlrDYDGBE1KjImMx4x/PYV5CVFRCnzVe/9vqys1tpOqM37LQkolEpVKWrXiYbvfh6WXIxcBPA3D3B6yG1Jl3keZSTB3hL0FzdkSFWFUPY8jB7nc+uMsR+8KMe7XPTL4mTFxlfcmyyw6TsHrEOFZgtGswVt1hfu4c7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509553; c=relaxed/simple;
	bh=eL5EA8pH5NHV8W4mewFKTI+mx5+fb/Jd8ZA9sWQux4I=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Uo2jrl6tmOUgrSHa8Fd2H9pLoxXas0qRIVXF8YH17Ajx+EoE6ISmFP3oU+/B1N8KPNB+rzsG2qnBqjKm1UD0UyktyHTVDqLljwvIXYJ8Z3JZJ4mpHj0SqJ2EQxmMsZikTbYrfLetrbTjxNhhM9NPVE9peGiRepsy8V0LSSscdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com; spf=pass smtp.mailfrom=redfish-solutions.com; arc=none smtp.client-ip=50.20.195.61
Received: from smtpclient.apple (macbook4.redfish-solutions.com [192.168.3.6])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.18.2/8.18.2) with ESMTPSA id 65QLO5GA044261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jun 2026 15:24:06 -0600
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: OpenWRT bounty for strong host behavior
Message-Id: <98897A5C-14E5-4827-A347-56B45C021250@redfish-solutions.com>
Date: Fri, 26 Jun 2026 15:23:54 -0600
To: netfilter-devel@vger.kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Scanned-By: MIMEDefang 3.6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[redfish-solutions.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13488-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[philipp_subx@redfish-solutions.com,netfilter-devel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philipp_subx@redfish-solutions.com,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61C0F6D0466

Anyone interested in working on this?

It's been pointed out that pbr and mwan3 provide this functionality, but =
if you ask me it should be part of the core functionality of networking =
and/or the firewall since it relates to NATting (you want the ingress =
packet matching the NATting of the egress packet and vice versa).

https://github.com/openwrt/firewall4/issues/93

If you want to work on it, contact me for terms.

Thanks.


