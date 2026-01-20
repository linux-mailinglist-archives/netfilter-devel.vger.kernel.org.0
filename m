Return-Path: <netfilter-devel+bounces-10332-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KF7GmjEb2lsMQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10332-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 19:07:36 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD5491B1
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B24E8071F1
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F01940F8FC;
	Tue, 20 Jan 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.put.poznan.pl header.i=@cs.put.poznan.pl header.b="eWHp5Hgq"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from libra.cs.put.poznan.pl (libra.cs.put.poznan.pl [150.254.30.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04F3382DC
	for <netfilter-devel@vger.kernel.org>; Tue, 20 Jan 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.254.30.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931042; cv=none; b=HNdd4wWqvqJvGAYlPuGEso85sPNABYVG9YwQY5/QO1YG/7v0Ve+MkUpyqxP+B4v+XMD7Hus7AurWEue/+0t+7B/nZOdu7V7TOxXebDZASJeslfNnr9jKfCyNqvm6cp6NHi2QGHB99AsuHxudHcTw0iVBUPhwF5SmyfHeEWV5Ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931042; c=relaxed/simple;
	bh=QH7vDJSSIhDsfj8O3naDi7GhX9f6WNTQc4VzBxXgT2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuQuQaL+cpz9ApX9jBZsDvEl+QvIIccGdPTs2AKmvf4hmEYcmoJBoRCq/pBMds03femWjGJGZaYfzSo3iNBAAquIqijHDL0HS8Mj0+XYzMokSfi1ak8V6mwC2Fdk4pIkr3XHEVMCjLGxaCT66TVRcMuxE/upnJq0RaHNl/cTmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.put.poznan.pl; spf=pass smtp.mailfrom=cs.put.poznan.pl; dkim=pass (2048-bit key) header.d=cs.put.poznan.pl header.i=@cs.put.poznan.pl header.b=eWHp5Hgq; arc=none smtp.client-ip=150.254.30.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.put.poznan.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.put.poznan.pl
X-Virus-Scanned: Debian amavis at cs.put.poznan.pl
Received: from libra.cs.put.poznan.pl ([150.254.30.30])
 by localhost (meduza.cs.put.poznan.pl [150.254.30.40]) (amavis, port 10024)
 with ESMTP id h-KRf1uAZX9O; Tue, 20 Jan 2026 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.put.poznan.pl;
	s=7168384; t=1768930319;
	bh=QH7vDJSSIhDsfj8O3naDi7GhX9f6WNTQc4VzBxXgT2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWHp5HgqbCcP91eASXvkQRcyRzM2CGxNTZJzCbFliwlRPtCW9+7opYG0dbforAr2K
	 ITDDzLNTGaaGwgzNMzYVv9iaXnT0CQ2A/yATN88+EbXbVKHiePzRO2MRuIFcnr5DNk
	 E0xCME0iS+cZ8IBvRM/345hxNJfsDlbOWEaYXgeqDSc93SHaqRXNRjn5U9owfrAmOI
	 wzLKjHMZat1Wur2jlsGFXCa3uVOLXKacWqrteAQn2/oiPfyuUDY0AWCDLVVIojB+t1
	 U8EUFCsUSGket7kRTp6hgX7a376bLOxBLBNzAerHvWVlCkVrJmBUpxuaM7D1HEXEMC
	 7XvtMeYw5+GVg==
Received: from imladris.localnet (83.8.100.122.ipv4.supernova.orange.pl [83.8.100.122])
	(Authenticated sender: jkonczak@libra.cs.put.poznan.pl)
	by libra.cs.put.poznan.pl (Postfix on VMS) with ESMTPSA id CBFCD64E32;
	Tue, 20 Jan 2026 18:33:50 +0100 (CET)
From: Jan =?UTF-8?B?S2/FhGN6YWs=?= <jan.konczak@cs.put.poznan.pl>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] parser_bison: on syntax errors,
 output expected tokens
Date: Tue, 20 Jan 2026 18:33:38 +0100
Message-ID: <22975780.EfDdHjke4D@imladris>
Organization: Institute of Computing Science,
 =?UTF-8?B?UG96bmHFhA==?= University of Technology
In-Reply-To: <20260120122954.18909-1-fw@strlen.de>
References: <20260120122954.18909-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[cs.put.poznan.pl:s=7168384];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10332-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[cs.put.poznan.pl,none];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[cs.put.poznan.pl:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.konczak@cs.put.poznan.pl,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cs.put.poznan.pl:dkim]
X-Rspamd-Queue-Id: 06AD5491B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>  v2: prefer stdio (fprintf+memopen) vs. manual realloc of a cstring
>  buffer, align more with nftables coding style.
> 
>  I'll apply this unless there are any objections.

None on my side; I should have resubmitted the patch corrected of basis
of your comments, but I simply did not find time yet to look into that.




