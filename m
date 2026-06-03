Return-Path: <netfilter-devel+bounces-13026-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQ8XHheOIGoS5AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13026-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 22:27:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA163B1B6
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 22:27:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=a15OCJC3;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13026-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13026-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30603034B2A
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBC37FF70;
	Wed,  3 Jun 2026 20:23:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0D18871F
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 20:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518236; cv=none; b=XuUdgWlSWH15/BqO26q8eIHVJX14P9oCsOOeZBmbWRzCPv7FtO49CXEZS3Cdw0f55a24WG63HKPQHYoPOwNYu+OA30clnsN1/k+PBjrs0f+MAy2I842tTBu+5ZjUD0ESD1Gfe0JRqrX7X6D7jtZP2o/+p/Ow0CwIT5gbMF96QW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518236; c=relaxed/simple;
	bh=rnMuLVdW3ly0QXhFPw483UUEH3d37EMyFi28UQVm8w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxue15Kxa33+1v9K8berXkFU1NjFL0oR2tPFe7hDggmGw2N3SWZqTwy88FdLIz9rqIg+uD6rVu7ulzqdPwk018HP2lhVeMTNYBgE+3XRyQN9lHj0l/EN4QGxaVT7+iv5g5dsBrxpPw7Qb3SEOaXXwfCSRmovG4MwJuJ91xIzgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=a15OCJC3; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DBgz1ROyjc78T+apjTeJsC4JgZM0zEsMdLqB0Qxk4AY=; b=a15OCJC3OMG5/KNm1YU1Eu6s6g
	lH7afHJbp2zw9WWDFOtkzlayCClBIA1hdSkI118/Zb0oHATG1CYcDyFB+JysOMrog2yy6c9FysDDE
	+eQUipmOamfEqRdoTTGxDTOZYkiB/EZKWtGbByxA3dFh1q3oxPKc49hkjHq5TTz6zCUtLIUWLJLOB
	Bnq77a+Mk6snW3+rmr/a+YxReDoDr4f2uQXYYD6BhYXzf5q201+sa+7XAUpUMADxknHOD4MvJvxL3
	k2MXztM7V4OIPHsm5QVmSGc45JKtmk1sZmOss4ng+PcMZjcgwVP+KzhJivf5BEjLOJHmkS4+CZqY1
	W+3FBZIw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wUs80-000000003mm-1VN4;
	Wed, 03 Jun 2026 22:23:52 +0200
Date: Wed, 3 Jun 2026 22:23:52 +0200
From: Phil Sutter <phil@nwl.cc>
To: Jan =?utf-8?Q?Ko=C5=84czak?= <jan.konczak@cs.put.poznan.pl>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] parser_bison: on syntax errors, output expected
 tokens
Message-ID: <aiCNWPqfVbTNIKI6@orbyte.nwl.cc>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13026-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	FORGED_RECIPIENTS(0.00)[m:jan.konczak@cs.put.poznan.pl,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6AA163B1B6

Hi Jan,

On Tue, Jan 20, 2026 at 06:33:38PM +0100, Jan Kończak wrote:
> >  v2: prefer stdio (fprintf+memopen) vs. manual realloc of a cstring
> >  buffer, align more with nftables coding style.
> > 
> >  I'll apply this unless there are any objections.
> 
> None on my side; I should have resubmitted the patch corrected of basis
> of your comments, but I simply did not find time yet to look into that.

Since parse.error=custom is not supported by bison < 3.6, this patch
breaks nftables compiles on older systems (RHEL8 for instance). Sadly I
haven't found a way to change the define based on configure results
(checking bison version is easy via AX_PROG_BISON_VERSION). On one hand,
bison's declaration section does not support preprocessor macros. On the
other, conditional setting of AM_YFLAGS variable in Makefile.am is
problematic (and breaks tests/compile for me).

Do you perhaps know how to solve this? For reference, what I tried was:

|   AM_YFLAGS = -d -Wno-yacc
|  +if BISON_CUSTOM_ERROR
|  +AM_YFLAGS += -D parse.error=custom -D parse.lac=full
|  +else
|  +AM_YFLAGS += -D parse.error=verbose
|  +endif

And then drop the two defines from parser_bison.y.

Cheers, Phil

