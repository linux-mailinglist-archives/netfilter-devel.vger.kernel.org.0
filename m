Return-Path: <netfilter-devel+bounces-10944-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBZsMCWMp2kuiQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10944-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 02:34:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9551F97CE
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 02:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1ADBC3033404
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743230EF92;
	Wed,  4 Mar 2026 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="txCzLKVJ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16430CDAB;
	Wed,  4 Mar 2026 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588059; cv=none; b=YcYkezPJtfFsHQ7AGmB+hdfsFuEyClfAPXk+/Oq1bh7pWPa+vW+M+C83XAeNGxO02fFiE2O2nOD6iCk52FEFKnb2vENHhVyLwDz8ll0jYu+kexLTxBYgNXaymiO6oNtXzdGfFPcvAkqkrdW+iRfERJ2/K40M+k7Lh/vR6P7POPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588059; c=relaxed/simple;
	bh=t9gZ16sRwNdgu704XD8+TWQ1hwtxbyjiFS75MDq6tvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W15SG+mQUOnVD+wiMuBChKP1Ep1tEptm5p+UKV2o9gWvr8VQraw2sxv8hnvHGVSPb2umhMcIMcTBq+px35ADN65xhCtJPOlWYmvbPdbS/r4uFxtg8PmOOxh4uM4dIMfoP92OdQjnaoGtGoynJAWQNv2RIuaUioEUzugx3NMVQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=txCzLKVJ; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 1767E6017D;
	Wed,  4 Mar 2026 02:34:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772588056;
	bh=KoOkUHlebztnj5ySuklW6b9Nj06PUyO4YBSJZL9llZc=;
	h=Date:From:To:Cc:Subject:From;
	b=txCzLKVJAikh/h4JjRvsinV/8Cwl8LvBztCQ6CIPkEqfKU4/17V8hoywe0y5DctJ2
	 TyeVQJ+uWahRyjIQ8384a4IKlolHIrsFfHdNhoL4VI4irFgHxHwJpXRv7HZUVFAFcm
	 3Ouua5bu9p6FTc/9aVmufGexwvPMKg3iOOTDdhJWVMPg5iJGYFosy5shILlGVrUvpf
	 pFMi0dFiz+5zTKunP9q6AnsOD3Bx3r4CqsgEXVJVlAsU+csmw9mPbYT2r+5umHcR54
	 3QZZQMLEnrAdQYjHEWsyS4IpP5KyYNA9NnvH/AFctCfP8YIy65/dWRAdWQ2AR3r8sB
	 K3VhTpQ2RGuhw==
Date: Wed, 4 Mar 2026 02:34:13 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org
Cc: netfilter-announce@lists.netfilter.org, lwn@lwn.net,
	netdev@vger.kernel.org
Subject: [ANNOUNCE] iptables 1.8.13 release
Message-ID: <aaeMFWURL-6YWIkz@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+j7gPogMzyv6nJsr"
Content-Disposition: inline
X-Rspamd-Queue-Id: BE9551F97CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10944-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action


--+j7gPogMzyv6nJsr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

The Netfilter project proudly presents:

        iptables 1.8.13

This release contains the following fixes:

* Revert "libxtables: refuse to run under file capabilities",
  which breaks Docker.
* Fix compilation warning with strchr() and const.

Upgrade from iptables 1.8.12 is recommended.

See changelog for more details (attached to this email).

You can download this new release from:

  https://www.netfilter.org/projects/iptables/downloads.html
  https://www.netfilter.org/pub/iptables/

To build the code, libnftnl >= 1.2.6 is required:

  http://netfilter.org/projects/libnftnl/downloads.html

In case of bugs and feature requests, file them via:

  https://bugzilla.netfilter.org

Happy firewalling.

--+j7gPogMzyv6nJsr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="changes-iptables-1.8.13.txt"

Florian Westphal (1):
      Revert "libxtables: refuse to run under file capabilities"

Pablo Neira Ayuso (1):
      configure: Bump version for 1.8.13 release

Rudi Heitbaum (1):
      src: fix discards 'const' qualifier


--+j7gPogMzyv6nJsr--

