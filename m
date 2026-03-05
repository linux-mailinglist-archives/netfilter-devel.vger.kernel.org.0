Return-Path: <netfilter-devel+bounces-10985-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OFYAGpmqWlN6wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10985-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 12:18:02 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248221078A
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A12E30B6F16
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2026 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4A43845AF;
	Thu,  5 Mar 2026 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Qf3/GzwK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF737D126
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Mar 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709122; cv=none; b=YYtcgU9LzIxECRuGIRNyPVUNA7ZTzULm6IHaoxxrkC5fAYYodrvobCzfz1YwwVYH51eGyHre4TcQCVUEgx0BMQ20UqodoXlftLasE0oL1mZgcz+DauWQsiE+IrVSHIBdXoPpk6BL7fqN1VqbpdbJ82lt21tH3F49zlcRxIy4mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709122; c=relaxed/simple;
	bh=QiHXGt/R2IBO3lhPhqyX/lAOxpBjdFmDB5kvkFrOxLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUvsq8ILm3wJbqlfWQPAfAJbX5KLTnpx2TF4Nj0RWAt3kV/gLXxqFiJOGVkZ3nf3BTxC+nSj9MeNpVqankIgZkp5hauTvb9HhpVzrh+asRkLakmFn7ECOqL4a55aw5U4Id8+jEhTh28DERmnmPPVxXVnvvVDDjaLE1fhLQKUUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Qf3/GzwK; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iBYJuqixY4JkpOajquOQxZXMrv+nSJlW8Om/KA4GgmQ=; b=Qf3/GzwKHcw5UfXc7XX2dwAPRj
	Zt1/L/jRGz1LXkZ1qH1cH+jPuPcJJoESX2t84prPY8SIVoXRhIrbY1VnR8EkJXj/wsyvYmHV1scFh
	2GcYyGp75qMN/kFbyDbmHEk/JTPVCaGXOacoBhDOb7MEDV8BZeBCEQM8EqD85kHj29i61NRsAtE0U
	8J17H0q7sW5gXdiBJ8MzaMRGvBnwc7vsTE25Yd41ixc/bvLUElmggGTzCv/gyLz4eNyYZbm6igE58
	QST7wvv2QydP0Bk2nfog/SbP732v4mqjUsCNhEjQyV9yJr+Zu2ChNNBoNNVJUYOAguIK0QC36yuRF
	jbF53/uw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vy6cX-000000006sd-0LWu;
	Thu, 05 Mar 2026 12:11:57 +0100
Date: Thu, 5 Mar 2026 12:11:57 +0100
From: Phil Sutter <phil@nwl.cc>
To: Jeremy Sowden <jeremy@azazel.net>
Cc: Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH iptables] tests: iptables-test, xlate-test: use
 `os.unshare` Python function
Message-ID: <aalk_STwkHIwC4RY@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Jeremy Sowden <jeremy@azazel.net>,
	Netfilter Devel <netfilter-devel@vger.kernel.org>
References: <20260304181304.696423-1-jeremy@azazel.net>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304181304.696423-1-jeremy@azazel.net>
X-Rspamd-Queue-Id: 8248221078A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-10985-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	NEURAL_SPAM(0.00)[0.851];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,orbyte.nwl.cc:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:13:03PM +0000, Jeremy Sowden wrote:
> Since Python 3.12 the standard library has included an `os.unshare` function.
> Use it if it is available.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Patch applied, thanks!

We have the same pattern in nftables' tests/py/nft-test.py, could you
please send a patch for that as well?

Thanks, Phil

