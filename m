Return-Path: <netfilter-devel+bounces-10820-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL1iLhvXmGl+NQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10820-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Feb 2026 22:50:19 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389516B10F
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Feb 2026 22:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF73D30036F0
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Feb 2026 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B962302779;
	Fri, 20 Feb 2026 21:50:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from osnlsmtp01-01.prod.phx3.secureserver.net (osnlsmtp01-01.prod.phx3.secureserver.net [50.63.11.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF712DC323
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Feb 2026 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.63.11.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624204; cv=none; b=LbzPcptqdDYwYNYUJo8C6GCeoH1MAlrYOVTCL4vaZ5MRqp7JCsgUgtJIHyUjvJfALaNZoQBUeRfRkgfL6AbIZBmF4Buc0dkZZ5ACuXjXl0Zfnv1LhzctxckLFLZrTFI2CIQwSENeGwACd2d2snHQKpuy7cwGl5yrKio5f3mlC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624204; c=relaxed/simple;
	bh=dRiuz8pAh3AiRiDmOaW4zH+hQsS3t/EgMFDKdTLCkZQ=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=QJhcd64+3YzfiMcepsRX0OFxdEC3z8cGCgbxWJeGg5D+r6JXeXYjHmDgXeoxELYkml5jQQAIJ0f5ZRm5HeSJKn7yPdYgO1hz4BUP9WVGwTTnFJfTPTtFs82GvEmhDuUfsrRmWh84qTz4/mO6m441SxMb5cTi9V9dwQiPMbOEkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=autodiystuff.com; spf=pass smtp.mailfrom=autodiystuff.com; arc=none smtp.client-ip=50.63.11.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=autodiystuff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=autodiystuff.com
Received: from p3plzcpnl505327.prod.phx3.secureserver.net ([107.180.118.250])
	by : HOSTING RELAY : with ESMTPS
	id tYFav99IVCd7itYFavS3bk; Fri, 20 Feb 2026 21:41:26 +0000
X-CMAE-Analysis: v=2.4 cv=e8Osj6p/ c=1 sm=1 tr=0 ts=6998d507
 a=G2IjUgO45E0x6ghgta+12g==:117 a=G2IjUgO45E0x6ghgta+12g==:17
 a=xqWC_Br6kY4A:10 a=Nx2JMdyiJPIA:10 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=Duki3n1T0_7TFthV-VsA:9 a=CjuIK1q_8ugA:10 a=jfQmcWBtuV-grpLkH97o:22
X-SECURESERVER-ACCT: epao1234
Received: from [::1] (port=39734 helo=p3plzcpnl505327.prod.phx3.secureserver.net)
	by p3plzcpnl505327.prod.phx3.secureserver.net with esmtpa (Exim 4.99)
	(envelope-from <mb8@autodiystuff.com>)
	id 1vtYFZ-00000006dnU-0dmT
	for netfilter-devel@vger.kernel.org;
	Fri, 20 Feb 2026 14:41:26 -0700
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Feb 2026 14:41:25 -0700
From: mb8@autodiystuff.com
To: netfilter-devel@vger.kernel.org
Subject: Netfilter CPU Cycles
Message-ID: <28545c101b8fb76bb1382ed2abc46890@autodiystuff.com>
X-Sender: mb8@autodiystuff.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p3plzcpnl505327.prod.phx3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - autodiystuff.com
X-Get-Message-Sender-Via: p3plzcpnl505327.prod.phx3.secureserver.net: authenticated_id: mb8@autodiystuff.com
X-Authenticated-Sender: p3plzcpnl505327.prod.phx3.secureserver.net: mb8@autodiystuff.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-ENTITLEMENT-ID: c8bd992a-a81d-11e5-a352-842b2bfb08b1
X-CMAE-Envelope: MS4xfF6t4PMYbJ2mN4axUkHTBC2hXNJMxoXse10vdXODxSA+QS5+7/43N2Fv+qGYSgp8q0PnHPNc/6sDAk3ExIqGtqQaw17CWEuV4dIRUFP1jINgm1j8Qj/3
 qNXX+SXs0zPqPGAigD5/Soj4tVdcMj8UFx3IZ2qM5I6qf5x0HrzZCjZBZFVAGuX6dtCCwUVpBYGicE2IGhHdRCB5kWVeYUmKGMI3kjKrOc54Chqixm/jl1lQ
 yrfSNuEep6AhRqysWx5c/g==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[mb8@autodiystuff.com,netfilter-devel@vger.kernel.org];
	HAS_X_SOURCE(0.00)[];
	TAGGED_FROM(0.00)[bounces-10820-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[autodiystuff.com];
	HAS_X_AS(0.00)[mb8@autodiystuff.com];
	MIME_TRACE(0.00)[0:+];
	HAS_X_ANTIABUSE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_X_GMSV(0.00)[mb8@autodiystuff.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,autodiystuff.com:mid]
X-Rspamd-Queue-Id: 3389516B10F
X-Rspamd-Action: no action

When a hook is running (iptables etc) and there are no rules associated 
with an interface (eth1), does Netfilter in kernel still burn cpu cycles 
to know there are no rules? Does this behavior change if eth1 is promisc 
with no ipv4/v6 vs having assigned IP?

Thank you,
MB8

