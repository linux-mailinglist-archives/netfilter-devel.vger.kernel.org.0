Return-Path: <netfilter-devel+bounces-10546-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJVNI2Q+fmk6WgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10546-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 18:39:48 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE1C3598
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 18:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D18A8301FF93
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDDD35B624;
	Sat, 31 Jan 2026 17:39:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703635B151
	for <netfilter-devel@vger.kernel.org>; Sat, 31 Jan 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881186; cv=none; b=SPmvclVFxdd3tD80+IjLHJEARlFMn2WJlthnZ0XSFlYJN22yI6Nwv4TnmQVAqXae3IQ16pWMr/73OYrpaFEQBh9FiAcEcI73mPhwuvA1UC+qLRTJEhn/rotiq79rKgoUZAjGP4kjFLZ9p855KaS4+NPrELj+PYlyt3BHF/uvykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881186; c=relaxed/simple;
	bh=/yY3tg+/ZjV4/uXkNlvEa9FFKJUe7l2JuKESq2P14S0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MJtepATFBuOKHdel+vwV2gKhe3kDbYaPwkDo2tSoJEPowYsjapw89JtIbQd8jlPrfqVVmFaC/sExuf193b/YCeVcikXV68al2zCI96v7YSfK3FkiVFQ57ny2XV0WSsxX58PCKYvR5HJZ3D2YZiwC63ms/ktP8nzxG6Q6Tf2NjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 8355010038AF19; Sat, 31 Jan 2026 18:33:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 830DB1108EE4A2;
	Sat, 31 Jan 2026 18:33:45 +0100 (CET)
Date: Sat, 31 Jan 2026 18:33:45 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Ingyu Jang <ingyujang25@korea.ac.kr>
cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, fw@strlen.de, 
    phil@nwl.cc
Subject: Re: [Question] Dead code in xt_register_matches/targets()?
In-Reply-To: <20260131145516.3289625-1-ingyujang25@korea.ac.kr>
Message-ID: <o4n85p54-s836-5qo6-881n-45o8so7p4q89@vanv.qr>
References: <20260131145516.3289625-1-ingyujang25@korea.ac.kr>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10546-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[inai.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ej@inai.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35FE1C3598
X-Rspamd-Action: no action

On Saturday 2026-01-31 15:55, Ingyu Jang wrote:

>I noticed that in net/netfilter/x_tables.c, the functions
>xt_register_match() and xt_register_target() always return 0.

See commit 7926dbfa4bc14e27f4e18a6184a031a1c1e077dc
and the state prior.


