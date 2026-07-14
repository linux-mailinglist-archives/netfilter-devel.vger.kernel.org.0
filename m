Return-Path: <netfilter-devel+bounces-13926-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XWG/AxzKVWoLtQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13926-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 07:33:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E0975128A
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 07:33:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=suksangroup.co.th header.s=default header.b=aRt5nAb4;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13926-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13926-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=inbox.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26B72300532F
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378C332861F;
	Tue, 14 Jul 2026 05:27:02 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC93264CF
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2026 05:27:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006822; cv=none; b=tBdWHGM25dRkOjc12gpQTHuKfC65l+6+XViUrgbcyrbS1Rdv6ankbGiT9wVDhMDI3YEUxSYVN9aTa03bW5Skf7ad6Wx+1lGOUAqN/kzXhXsXhF1HYuHzzoyDNvbeqjR8GmidtNvvGg/RiPCapDwZchon+Vg2KNzGg6xJgmdr2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006822; c=relaxed/simple;
	bh=DLqeX2mToppQSWbr5Rp910EkiiV6FhxXZsRdTxjdK/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPvXSJou3fq9gTF+PVNJGnXHuv6IZFmpu3xTtFgRBxNGR/o+DykTl1i1viKE2/4giNTS7/pzd1GN+/HqmkA1EMjOge+JPZQrqqhHk0Jlrx+AzRzxOWAOOmBfie0vGmv31seqa/nNf5jX5a5f7rzC2V+YSnHqrsyNmVC5EJD2bbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=aRt5nAb4; arc=none smtp.client-ip=103.13.31.55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DLqeX2mToppQSWbr5Rp910EkiiV6FhxXZsRdTxjdK/Y=; b=aRt5nAb4lKGnj6srff1PeqkZPn
	Dp+tvQRGCfK8tixA51jnB7dZ+7fUM2Vu5xeD0PdAibOzPCX0RTfxfMY4Kpm8I4qVYjoUqyJEB3qCP
	5EmoyBSGkE/oPQTqLJMMqoqGRYdVfH/Vpew2oOkLz1GmETkAPVlyat5ji4wPQ1HQOCdVr64u9ctsS
	A6LJ09FVuxFXRZcKssgFckFtp49iDt9HDCIzvJQJIVUcYUWxDYw+PATul+hxdH9lNJs5Z7iXZ0hB3
	tysf0CIEFvSHxV9aLmgjMRwTkjQ7MnumXhgNdO075pg/ZD2kN9JnCqc7BIvKT2c7twFjwh9vP97S2
	46on7EFw==;
Received: from [207.189.26.187] (port=64035)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVfY-0000000Fytc-03Hu
	for netfilter-devel@vger.kernel.org;
	Tue, 14 Jul 2026 12:26:59 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: netfilter-devel@vger.kernel.org
Subject: Dear netfilter-devel, project info
Date: 14 Jul 2026 00:26:55 -0500
Message-ID: <20260714002655.53747ED8E7225D9F@inbox.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.94 / 15.00];
	ABUSE_SURBL(5.00)[lexcapitalgrowth.com:replyto];
	R_DKIM_REJECT(1.00)[suksangroup.co.th:s=default];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[inbox.org : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13926-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[smtp@suksangroup.co.th];
	GREYLIST(0.00)[pass,body];
	HAS_X_SOURCE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_GMSV(0.00)[smtp@suksangroup.co.th];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[info@inbox.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@inbox.org,netfilter-devel@vger.kernel.org];
	HAS_REPLYTO(0.00)[hanns.schofield@lexcapitalgrowth.com];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[suksangroup.co.th:-];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lexcapitalgrowth.com:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,inbox.org:from_mime,inbox.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1E0975128A


Re:Good day netfilter-devel,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA



