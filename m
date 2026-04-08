Return-Path: <netfilter-devel+bounces-11706-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NrBLM2o1Wlf8gcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11706-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 03:01:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D23B5CDD
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 03:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74FA300463C
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A583290C2;
	Wed,  8 Apr 2026 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCTzbAIb"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF243314DE;
	Wed,  8 Apr 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610056; cv=none; b=AQhrG2inBjBVYBpdoRpdR8hhEijhlpIed7U8UOqWKsTAS9ZwPDwYPTEVrp7LozDZkqbvrybPaglpFBGSA4yErG7WdeO5KGEMQVozFIYo06BFMty8zu6+4m/wDjy0ZmGki5VfgTGodUmDBBq4cwO85C52DHHWMQvLSGXX71qBDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610056; c=relaxed/simple;
	bh=YASJzz2Ts/JJ3gSO0szgf0KjWGJjSJ5Igch4+9QITig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIu6LdJls918gnkjKB93HSXOgT93xJ1WYQwHz2amICXfwDqks/CPKxzIS1k5huQjQcl8QIa2aDSaGhCml6pCHZjrDMNINUvwQzT0Cf2cmrkV3QO12zrTtd84GtLW3YS4Zf7WCLP33sflJUJahEdCI5uKdoahC3nARCKdzP6KcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCTzbAIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7240DC116C6;
	Wed,  8 Apr 2026 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610054;
	bh=YASJzz2Ts/JJ3gSO0szgf0KjWGJjSJ5Igch4+9QITig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WCTzbAIbXhob6NOVBkHMxKJfzB2gCPeE/iIf5ceHXumenjbcuoJORpCyNaN4lrKne
	 KU644YeWnph2VVUcFKWl5i/o462BRVNR2rTGMgrYSwxa11uF3k+qgPPrzZNsRxCDrV
	 MKXy1YU+JWpBqCF2BbuzSY5drssMd5JjRudTWQe4dIMKCD9QYCq68D6qnoMIlkiswK
	 6bPEnsq06aWKfFSrMloKpApFY9HR9X/CyEzAqceuzOV4Iuie7HELI3KadY2pF+NgNz
	 bs0FsLj228DMM9NlUlG0HYEqPfI1COeY3PsoSYQQlT2z1XBVXQMlN+/XO0n8grb8Ze
	 SatuJMlp9edaw==
Date: Tue, 7 Apr 2026 18:00:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netfilter-devel@vger.kernel.org>, pablo@netfilter.org
Subject: Re: [PATCH net-next 00/13] netfilter: updates for net-next
Message-ID: <20260407180053.1fb5ffc4@kernel.org>
In-Reply-To: <20260407141540.11549-1-fw@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-11706-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 831D23B5CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 16:15:27 +0200 Florian Westphal wrote:
> netfilter pull request nf-next-26-04-07

IIUC plan is to send v2, LMK if I misread

