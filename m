Return-Path: <netfilter-devel+bounces-10352-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK1DNs8KcGlyUwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10352-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 00:07:59 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA94D81F
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 00:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2677B90C84A
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BB03BC4EF;
	Tue, 20 Jan 2026 22:40:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83943A9011
	for <netfilter-devel@vger.kernel.org>; Tue, 20 Jan 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948803; cv=none; b=EEDBLk75BgmFqOZfLfMDBtYyqsUviIl6NDLJqcNm58gXIb83UuDtbXKpTcH35HCn4OX93L7MwGHQpTDk+0MoR9rMZHUidDJL6twc7v5zwFu1w26gCMoJLuWkcSr4Bj7D/OUbWb6l7QXHZFy1XBocZGyA8b2qj6blwh0dd31yO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948803; c=relaxed/simple;
	bh=6dsYNrP9Kuhi6L4jWVnOTmZnOpc5F+p3Mr02Zzi1JT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4o+UgS0vIDzxGOunfQxOjWoXMD/RibAECR/hIG0t7Qst38wKjuTX40krl38tTR0P7XS6y1og1EkKPRNIjSU/qzBeZImXBvHdkv3TjJA/7vcGtqVYLOsBJVeOvUQ9MRzRhr/PD8feeNhIdM5V44ta13wTna3zXVpEeoiVonthQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 80841602AB; Tue, 20 Jan 2026 23:39:50 +0100 (CET)
Date: Tue, 20 Jan 2026 23:39:50 +0100
From: Florian Westphal <fw@strlen.de>
To: Jan =?utf-8?Q?Ko=C5=84czak?= <jan.konczak@cs.put.poznan.pl>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] parser_bison: on syntax errors, output expected
 tokens
Message-ID: <aXAENobZWNLN-T0p@strlen.de>
References: <20260120122954.18909-1-fw@strlen.de>
 <22975780.EfDdHjke4D@imladris>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22975780.EfDdHjke4D@imladris>
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10352-lists,netfilter-devel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,put.poznan.pl:email]
X-Rspamd-Queue-Id: 95BA94D81F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jan Kończak <jan.konczak@cs.put.poznan.pl> wrote:
> >  v2: prefer stdio (fprintf+memopen) vs. manual realloc of a cstring
> >  buffer, align more with nftables coding style.
> > 
> >  I'll apply this unless there are any objections.
> 
> None on my side; I should have resubmitted the patch corrected of basis
> of your comments, but I simply did not find time yet to look into that.

Applied, thanks!
If you like you could follow up so that for

'create fable filter'
you get:
Error: syntax error, unexpected string, did you mean 'table'?
expected any of: synproxy, chain, ...

string_misspell_init() + string_misspell_update() should
do the trick.

