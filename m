Return-Path: <netfilter-devel+bounces-10603-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLOuDc+qgmkMXwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10603-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 03:11:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18DE0B5C
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 03:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 170893087364
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02E286D5C;
	Wed,  4 Feb 2026 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk7r6+gE"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49977273816;
	Wed,  4 Feb 2026 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170979; cv=none; b=iU4kI3aUCcD/QnoXejDQYfCnpksPQusWfswcbNnKSgd3k1qM899QTBdskU0z27SINfxrPLx5P4DOZTKa4z69zOArszAbGgJui5PH/aKmn3QfQO0NCeqEeFMaD3fRNfOuooHdlnyX2ExfBCpCG6LGD6NOI59AcK5DefQHkgb20kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170979; c=relaxed/simple;
	bh=XUyfb4wzf0dEgS+vltqrSUB4mrfJutQj0qg/Ca7kbYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/d+F/75kR86aVQww9tXQMmN/05v/FmYfRGfoBi/nYz45so6kLi8rcTv17lMhMa/guR34HwatNeYBbaMwMXPaZbIDMBh3pgt4ib12tvwJFei8xrqm/OdQjeCUiE5biA5jBaLdIn6LnrvJseAh5QqmVvrUeDEjyWyp+Pokj+vpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk7r6+gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55656C116D0;
	Wed,  4 Feb 2026 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770170978;
	bh=XUyfb4wzf0dEgS+vltqrSUB4mrfJutQj0qg/Ca7kbYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fk7r6+gEy7jVZ4EdqJYIy8OrETdUz6WJUYbVRlrN/PqXqMfKutwByH9aECOV/wp6A
	 mq5ObCK2U6P8fDWef/uZnPxEB3aCgPNy8COOZCsTxe6NZeasu7wTbrtZLPvWiMkNdK
	 BivszxGCOjJX3aRRjysiJiwJgukjTIL8cNhcl9Mp73YXlBEoJov1H9sfiwOqhCnkUH
	 likURp5XsC4Bt5i4azZcta1wFSh06hnOgPVE+P81nXLJbpIdtpf8x5E7H87WZk23fq
	 a4ifoX0tH0DTDxG22oflY3jmHZ2OG0prlN07DOtOB28NN1M9FZUGFWwLnZBw1hvvmU
	 fHL61ir6ugGBQ==
Date: Tue, 3 Feb 2026 18:09:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: anders.grahn@gmail.com, Pablo Neira Ayuso <pablo@netfilter.org>, Phil
 Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] netfilter: nft_counter: Fix reset of counters on
 32bit archs
Message-ID: <20260203180937.25219489@kernel.org>
In-Reply-To: <aYH-Mr0Hy7EfivBt@strlen.de>
References: <20260203134831.1205444-1-anders.grahn@gmail.com>
	<aYH-Mr0Hy7EfivBt@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10603-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,nwl.cc,davemloft.net,google.com,redhat.com,kernel.org,linutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF18DE0B5C
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 14:54:58 +0100 Florian Westphal wrote:
> I will apply this in the next days unless there is a NACK from
> netdev maintainers.

My $0.02 is that it'd be great to add a comment advising against the
use of the new helper, because normally stats shouldn't go backwards.
But I guess is equally obvious as it is hard to explain succinctly.
So ack from me.

