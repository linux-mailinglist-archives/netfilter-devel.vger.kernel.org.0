Return-Path: <netfilter-devel+bounces-11116-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMONMPo5sWkLswIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11116-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 10:46:34 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2652611D9
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE20A304274A
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 09:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE63AD52C;
	Wed, 11 Mar 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="j6ggvZyG"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AB2BEFE7
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2026 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221705; cv=none; b=eohMzVFP6tQpXxY2x37OqQD4Z8kGVFtBzJjamzAeXWKmx6JeUatCkWQKzRNubphqCC0/abT6clRFk6RWohvfBuBfDukGIbEmddpoyFIS9NKcaLK8yOgUNQpurZGvk3yHcUole6HkN9oJ0ZD8z2boUSjkerfrymQVGwVqQ84G6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221705; c=relaxed/simple;
	bh=Pe2nqGype9qhM0z3mCGo8xexBNrZf0xMktl390BX0D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZp6uN8TjEQ7kFjoWUjVk30TYqMUrJxg6fUd2929RP6lUZlRYwUJCcM5hlCsVjklo01/C0gqFnhEcAcGLXH/iUGc6jptbrghA3oa+yc2j4bE8I66SCh4tcWkFw0Vh8KLzJnzmcQpS5IGzyr3xCbOxaqp2lw0gFNXGCawPz8OaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=j6ggvZyG; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7076E602B4;
	Wed, 11 Mar 2026 10:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773221702;
	bh=rFNsuahz/WA9vb+hRzr93kPXkIzQXv8DT8ZZrBKUcIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6ggvZyGZmRAxBREIUgNKAUrLxIl6pU/lxyiaY2q7PL15IHSyRCkfTz5ncKVnGkqa
	 n/tfnxKISP0pRRP0aMraZfeQKye7s3wZR8Nxd9JRk8HwNsJj7rdo/4SKUW2/zJz+cq
	 XTqyZuxwb4gvRy7Rbgq4F6BBZvwLrb8/24OQmlACgxygg1itI2joEogvSl/VZa67D0
	 n0AvevjIdgkzdJVH5bo4UplFKWzOZYlCcZNp6z8SQgXWQ9BbjMfk1BkauQTYBUHUnj
	 sV1dmpCTx3aH1dcVVBGTfOmR4ORajx8TIhTDfa0qq7h6yJgd2xEFAhAM98Q0fTHK4T
	 hjPTvcUIOIx6g==
Date: Wed, 11 Mar 2026 10:34:59 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/5] cache: Respect family in all list commands
Message-ID: <abE3Q6E9eZEm4-DZ@chamomile>
References: <20260310231115.25638-1-phil@nwl.cc>
 <20260310231115.25638-3-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310231115.25638-3-phil@nwl.cc>
X-Rspamd-Queue-Id: 5C2652611D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11116-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 12:11:12AM +0100, Phil Sutter wrote:
> Some list commands did not set filter->list.family even if one was given
> on command line, fix this.
> 

Fixes: a1a6b0a5c3c4 ("cache: finer grain cache population for list commands")

> Signed-off-by: Phil Sutter <phil@nwl.cc>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

