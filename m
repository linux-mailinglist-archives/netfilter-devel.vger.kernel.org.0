Return-Path: <netfilter-devel+bounces-10627-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHnTKU69g2mqtwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10627-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 22:42:38 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25500ECD12
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE28B3017065
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6772395DA5;
	Wed,  4 Feb 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="kaPw3xqy"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC1395242
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Feb 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241349; cv=none; b=LIi+pe6I0CCxJVavSKoqDog1a1NJud4WmSaAxDBrd4VOrvMC9yQK9cOcrzEbtv2XM7lXCpnuGnmYpoFQU5K8E7wgt0TuC6c+EGqIOXMltjPNM9GwJIOKHt9AVTAP+Ep8Xj907EbNkiyia1C5qDCPJma0+K70WDtsxAtrg9/Drtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241349; c=relaxed/simple;
	bh=rYLCoqFJS3MJ2oEnu2Y/661c07xvXs5RLoVzDldH6go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/J63d9Ed9f+uZby1RZNvBL29wj7N4ywQq6sTyE9iIZtQUUp0WLgrWb5st1Z+RjHrHlsdKv6NfjoDQwU4Z6CSuSbXOwnbKJmyePBa9RTYKU7o4d7eGpgvRmqWZisVjzylG+YVx4eyC6nF1zhM07O21XJlw7AgUHg2WyqoksPw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=kaPw3xqy; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C5666607ED;
	Wed,  4 Feb 2026 22:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770241345;
	bh=RCL0IHWA/dwNN83tNIvRERy9IQPN3jg36EHIb+gTV54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaPw3xqyBzGMBJYZ79g5ucOyVyZKFWR2PcBel244nywsNfAIbkJeToZq9CGAWTZM0
	 J9qI59ztp8KqdR9l2yOiYfZ+MIpKa1pcxKuhAvdwUcIy5STUQ6/S5mTCErgOhH+gNI
	 N8C4z84XLb3/MXrImGuZIcNaL7ZZjuYmmhQUTA9h0OoYa1z9EQOHenMRHdiYlwCCw5
	 edsPoBYirXnXOzyOJ6CRIPpwdrbn2dJBt1i16tzrR/28iBbRy98lYOD4Dh65YecCdW
	 jBZg34VBEvV07tgaOXy6g5/BRt/RCbB3e8QvLU1/HLNdBPjhiFh0Jxwk1caI6eX6BY
	 tdsyeQwJeyMGA==
Date: Wed, 4 Feb 2026 22:42:22 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Brian Witte <brianwitte@mailfence.com>, kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org,
	syzbot+ff16b505ec9152e5f448@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 nf-next 2/2] netfilter: nf_tables: serialize reset
 with spinlock and atomic
Message-ID: <aYO9PrZ1Vx1dHu6-@chamomile>
References: <aYJ0h5y-KZ29F99g@chamomile>
 <20260204175809.5703-1-brianwitte@mailfence.com>
 <aYOLBSdHzVUHLPXR@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYOLBSdHzVUHLPXR@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-10627-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel,ff16b505ec9152e5f448];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 25500ECD12
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 07:08:05PM +0100, Florian Westphal wrote:
> Brian Witte <brianwitte@mailfence.com> wrote:
> > On Mon, Feb 03, 2026 at 11:19:46PM +0100, Pablo Neira Ayuso wrote:
> > > Maybe this so it covers for get and dump path?
> > >
> > > static struct nftables_pernet *nft_pernet_from_nlskb(const struct sk_buff *skb)
> > > {
> > >         struct sock *sk = skb->sk ? : NETLINK_CB(skb).sk;
> > >
> > >         return nft_pernet(sock_net(sk));
> > > }
> > >
> > > in case it is worth to skip the unique nft_counter_lock below.
> > 
> > I have v5 ready with Florian's global DEFINE_SPINLOCK approach:
> > split into 3 patches (revert, counter spinlock, quota atomic64_xchg),
> > with nft_counter_fetch_and_reset() wrapping fetch+reset under the
> > lock so parallel resets can't both read the same values. Tested and
> > working.
> 
> Thanks.
> 
> > Before I send: should I go with the global spinlock, or would you
> > prefer the per-net lock via nft_pernet_from_nlskb()? Happy to do
> > either.
> 
> I don't think the nft_pernet_from_nlskb() will work as-is, for the
> get requests the target skb is allocated via alloc_skb() and I don't
> think the control block is initialised to hold the origin netlink query
> sk.

This is GET path:

static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
                                  struct sock *ssk)
{
        int ret;
        struct netlink_sock *nlk = nlk_sk(sk);
 
        ret = -ECONNREFUSED;
        if (nlk->netlink_rcv != NULL) {
                ret = skb->len;
                atomic_add(skb->truesize, &sk->sk_rmem_alloc);
                netlink_skb_set_owner_r(skb, sk);
                NETLINK_CB(skb).sk = ssk; <---------------------
                netlink_deliver_tap_kernel(sk, ssk, skb);
                nlk->netlink_rcv(skb);
                consume_skb(skb);

