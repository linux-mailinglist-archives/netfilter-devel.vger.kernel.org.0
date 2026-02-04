Return-Path: <netfilter-devel+bounces-10616-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNqNHvpwg2mFmwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10616-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:16:58 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9787EA105
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BE063018B35
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B772D6E7E;
	Wed,  4 Feb 2026 15:40:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6B28D8D0
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Feb 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219654; cv=none; b=V6cR8x+Nhklo/dqh7uzOdJUs4f6G95c2kaX1uQXHfahavQADxaj2+ONeXbWUmqeUCOcHtgWJ+PURpt1+8KJoSwEYOYLebpcS5OnvyNSSB/8Y/oeJsmvhrP8FY4jasrjBIKlh23lfntf9EQe0hPZlNdpHdX3cKfKrs+Fq12YaCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219654; c=relaxed/simple;
	bh=InAW7YHG6cdwNuNe0ky7Dbw7LiAq1n8bggffosa1KKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6+cSHL1oMw/e/Oyo8oCH1R11mkWPIyl4BK63mNN1jijTObU8FdMp532UVEv1G6k2RlLPf6xiJBOsJGKpkcGSS/83Eh8G0SipTAUS+jSDSjLUZSNFs/ZJDRkEB0ZrfPV09BCisY0SohJwXR1ZrBd1DSlUzY7lgo1UNwsNNSL+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4BC176033F; Wed, 04 Feb 2026 16:40:52 +0100 (CET)
Date: Wed, 4 Feb 2026 16:40:52 +0100
From: Florian Westphal <fw@strlen.de>
To: jeremy@azazel.net
Cc: netfilter-devel@vger.kernel.org
Subject: Bitwise boolean operations with variable RHS operands
Message-ID: <aYNohGL7fPQtVZfC@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10616-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: D9787EA105
X-Rspamd-Action: no action

Hi Jeremy

This is a note to let you know that I've marked your old patches
that were remaining in the patchwork backlog as 'archived, deferred'
(a few were marked as 'accepted').  AFAICS some of the features were
applied already.

If there is anything missing, please feel free to rebase and resubmit.

Thanks!

