Return-Path: <netfilter-devel+bounces-10599-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPH/Mch2gmm+UwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10599-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 23:29:28 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A3DF41D
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 23:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD9030CA65F
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Feb 2026 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D4341ACC;
	Tue,  3 Feb 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="CUCUS9LJ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A525DB0D
	for <netfilter-devel@vger.kernel.org>; Tue,  3 Feb 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157205; cv=none; b=Uw3yqFSajYvtKp/vkxcDgIrwmAobMjeJ6PxsNcwTeoPq/xnH6Eq2cMEUCW1caSxSpphuIaWdbj8PtvPlraKLIhybjc/5Ndte6Y2I1xEp7F/dz6Sqgsat7mXqiwUXcuFtEVUzPe5+ymU2pX1E2lSsTjwrYAngYKmjAtrm9nfCDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157205; c=relaxed/simple;
	bh=yj4lUNKPyHuSG6QUH0QCcxt3TYhV29drIP37GxJ9Drc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbvunnCBK+sJSbagOM5yx6rmRftUtdcivgKDjw6tZeapS/jdD7b0DMREvJO6Lx7L7LJm48gXa4Rp+UF17Ivxbm3SjIygcTR6MdB23oOWZOmATc2MbmfeO8BjiccafEgOQetZKFks1KEohD+xbFfY3yBPj2IklsavAGqyKTTTMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=CUCUS9LJ; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 57C6C6017D;
	Tue,  3 Feb 2026 23:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770157194;
	bh=revFz9YVRatl2If5GH1pcyJYbjMAR87ihy/Ozu96QUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUCUS9LJU8cTgoKfLB+r9NLw3+QlvC6GhkQ31cuofPCdb2oVViWF62o80nzAb6qgN
	 OI0AZh6VV3JgMTuSHH3a2gLulx6ploGgTVbcANcQ6PIzEdgolRNXRVmivMUIZp9XgO
	 wOqydSI1BE7tze8ymf11We0Yq+0eCZnL0C3nDtvcl6oEsuqe9GB+iG7jPZj3YJgsXk
	 r7/67sKNJbOa3LfZw8nBaSAHfyPKgyPgP7Ct0JuSmyMiSrTe7Z1VHDNZuzC02eWLFI
	 Le/Ry+SBPmmt0vOwN0kQXn5NZO3MhuJdWcXEZEQ2GoHIfHFLpKZ/uAqD6sxR4RD2NC
	 /V4M4Y7USm0FQ==
Date: Tue, 3 Feb 2026 23:19:51 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Brian Witte <brianwitte@mailfence.com>, netfilter-devel@vger.kernel.org,
	kadlec@netfilter.org,
	syzbot+ff16b505ec9152e5f448@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 nf-next 2/2] netfilter: nf_tables: serialize reset
 with spinlock and atomic
Message-ID: <aYJ0h5y-KZ29F99g@chamomile>
References: <20260203050723.263515-1-brianwitte@mailfence.com>
 <20260203050723.263515-3-brianwitte@mailfence.com>
 <aYHvYiDKHVdOoSeg@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHvYiDKHVdOoSeg@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10599-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel,ff16b505ec9152e5f448];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,mailfence.com:email]
X-Rspamd-Queue-Id: 2C2A3DF41D
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:51:46PM +0100, Florian Westphal wrote:
> Brian Witte <brianwitte@mailfence.com> wrote:
> > Add a dedicated spinlock to serialize counter reset operations,
> > preventing concurrent dump-and-reset from underrunning values.
> > 
> > Store struct net in counter priv to access the per-net spinlock during
> > reset. This avoids dereferencing skb->sk which is NULL in single-element
> > GET paths such as nft_get_set_elem.
> 
> Ouch, sorry about making a wrong suggestion.  I did not consider that
> this reset infra also works via plain netlink requests rather than just
> for netlink dumps.

Maybe this so it covers for get and dump path?

static struct nftables_pernet *nft_pernet_from_nlskb(const struct sk_buff *skb)
{
        struct sock *sk = skb->sk ? : NETLINK_CB(skb).sk;

        return nft_pernet(sock_net(sk));
}

in case it is worth to skip the unique nft_counter_lock below.

[...]
> +/* control plane only: sync fetch+reset */
> +static DEFINE_SPINLOCK(nft_counter_lock);
> +
>  static inline void nft_counter_do_eval(struct nft_counter_percpu_priv *priv,
>                                        struct nft_regs *regs,
>                                        const struct nft_pktinfo *pkt)

