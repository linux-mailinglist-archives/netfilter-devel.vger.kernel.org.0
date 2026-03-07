Return-Path: <netfilter-devel+bounces-11030-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /PAvLkdtrGmepgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11030-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 19:24:07 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13422D36D
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 19:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A03693025D25
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Mar 2026 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18840372677;
	Sat,  7 Mar 2026 18:24:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC017A2F6;
	Sat,  7 Mar 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907845; cv=none; b=LeD4/A0gWKXOBRlbIEq6LOCsFROxLqx4xYJ9YZze92N4v4cqc6a8S7bbUVPEznrIDF3CqZ1iKVND4Zxqpt3TLTl+IbfNOo3ElLFc13kH933QMbj/oSJD34msEv244IiYs9aEr5OVeHaZuaU/pE7h7cZ2hBhjJHAzPlw1rBsE6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907845; c=relaxed/simple;
	bh=EPCZ4ArqG/MUI5+2xe/0VPYA00dTt9Rg/JKVyDfs3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWMsXs7s++jdE6U8Q1iOkVWsYL1qapyJmkeBLXJC63+zpwH7okucM6fwm2k1HqeBHEyNR3lkJjGOaz9f8DSyXyidcL5fxxl8OtDbd5fqdjUnsoTHpMMxz4nESy4hyfs3nYObft/yCns3u6qMohBWsIx18cAs/EAgsZkELNZ4oV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D65B36077F; Sat, 07 Mar 2026 19:24:00 +0100 (CET)
Date: Sat, 7 Mar 2026 19:24:00 +0100
From: Florian Westphal <fw@strlen.de>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_conntrack_sctp: validate state value
 in nlattr_to_sctp()
Message-ID: <aaxtQA0BbpqTo5t1@strlen.de>
References: <aaxe43_A7rqHezJz@v4bel>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaxe43_A7rqHezJz@v4bel>
X-Rspamd-Queue-Id: 3A13422D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11030-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.388];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid]
X-Rspamd-Action: no action

Hyunwoo Kim <imv4bel@gmail.com> wrote:
> diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
> index 7c6f7c9f7332..cbee99be7b5e 100644
> --- a/net/netfilter/nf_conntrack_proto_sctp.c
> +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> @@ -612,6 +612,9 @@ static int nlattr_to_sctp(struct nlattr *cda[], struct nf_conn *ct)
>  	    !tb[CTA_PROTOINFO_SCTP_VTAG_REPLY])
>  		return -EINVAL;
>  
> +	if (nla_get_u8(tb[CTA_PROTOINFO_SCTP_STATE]) >= SCTP_CONNTRACK_MAX)
> +		return -EINVAL;

Like other, similar bug classes, I would prefer this to be solved via
netlink policy fixup.

